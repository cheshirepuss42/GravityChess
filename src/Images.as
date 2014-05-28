package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;	
	/**
	 * ...
	 * @author 
	 */
	public class Images
	{
		[Embed(source = "assets/images/bb.png")] 
		private static var BB:Class;		
		[Embed(source = "assets/images/bn.png")] 
		private static var BN:Class;
		[Embed(source = "assets/images/bp.png")] 
		private static var BP:Class;
		[Embed(source = "assets/images/br.png")] 
		private static var BR:Class;		
		[Embed(source = "assets/images/wp2.png")] 
		private static var WP:Class;		
		[Embed(source = "assets/images/bq.png")] 
		private static var BQ:Class;
		[Embed(source = "assets/images/flag.png")] 
		private static var Flag:Class;		
		[Embed(source = "assets/images/wn2.png")] 
		private static var WN:Class;	
		[Embed(source = "assets/images/loot.png")] 
		private static var Loot:Class;
		[Embed(source = "assets/images/bomb.png")] 
		private static var Bomb:Class;		
		/*
		[Embed(source = "assets/bk.png")] 
		private static var BK:Class;		
		[Embed(source = "assets/wb.png")] 
		private static var WB:Class;
		[Embed(source = "assets/wn.png")] 
		private static var WN:Class;
		[Embed(source = "assets/wq.png")] 
		private static var WQ:Class;
		[Embed(source = "assets/wr.png")] 
		private static var WR:Class;	
		*/
		public var images:Vector.<Bitmap> = new Vector.<Bitmap>();		
		public function Images() 
		{
			//	put images of pieces in array and resize them
			images[Constants.Empty] = new Bitmap();
			images[Constants.Pawn] = new BP();
			images[Constants.Knight] = new BN();
			images[Constants.Bishop] = new BB();
			images[Constants.Rook] = new BR();
			images[Constants.WPawn] = new WP();
			images[Constants.WKnight] = new WN();
			images[Constants.Queen] = new BQ();
			images[Constants.Flag] = new Flag();
			images[Constants.Loot] = new Loot();
			images[Constants.Bomb] = new Bomb();
			var scaling:Number = Constants.BlockSize / images[1].width;
			var mat:Matrix = new Matrix();
			mat.scale(scaling, scaling);
			for (var i:int = 1; i < images.length; i++) 
			{			
				var scaledBitmapData:BitmapData=new BitmapData(Constants.BlockSize,Constants.BlockSize,true,Colors.White);
				scaledBitmapData.draw(images[i].bitmapData, mat);
				images[i] = new Bitmap(scaledBitmapData);
			}			
		}

		
		public function getImage(i:int):Bitmap
		{
			return images[i];
		}
		
	}

}