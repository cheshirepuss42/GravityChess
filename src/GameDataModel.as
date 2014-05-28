package  
{
	/**
	 * ...
	 * @author 
	 */
	public class GameDataModel
	{
		public var takenPieces:Vector.<int> = new Vector.<int>();
		public var selected:int = -1;
		public var score:int = 0;
		public var buyingPhase:Boolean = false;
		public var amRounds:int = 1;
		
		public function GameDataModel() 
		{
			takenPieces.push(Constants.Queen);
		}
		public function addTakenPieces(taken:Vector.<int>):void
		{
			takenPieces = takenPieces.concat(taken);
			//trace(takenPieces)
		}
		public function addScore(s:int):void
		{
			score += s;
		}
		public function buyPiece():void
		{
			var cost:int = Constants.costs()[takenPieces[selected]];

				score-= cost;
				takenPieces.splice(selected, 1);
				buyingPhase = false;
				selected = -1;
		
		}
		public function getSelectedPiece():int
		{
			if (selected < 0)
			{
				return -1;
			}
			else
			{
				return takenPieces[selected];
			}
		}
	}

}