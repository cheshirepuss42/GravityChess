package  
{
	import flash.geom.Point;

	public class Constants
	{
		
		public static const Empty:int = 0;
		public static const Pawn:int = 1;
		public static const Knight:int = 2;
		public static const Bishop:int = 3;
		public static const Rook:int = 4;
		public static const WPawn:int = 5;
		public static const WKnight:int = 6;
		public static const Queen:int = 7;
		public static const Flag:int = 8;
		public static const Loot:int = 9;
		public static const Bomb:int = 10;
		
		public static const BlockSize:int = 53;
		
		public static const FramesPerShift:int = 20;
		
		public static const PawnDropRate:Number = 0.75;
		public static const KnightDropRate:Number = 0.15;
		public static const LootDropRate:Number = 0.1;
		public static const BombDropRate:Number = 0.1;		
		
		public static const AmAllowedFlags:int = 3;
		
		public static const OffsetX:int = 25;
		public static const OffsetY:int = 25;
		
		public static const imageFiles:String="assets/images/"
		
		public function Constants() 
		{
			
		}
		public static function costs():Array
		{
			var a:Array = [];
			a[Knight] = 6;
			a[Bishop] = 6;
			a[Rook] = 10;
			a[Pawn] = 2;
			a[Queen] = 18;
			return a;
		}
		public static function rewards():Array
		{
			var a:Array = [];
			a[WKnight] = 5;
			a[WPawn] = 1;			
			return a;
		}		
		public static function hasPoint(needle:Point, haystack:Vector.<Point>):Boolean
		{
			for (var i:int = 0; i < haystack.length; i++) 
			{
				if (needle.equals(haystack[i]))
					return true;
			}
			return false;
		}
		
	}

}