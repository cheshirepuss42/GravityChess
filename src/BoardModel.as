package  
{
	import adobe.utils.CustomActions;
	import adobe.utils.ProductManager;
	import flash.geom.Point;

	public class BoardModel
	{
		public var board:Vector.<Vector.<int>>;
		public var selection:Point = null;
		public var targets:Vector.<Point> = new Vector.<Point>();
		private const dirs:Array = [new Point(0, 1), new Point(0, -1), new Point(1, 0), new Point( -1, 0),
									new Point(1, 1), new Point(1, -1), new Point( -1, 1), new Point( -1, -1)];
		private const knightDirs:Array = [new Point(2, -1), new Point(2, 1), new Point( -2, -1), new Point( -2, 1),
										new Point(1, 2), new Point(1, -2), new Point( -1, 2), new Point( -1, -2)];
		private const enemyDirs:Array = [dirs[6], dirs[4]]; 
//----------------------------------------------------------------------------------------------------------------------------------//			
		public function BoardModel() 
		{
			board = new Vector.<Vector.<int>>();
			for (var i:int = 0; i < 8; i++) 
			{
				board[i] = new Vector.<int>();
				for (var j:int = 0; j < 8; j++) 
				{
					board[i][j] = Constants.Empty;					
				}				
			}
			board[0][7] = board[7][7] = Constants.Rook;
			board[1][7] = board[6][7] = Constants.Knight;
			board[2][7] = board[5][7] = Constants.Bishop;
			board[3][7] = board[4][7] = Constants.Pawn;	
		}

//---------------------------------------------counterattack-------------------------------------------------------------------------------------//		
		public function counterAttack():Vector.<int>
		{
			var taken:Vector.<int> = new Vector.<int>();
			var moved:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < 8; i++) 
			{
				for (var j:int = 0; j < 8; j++) 
				{
					var here:Point = new Point(i, j);
					if (isEnemyPiece(here)&&!Constants.hasPoint(here, moved))
					{
						var targets:Vector.<Point> = getEnemyTargets(here);
						if (targets.length > 0)
						{
							var target:Point = targets[int(targets.length * Math.random())];
							taken.push(board[target.x][target.y]);						
							board[target.x][target.y] = board[here.x][here.y];
							moved.push(target);
							board[here.x][here.y]=Constants.Empty;							
						}
					}
				}
			}
			return taken;
		}
		public function getThreats():Vector.<Point>		
		{
			var t:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < 8; i++) 
			{
				for (var j:int = 0; j < 8; j++) 
				{
					if (board[i][j] == Constants.WPawn)
					{	
						t = t.concat(getPawnTargets(new Point(i, j), true, true));
					}
					if (board[i][j] == Constants.WKnight)
					{	
						t = t.concat(getKnightTargets(new Point(i, j), true,true));	
					}					
				}
			}
			return t;
		}
//----------------------------------------------shift------------------------------------------------------------------------------------//				
		public function shiftBoard():Vector.<*>
		{			
			var points:Vector.<*> = new Vector.<*>();
			for (var i:int = 0; i < board.length; i++) 
			{
				for (var j:int = board[i].length - 2; j >= 0 ; j--) 
				{
					if (board[i][j] != Constants.Empty)
					{						
						if (board[i][j + 1] == Constants.Empty)
						{
							points.push( { x:i, y:j, type:board[i][j] } );
							board[i][j + 1] = board[i][j];
							board[i][j] = Constants.Empty;								
						}			
					}
				}				
			}	
			return points;
		}
//-------------------------------------------make move---------------------------------------------------------------------------------------//				
		public function moveSelection(t:Point):int
		{
			var capture:int = board[t.x][t.y];
			board[t.x][t.y] = board[selection.x][selection.y];			
			board[selection.x][selection.y] = 0;
			makeTargets();
			return capture;
		}
//-----------------------------------------------targets-----------------------------------------------------------------------------------//				
		public function isTarget(p:Point):Boolean
		{
			return Constants.hasPoint(p, targets);
		}
		private function getEnemyTargets(p:Point):Vector.<Point>
		{
			if (isOnBottomRow(p))
			{
				return new Vector.<Point>();
			}
			switch(board[p.x][p.y])
			{
				case Constants.WKnight:return getKnightTargets(p, true); break;
				default:return getPawnTargets(p, true); break;
			}			
		}
		
		private function getKnightTargets(location:Point,enemy:Boolean=false,threat:Boolean=false):Vector.<Point>
		{
			var t:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < knightDirs.length; i++) 
			{						
				var target:Point = new Point(knightDirs[i].x  + location.x, knightDirs[i].y + location.y);
				if (enemy&&isOnBoard(target))
				{
					if(threat)
						t.push(target);	
					
					else if (isPlayerPiece(target))
					{
						t.push(target);
					}
				}
				if (!enemy && isValidPlayerTarget(target))
				{
					t.push(target);
				}										
			}
			return t;
		}
		private function getPawnTargets(location:Point,enemy:Boolean=false,threat:Boolean=false):Vector.<Point>
		{
			var t:Vector.<Point> = new Vector.<Point>();
			var p1:Point = new Point(location.x - 1, location.y - 1);
			var p2:Point = new Point(location.x + 1, location.y - 1);
			var p3:Point = new Point(location.x, location.y - 1);
			var p4:Point = new Point(location.x, location.y - 2);			
			if (!enemy)
			{
				if (isValidPlayerTarget(p1) && isEnemyPiece(p1)) t.push(p1);
				if (isValidPlayerTarget(p2) && isEnemyPiece(p2)) t.push(p2);
				if (isValidPlayerTarget(p3) && isEmpty(p3)) t.push(p3);
				if (isValidPlayerTarget(p4) && isEmpty(p3)&& isEmpty(p4)&& isOnBottomRow(location)) t.push(p4);
			}
			else
			{
				p1.y += 2;
				p2.y += 2;
				if (threat)
				{
					if (isValidEnemyTarget(p1)||isEnemyPiece(p1)) t.push(p1);
					if (isValidEnemyTarget(p2)||isEnemyPiece(p2)) t.push(p2);						
				}
				else
				{
					if (isPlayerPiece(p1)) t.push(p1);
					if (isPlayerPiece(p2)) t.push(p2);	
				}
			}
			return t;			
		}	
		private function getRookTargets(rook:Boolean,location:Point,enemyTargets:Boolean=false):Vector.<Point>
		{
			var t:Vector.<Point> = new Vector.<Point>();
			var start:int = (rook)?0:4;
			for (var i:int = start; i < start+4; i++) 
			{	
				var end:Boolean = false;
				var dist:int = 1;
				while (!end)
				{							
					var target:Point = new Point((dirs[i].x * dist) + location.x, (dirs[i].y * dist) + location.y);								
					if (!isOnBoard(target))
						end = true;
					else 
					{
						dist++;
						switch(board[target.x][target.y])
						{
							case Constants.Empty:t.push(target); break;
							case Constants.WPawn:if (!enemyTargets) t.push(target); end = true; break; 
							case Constants.WKnight:if (!enemyTargets) t.push(target); end = true; break; 
							default:if(enemyTargets)t.push(target);end = true; break;
						}							
					}								
				}
			}
			return t;
		}	
		private function getBishopTargets(location:Point):void
		{
			getRookTargets(false,location);
		}		
		public function makeTargets():void
		{
			targets = new Vector.<Point>();
			if (selection != null)
			{				
				switch(board[selection.x][selection.y])
				{
					case Constants.Pawn:targets=getPawnTargets(selection);break;							
					case Constants.Rook:targets=getRookTargets(true,selection); break;						
					case Constants.Bishop:targets=getRookTargets(false,selection);break;										
					case Constants.Knight:targets = getKnightTargets(selection); break;	
					case Constants.Queen:targets=getRookTargets(false,selection).concat(getRookTargets(true,selection)); break;	
				}
				//remove bottom row pawns cases from target list
				for (var i:int = 0; i < targets.length; i++) 
				{
					if (isOnBottomRow(targets[i]) && isEnemyPiece(targets[i]))
						targets.splice(i, 1);
						
				}			
			}
		}
//---------------------------------utility-------------------------------------------------------------------------------------------------//				
		private function isOnBoard(p:Point):Boolean
		{
			return (p.x<board.length&&p.x>=0)&&(p.y<board.length&&p.y>=0);			
		}	
		public function isEmpty(p:Point):Boolean
		{
			return isOnBoard(p) && board[p.x][p.y] == Constants.Empty;
		}
		public function isPlayerPiece(p:Point):Boolean
		{
			return isOnBoard(p) && (
					board[p.x][p.y] == Constants.Pawn ||
					board[p.x][p.y] == Constants.Knight ||
					board[p.x][p.y] == Constants.Bishop ||
					board[p.x][p.y] == Constants.Rook ||
					board[p.x][p.y] == Constants.Queen);
		}
		private function isEnemyPiece(p:Point):Boolean
		{
			return isOnBoard(p) && (
					board[p.x][p.y] == Constants.WPawn ||
					board[p.x][p.y] == Constants.WKnight);
		}
		private function isOnBottomRow(p:Point):Boolean
		{
			return isOnBoard(p) && p.y==board[0].length-1;
		}	
		
	
		public function getFlags():Vector.<int>
		{
			var v:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < board.length; i++) 
			{
				if (isEnemyPiece(new Point(i, 7)))
					v.push(i);
			}
			return v;
		}
		public function isValidEnemyTarget(p:Point):Boolean
		{
			return isOnBoard(p)&& !isEnemyPiece(p);
		}		
		public function isValidPlayerTarget(p:Point):Boolean
		{
			return isEnemyPiece(p) || isEmpty(p);
		}			
		public function setSelection(p:Point):void
		{
			selection = (selection == null)?p:null;
			makeTargets();			
		}	
		public function amCaptures():int
		{
			var c:int = 0;
			for (var i:int = 0; i < board.length; i++) 
			{
				if (isEnemyPiece(new Point(i, 7)))
				{
					c++;
				}				
			}
			return c;
		}
		public function addEnemy(score:int):void
		{
			if (Math.random() < Constants.PawnDropRate*(1+(score/75)))
				board[int(Math.random() * board[0].length)][0] = Constants.WPawn;
			if (Math.random() < Constants.KnightDropRate*(1+(score/75)))
				board[int(Math.random() * board[0].length)][0] = Constants.WKnight;				
			//if (Math.random() < Constants.LootDropRate*(1-(score/75)))
				//board[int(Math.random() * board[0].length)][0] = Constants.Loot;					
			//if (Math.random() < Constants.BombDropRate*(1-(score/75)))
				//board[int(Math.random() * board[0].length)][0] = Constants.Bomb;				
		}
		public function addPiece(p:Point,piece:int):void
		{
			board[p.x][p.y] = piece;
		}		
	}

}