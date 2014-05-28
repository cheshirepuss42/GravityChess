package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.*;
	public class PopupView extends Sprite
	{
		private var w:int;
		private var h:int;
		public function PopupView(_w:int,_h:int) 
		{
			w = _w;
			h = _h;
			showWelcomeScreen(Constants.AmAllowedFlags);
			//showGameOverScreen();
			this.mouseChildren = this.mouseEnabled = false;
		}
		public function showWelcomeScreen(limit:int):void
		{
			clear();
			var textSprite:Sprite = new Sprite();
			
			var header:TextField = getTextField("Gravity Chess", 30, Colors.DarkGrey);
			var text:TextField = getTextField(	"Enemies don't move, only attack.\n" + 
												"After each move the board slides down.\n" + 
												"Don't let the enemy capture more than "+String(limit-1)+" bottom spaces!\n"+
												"Use captured enemies to buy back pieces, \nor even a queen...", 15, Colors.DarkGrey);
			//text.width = text.textWidth;
			var background:Sprite = getBackground(header.x,header.y,text.width , text.height + header.height);
			background.x -= header.width / 2;
			text.y += header.height;
			textSprite.addChild(background);			
			textSprite.addChild(header);
			textSprite.addChild(text);
			
			trace(w, h, textSprite.width, textSprite.height);
			
			addChild(textSprite);			
			textSprite.x += (textSprite.width/2 );
			textSprite.y += (textSprite.height /2);
		}
		public function showGameOverScreen():void
		{
			clear();
			var textSprite:Sprite = new Sprite();
			var header:TextField = getTextField("Game Over", 50, Colors.DarkGrey);
			var background:Sprite = getBackground(header.x,header.y,header.width , header.height);
			//background.x -= header.width / 2;
			textSprite.addChild(background);			
			textSprite.addChild(header);
			trace(w, h, textSprite.width, textSprite.height);			
			addChild(textSprite);			
			textSprite.x += (textSprite.width/2 );
			textSprite.y += (textSprite.height /2);		
		}
		public function clear():void
		{
			while (numChildren > 0)
				removeChildAt(0);
			graphics.clear();
		}
		private function getBackground(nx:int,ny:int,_w:int,_h:int,padding:int=5):Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(Colors.White, 0.8);
			s.graphics.drawRoundRect(nx-padding, ny-padding, _w+(padding*2), _h+(padding*2), 16, 16);
			s.graphics.endFill();
			return s;
		}
		private function getTextField(str:String, size:int, col:uint):TextField
		{
			var field:TextField = new TextField();
			field.textColor = col;
			field.text = str;
			field.selectable = false;
			field.multiline = true;
            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			format.size = size;
			format.align = TextFormatAlign.CENTER;
			field.autoSize = TextFieldAutoSize.CENTER;
			field.setTextFormat(format);
			return field;
			//field.width = field.textWidth;
			//field.height = field.textHeight;
			//field.x = (piecesLayer.width / 2) - (field.width / 2);
			//field.y = (piecesLayer.height / 2) - (field.height / 2) + 100;
			//field.filters = [new GlowFilter(Colors.SoftYellow )];			
		}
		
	}

}