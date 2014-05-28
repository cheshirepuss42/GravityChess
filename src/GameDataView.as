package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.*;
	/**
	 * ...
	 * @author 
	 */
	public class GameDataView extends Sprite
	{
		private var images:Vector.<Bitmap>;
		private var backgroundLayer:Sprite = new Sprite();
		public var takenPieces:Vector.<int> = new Vector.<int>();
		public var currentlySelected:int = -1;
		public var currentScore:int;
		//private var frontLayer:Sprite = new Sprite();
		private var data:Sprite = new Sprite();
		private var actions:Sprite = new Sprite();
		private var w:int;
		private var h:int;
		private var outerPadding:int = 10;
		private var innerPadding:int = 5;
		public function GameDataView(imgs:Vector.<Bitmap>,_w:int,_h:int) 
		{
			w = _w;
			h = _h;
			var c:int = (Constants.BlockSize + (innerPadding ) + outerPadding) * 2;
			w = c;			
			images = imgs;
			backgroundLayer = makeBackground(w, h, Colors.DarkGrey, 0);
			addChild(backgroundLayer);
			addChild(data);
			addChild(actions);
			this.x += (Constants.BlockSize * 8) + outerPadding*2;
			data.x = outerPadding;
			actions.x = outerPadding;
			
			data.y = outerPadding;

			//
			//actions.y += Constants.BlockSize;
			//frontLayer.width = w-(outerPadding*2);
			//frontLayer.height = h - (outerPadding * 2);
			//trace(frontLayer.getBounds(this));
			//drawBackgroundLayer();			
		}
		public function draw(pieces:Vector.<int>,score:int,selected:int,roundNr:int):void
		{
			takenPieces = pieces.concat();
			trace("ampiece", takenPieces.length);
			currentlySelected = selected;
			currentScore = score;
			drawData(roundNr);
			actions.y = data.y+data.height+outerPadding;						
			drawActions();
		}
		private function drawData(roundNr:int):void
		{
			while (data.numChildren > 0)
				data.removeChildAt(0);
			var tf:TextField = makeTextField("Points: " + String(currentScore)+"\nTurn: " + String(roundNr), 15, Colors.White);
			tf.x = innerPadding;
			data.addChild(makeBackground(w-outerPadding*2, tf.height, Colors.DeepGrey, 0));	
			data.addChild(tf);			
		}
		private function drawActions():void
		{
			while (actions.numChildren > 0)
				actions.removeChildAt(0);
			for (var piece:int = 0; piece < takenPieces.length; piece++) 
			{
				var pieceImg:Sprite = makePiece(piece);
				var affordable:Boolean = currentScore >= Constants.costs()[takenPieces[piece]];
				pieceImg.x = (piece < 5)?0:pieceImg.width+outerPadding;
				pieceImg.y = ((pieceImg.height + outerPadding) * (piece % 5));
				trace(pieceImg.y, pieceImg.height, piece);
				if (affordable)
				{
					pieceImg.addEventListener(MouseEvent.CLICK, pieceClicked);
				}
				else
				{
					pieceImg.alpha = 0.5;
				}
				actions.addChild(pieceImg);				
			}				
		}
		private function pieceClicked(e:MouseEvent):void
		{			
			currentlySelected=(currentlySelected==-1)?int(e.currentTarget.name):-1;
			dispatchEvent(new Event("pieceClicked"));						
		}
		/*
		public function draw2(pieces:Vector.<int>,score:int,selected:int,roundNr:int):void
		{
		
			while (frontLayer.numChildren > 0)
				frontLayer.removeChildAt(0);			
			for (var i:int = 0; i < pieces.length; i++) 
			{
				trace(pieces[i]);
				takenPieces[i] = { img:makePiece( pieces[i], i, (i == selected)), type:pieces[i], selected:(i == selected) };
				if (score < Constants.costs()[pieces[i]])
				{
					takenPieces[i].img.alpha = 0.5;
				}
				else
					takenPieces[i].img.addEventListener(MouseEvent.CLICK, takenPieceClick);
				frontLayer.addChild(takenPieces[i].img);				
			}
			frontLayer.addChild(makeTextBox("Turn: "+String(roundNr)+"\nPoints: " + String(score)));
			backgroundLayer.addChild(makeButton("New Game"));
		}
		*/
		public function gameOver():void
		{
			for (var i:int = 0; i < actions.numChildren; i++) 
			{
				if (actions.getChildAt(i).hasEventListener(MouseEvent.CLICK))
				{
					actions.getChildAt(i).removeEventListener(MouseEvent.CLICK, pieceClicked);
				}
			}
		}
		
		public function removePiece(p:int):void
		{
			//frontLayer.removeChild(takenPieces[p].img);
			takenPieces = takenPieces.splice(p, 1);
		}
		/*
		private function takenPieceClick(e:MouseEvent):void
		{
			for (var i:int = 0; i < takenPieces.length; i++) 
			{
				if (e.currentTarget == takenPieces[i].img)
				{
					takenPieces[i].selected = !takenPieces[i].selected;
					//trace(takenPieces[i].selected);
					
				}
				else
					takenPieces[i].selected = false;
				
				
			}
			dispatchEvent(new Event("pieceClicked"));
			
		}
		private function drawBackgroundLayer():void
		{
			backgroundLayer.graphics.beginFill(Colors.Grey);
			backgroundLayer.graphics.drawRoundRect(0, 0, w, h,16,16);
		}
		private function buttonClick(e:MouseEvent):void
		{
			if (e.currentTarget.name == "Reset")
			{
			gameOver();
			dispatchEvent(new Event("reset"));
			}
		}
		private function makeButton2(text:String,type:String="Reset"):Sprite
		{
			var piece:Sprite;
			var field:TextField = new TextField();	
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			field.autoSize = TextFieldAutoSize.CENTER;
			field.selectable = false;						
			switch(type)
			{
				case "Piece":
				
					var isSelected:Boolean = currentlySelected >= 0 && takenPieces[currentlySelected] == p;
					piece = makeBackground(new Rectangle( -innerPadding, -innerPadding, Constants.BlockSize + (innerPadding * 2), Constants.BlockSize + (innerPadding * 2)),
											(isSelected)?Colors.SoftYellow:Colors.DeepGrey));
					piece.addChild(makeTextField(
					
					var p:int = int(text);
					var img:Bitmap = Images.getImage(p);
					var cost:int = Constants.costs()[p];
					var isSelected:Boolean = currentlySelected >= 0 && takenPieces[currentlySelected] == p;
					piece.graphics.beginFill((isSelected)?Colors.SoftYellow:Colors.DeepGrey);
					piece.graphics.drawRoundRect(,16,16);
					piece.graphics.endFill();
					piece.graphics.beginBitmapFill(img.bitmapData);
					piece.graphics.drawRect(0,0, Constants.BlockSize, Constants.BlockSize);
					piece.graphics.endFill();					
				break;
				
				default:
					// make textfield					
					field.textColor = Colors.Black;
					field.text = text;					
					format.size = 13;					
					field.setTextFormat(format);
					field.width = field.textWidth;
					field.height = field.textHeight;	
					// make container with background 
					piece.graphics.beginFill(Colors.LightGrey);
					piece.graphics.drawRoundRect(0,0, field.width+innerPadding,field.height+innerPadding,16,16);
					piece.graphics.endFill();
					// position textfield on background
					field.x = (piece.width / 2) - (field.width / 2);
					field.y = (piece.height / 2) - (field.height / 2);				
					piece.x = w / 2 - piece.width / 2; piece.y = h - piece.height - innerPadding; 
					piece.name = type;	
				break;
			}						
			// return the composite
			piece.addEventListener(MouseEvent.CLICK, buttonClick);
			piece.addChild(field);	
			return piece;
		}			
		private function makeButton(text:String,type:String="Reset"):Sprite
		{
			var padding:int = 5;
			// make textfield
			var field:TextField=new TextField();
			field.textColor = Colors.Black;
			field.text = text;
			field.selectable = false;
            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			format.size = 13;
			field.autoSize = TextFieldAutoSize.CENTER;
			field.setTextFormat(format);
			field.width = field.textWidth;
			field.height = field.textHeight;	
			// make container with background and eventlistener based on name
			var piece:Sprite = new Sprite();
			piece.addEventListener(MouseEvent.CLICK, buttonClick);
			piece.name = type;
			piece.graphics.beginFill(Colors.LightGrey);
			piece.graphics.drawRoundRect(0,0, field.width+padding,field.height+padding,16,16);
			piece.graphics.endFill();
			// position textfield on background
			field.x = (piece.width / 2) - (field.width / 2);
			field.y = (piece.height / 2) - (field.height / 2);
			
			// set position on parent based on name
			switch(piece.name)
			{
				default:piece.x = w / 2 - piece.width / 2; piece.y = h - piece.height-padding; break;
			}
			// return the composite
			piece.addChild(field);	
			return piece;
		}		
		private function makePiece2(p:int, pos:int,selected:Boolean=false):Sprite
		{
			var piece:Sprite = new Sprite();
			var padding:int = 3;
			var doublePadding:int = padding * 2;
			var col:uint = (selected)?Colors.SoftYellow:Colors.DeepGrey;
			//trace(selected,col);
			piece.graphics.beginFill(col);
			piece.graphics.drawRoundRect(-padding, -padding, Constants.BlockSize+doublePadding, Constants.BlockSize+doublePadding,16,16);
			piece.graphics.endFill();
			piece.graphics.beginBitmapFill(images[p].bitmapData);
			piece.graphics.drawRect(0,0, Constants.BlockSize, Constants.BlockSize);
			piece.graphics.endFill();
			piece.y += ((pos % 5 + 1) * (Constants.BlockSize + doublePadding + doublePadding));
			piece.x += (pos < 5 )?doublePadding:(doublePadding * 3) + Constants.BlockSize;
						
			//add cost number
			var field:TextField=new TextField();
			field.textColor = Colors.White;
			field.text = String(Constants.costs()[p]);
			field.selectable = false;
			field.width = 30;
			field.height = 30;
            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			format.size = 13;
			field.setTextFormat(format);
			piece.addChild(field);	
			return piece;
		}
		public function makeTextBox(str:String):Sprite
		{
			var box:Sprite = new Sprite();
			var field:TextField=new TextField();
			box.alpha = .8;
			field.textColor = Colors.White;
			field.text = str;
			field.multiline = true;
			field.selectable = false;
            field.autoSize = TextFieldAutoSize.LEFT;			
            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			format.size = 20;
			field.setTextFormat(format);
			box.addChild(field);			
			return box;
		}
		
		*///
		private function makePiece(takenPiece:int):Sprite
		{			
			var piece:Sprite = makeBackground(Constants.BlockSize, Constants.BlockSize,(currentlySelected == takenPiece)?Colors.SoftYellow:Colors.DeepGrey,0);
			drawImageOnSprite(takenPieces[takenPiece], piece);
			var cost:TextField = makeTextField(String(Constants.costs()[takenPieces[takenPiece]]), 13, Colors.White);
			piece.name = String(takenPiece);
			piece.addChild(cost);			
			return piece;
		}		
		private function drawImageOnSprite(img:int,spr:Sprite):void
		{
			spr.graphics.beginBitmapFill(images[img].bitmapData);
			spr.graphics.drawRect(0, 0, Constants.BlockSize, Constants.BlockSize);
			spr.graphics.endFill();
		}		
		private function makeBackground(_w:int,_h:int, col:uint,padding:int):Sprite
		{
			var spr:Sprite = new Sprite();
			spr.graphics.beginFill(col);
			spr.graphics.drawRoundRect(-padding,-padding,_w+(padding*2),_h+(padding*2),16,16);
			spr.graphics.endFill();
			return spr;
		}
		private function makeTextField(txt:String, size:int, col:uint):TextField
		{
			var field:TextField=new TextField();
			field.textColor = col;
			field.text = txt;
			//field.multiline = true;
			field.selectable = false;
            field.autoSize = TextFieldAutoSize.LEFT;			
            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			format.size = size;
			field.setTextFormat(format);	
			field.width = field.textWidth;
			field.height = field.textHeight;
			return field;
		}
	}

}