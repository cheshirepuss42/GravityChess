package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.*;

	public class BoardView extends Sprite
	{
		private var images:Vector.<Bitmap>;
		private var boardLayer:Sprite = new Sprite();
		private var piecesLayer:Sprite = new Sprite();
		private var selectionLayer:Sprite = new Sprite();
		private var threatLayer:Sprite = new Sprite();
		private var shifted:Boolean = true;
		private var scaling:Number;
		private var frameCounter:int = 0;

		public function BoardView(img:Vector.<Bitmap>) 
		{
			images = img;
			addChild(boardLayer);
			addChild(threatLayer);
			addChild(selectionLayer);
			
			addChild(piecesLayer);			
			piecesLayer.filters = [new GlowFilter(Colors.Grey, 0.7)];
			
			//make mask to hide shifting board
			var mask:Sprite = new Sprite();
			mask.graphics.beginFill(0xff0000);
			mask.graphics.drawRect(Constants.OffsetX,Constants.OffsetY, Constants.BlockSize * 8, Constants.BlockSize * 8);			
			boardLayer.mask = mask;			
		}
//----------------------------------------shift------------------------------------------------------------------------------------------//				
		public function startShift(points:Vector.<*>,threats:Vector.<Point>,board:Vector.<Vector.<int>>,flags:Vector.<int>):void
		{	
			var pts:Vector.<Point> = new Vector.<Point>();
			for (var b:int = 0; b < threats.length; b++) 
			{
				drawSquare(boardLayer, threats[b].x, threats[b].y, Colors.ShadowRed, 0.3);
			}			
			for (var a:int = 0; a < points.length; a++) 
			{
				pts[a]=new Point(points[a].x, points[a].y);
				drawPiece(boardLayer, points[a].type, points[a].x, points[a].y);
			}
			
			drawThreatLayer(new Vector.<Point>());
			drawPieceLayer(board, pts,flags);	
			addEventListener(Event.ENTER_FRAME, shift);
		}
		
		private function shift(e:Event):void
		{
			if (frameCounter <= Constants.FramesPerShift)
			{
				var d:Number = Constants.BlockSize / Constants.FramesPerShift;
				boardLayer.y = d * frameCounter;
				frameCounter++;
			}
			else
			{
				shifted = !shifted;
				boardLayer.y -= Constants.BlockSize;
				drawBoardLayer();
				frameCounter = 0;
				removeEventListener(Event.ENTER_FRAME, shift);
				dispatchEvent(new Event("shiftFinished"));	
			}
		}		
//--------------------------------------draw--------------------------------------------------------------------------------------------//		
		public function draw(board:Vector.<Vector.<int>>,selection:Point,targets:Vector.<Point>,threats:Vector.<Point>,flags:Vector.<int>):void
		{	
			trace("drawing...");
			drawBoardLayer();
			drawPieceLayer(board, new Vector.<Point>(),flags);
			drawSelectionLayer(selection, targets);
			drawThreatLayer(threats);
		}
		
		private function drawSelectionLayer(selection:Point,targets:Vector.<Point>):void
		{
			selectionLayer.graphics.clear();
			if (selection != null)
			{
				drawSquare(selectionLayer, selection.x, selection.y, Colors.Yellow, 0.5);
			}
			for (var a:int = 0; a < targets.length; a++) 
			{
				drawSquare(selectionLayer, targets[a].x, targets[a].y, Colors.Yellow, 0.3);
			}	
			for (var i:int = 0; i < 8; i++) 
			{
				drawRect(selectionLayer, i, 7, Colors.SoftYellow, 3);
			}
		}
		private function drawThreatLayer(targets:Vector.<Point>):void
		{
			//trace(targets.length,targets);
			threatLayer.graphics.clear();
			for (var a:int = 0; a < targets.length; a++) 
			{
				drawSquare(threatLayer, targets[a].x, targets[a].y, Colors.ShadowRed, 0.3);
			}				
		}		
			
		private function drawPieceLayer(board:Vector.<Vector.<int>>,skip:Vector.<Point>,flags:Vector.<int>):void
		{			
			piecesLayer.graphics.clear();
			for (var i:int = 0; i < 8; i++) 
			{
				for (var j:int = 0; j < 8; j++) 
				{					
					if (board[i][j] != Constants.Empty && !Constants.hasPoint(new Point(i, j-1), skip))
					{	
						drawPiece(piecesLayer,board[i][j], i, j,(j==7 && flags.indexOf(i)>=0));						
					}
				}
			}			
		}
		
		private function drawBoardLayer():void
		{
			boardLayer.graphics.clear();
			for (var i:int = 0; i < 8; i++) 
			{
				for (var j:int = -1; j < 8; j++) 
				{
					var b:int = (shifted)?i + j:i + j + 1;
					var col:int = (b % 2 == 0)?Colors.MiddleGrey:Colors.Grey;
					drawSquare(boardLayer, i, j, col);				
				}
			}			
		}
		private function drawSquare(layer:Sprite, i:int, j:int, col:uint,transp:Number=1):void
		{
			layer.graphics.beginFill(col, transp);
			layer.graphics.drawRect(i * Constants.BlockSize, j * Constants.BlockSize, Constants.BlockSize, Constants.BlockSize);
			layer.graphics.endFill();
			drawRect(layer, i, j, 0);
		}
		private function drawRect(layer:Sprite, i:int, j:int, col:uint,lineWidth:int=1):void
		{
			layer.graphics.lineStyle(lineWidth,col);
			layer.graphics.drawRect(i * Constants.BlockSize, j * Constants.BlockSize, Constants.BlockSize, Constants.BlockSize);
			layer.graphics.lineStyle(0,0);
		}		
		private function drawPiece(layer:Sprite,piece:int, i:int, j:int,flagged:Boolean=false):void
		{
			layer.graphics.beginBitmapFill(images[piece].bitmapData);
			layer.graphics.drawRect(i * Constants.BlockSize, j * Constants.BlockSize, Constants.BlockSize, Constants.BlockSize);
			layer.graphics.endFill();
			if (flagged)
			{
				layer.graphics.beginBitmapFill(images[Constants.Flag].bitmapData);
				layer.graphics.drawRect(i * Constants.BlockSize, j * Constants.BlockSize, Constants.BlockSize, Constants.BlockSize);
				layer.graphics.endFill();			
			}
		}
		public function gameOver():void
		{
			var field:TextField = new TextField();
			field.textColor = Colors.SoftRed;
			field.text = "Game Over";
			field.selectable = false;
            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			format.size = 40;
			field.autoSize = TextFieldAutoSize.CENTER;
			field.setTextFormat(format);
			//field.width = field.textWidth;
			//field.height = field.textHeight;
			field.x = (piecesLayer.width / 2) - (field.width / 2);
			field.y = (piecesLayer.height / 2) - (field.height / 2) + 100;
			field.filters = [new GlowFilter(Colors.SoftYellow )];
			piecesLayer.graphics.beginFill(Colors.White, 0.4);
			piecesLayer.graphics.drawRoundRect(field.x-10, field.y-10, field.width+20, field.height+20,16,16);
			piecesLayer.graphics.endFill();
			piecesLayer.addChild(field);
		}

	}
}