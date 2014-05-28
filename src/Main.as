package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.StageScaleMode;
	/**
	 * ...
	 * @author pmg
	 */
	[SWF( width=640,height=480,backgroundColor = "#333333", frameRate = "25")]
	public class Main extends Sprite 
	{
		//private var game:GameBoard = new GameBoard();
		private var game:GameController;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			trace(stage.stageWidth, stage.stageHeight);
			game = new GameController(stage);
			game.x += Constants.OffsetX;
			game.y += Constants.OffsetY;
			addChild(game);
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

	}
	
}