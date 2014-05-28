package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 * uses boardModel and boardView to control game
	 */
	public class GameController extends Sprite
	{
		private var boardView:BoardView;
		private var boardModel:BoardModel;
		private var dataModel:GameDataModel;
		private var dataView:GameDataView;
		private var popupView:PopupView;
		private var img:Images;
		public function GameController(stage:Stage) 
		{
			img = new Images();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keys);
			
			setup();
			//popupView.showWelcomeScreen
			
			
		}
		private function test():void
		{
			boardModel.board[1][7] = Constants.WPawn;
			boardModel.board[2][7] = Constants.WPawn;
			boardModel.board[3][7] = Constants.WPawn;
			boardModel.board[4][7] = Constants.WPawn;
			boardModel.board[5][7] = Constants.WPawn;
		}
		private function setup():void
		{
			while (this.numChildren > 0)
				this.removeChildAt(0);
			
			boardModel = new BoardModel();
			boardView = new BoardView(img.images);
			dataModel = new GameDataModel();
			dataView = new GameDataView(img.images,Constants.BlockSize*2.5,Constants.BlockSize*8);
			
			dataView.addEventListener("pieceClicked", handlePieceBuy);
			dataView.addEventListener("reset", handleReset);
			dataView.mouseEnabled = false;
			addChild(boardView);
			addChild(dataView);
			
			boardModel.addEnemy(dataModel.score);
			//test();
			draw();
			popupView = new PopupView(boardView.width,boardView.height);
			addChild(popupView);		
			
			boardView.addEventListener(MouseEvent.CLICK, clickHandler);	
		}
//---------------------------------------------click-------------------------------------------------------------------------------------//		
		private function clickHandler(e:MouseEvent):void
		{
			popupView.clear();
			var target:Point = new Point(int(e.localX / Constants.BlockSize), int(e.localY / Constants.BlockSize));
			if (dataModel.buyingPhase)
			{
				
				if (boardModel.isEmpty(target) )
				{
					
					//trace(target,dataModel.selected,dataModel.takenPieces);
					boardModel.addPiece(target, dataModel.getSelectedPiece());					
					dataView.removePiece(dataModel.selected);
					dataModel.buyPiece();
					processBoard();
					//draw();
					
					//trace(target,dataModel.selected,dataModel.takenPieces);
				}
			}
			else
			{
				if (boardModel.isPlayerPiece(target))
				{
					if (boardModel.selection == null)
					{
						trace("selecting",target);
						boardModel.setSelection(target);			
						draw();						
					}
					else
					{
						trace("deselect2");
						boardModel.setSelection(null);
						draw();
					}
				}
				else
				{
					if (boardModel.selection != null)
					{	
						if (boardModel.isTarget(target))
						{
							trace("placing", boardModel.selection, "on", target);
							processMove(target);							
						}
						else
						{
							trace("deselect");
							boardModel.setSelection(null);
							draw();						
						}
					}
				}	
			}
		}
		private function processBoard():void
		{	
			boardModel.setSelection(null);
			dataModel.addTakenPieces(boardModel.counterAttack());
			
			draw();				
			var threats:Vector.<Point> = boardModel.getThreats();
			boardView.startShift(boardModel.shiftBoard(),threats, boardModel.board,boardModel.getFlags());
			boardView.mouseChildren = false;
			boardView.mouseEnabled = false;
			boardView.addEventListener("shiftFinished", handleShift);			
		}		
		private function processMove(target:Point):void
		{
			var result:int = boardModel.moveSelection(target);			
			dataModel.addScore(Constants.rewards()[result]);
			processBoard();			
		}		
		private function handleShift(e:Event):void
		{
			boardView.removeEventListener("shiftFinished", handleShift);
			//check for game-over
			if (boardModel.getFlags().length >= Constants.AmAllowedFlags)
			{
				popupView.showGameOverScreen();
				//boardView.gameOver();
				dataView.gameOver();
			}
			else
			{
				//get ready for next turn
				dataModel.amRounds++;
				boardModel.addEnemy(dataModel.score);
				boardView.mouseChildren = true;
				boardView.mouseEnabled = true;			
				draw();				
			}
		}
		private function handleReset(e:Event):void
		{
			setup();
		}
		private function handlePieceBuy(e:Event):void
		{
			dataModel.selected = dataView.currentlySelected;
			dataModel.buyingPhase = dataModel.selected != -1;
			/*
			for (var piece:int = 0; piece < dataView.takenPieces.length; piece++) 
			{
				if (dataView.takenPieces[piece].selected)
				{
					trace(selected,dataModel.selected);
					selected = piece;					
				}
			}
			
			if (dataModel.selected<0)
			{
				//trace("deselect",selected);
				dataModel.selected = -1;
				dataModel.buyingPhase = false;					
			}
			else
			{				
				dataModel.selected = selected;				
				dataModel.buyingPhase = true;
				//trace("select",selected,dataModel.getSelectedPiece());				
			}*/
			draw();
		}
//---------------------------------------------utility-------------------------------------------------------------------------------------//				
		private function draw():void
		{
			boardView.draw(boardModel.board, boardModel.selection, boardModel.targets, boardModel.getThreats(),boardModel.getFlags());
			dataView.draw(dataModel.takenPieces,dataModel.score,dataModel.selected,dataModel.amRounds);
		}
//---------------------------------------------keyboard-------------------------------------------------------------------------------------//				
		private function keys(e:KeyboardEvent):void
		{
			if (e.keyCode == 32)
			{
				//draw();
			}
		}	
		
	}

}