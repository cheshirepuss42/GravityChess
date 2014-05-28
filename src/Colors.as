package  
{
	/**
	 * ...
	 * @author 
	 */
	public class Colors
	{

        public static const Black:uint      = 0x000000;
        public static const White:uint      = 0xFFFFFF;
		public static const Red:uint      	= 0xFF0000;
		public static const Green:uint      = 0x00FF00;
		public static const Blue:uint      	= 0x0000FF;
        public static const OffWhite:uint   = 0xF9F9F9;
        public static const LightGrey:uint  = 0xF0F0F0;
        public static const MediumGrey:uint = 0xEEEEEE;
        public static const MiddleGrey:uint = 0xB0B0B0;
		public static const Yellow:uint 	= 0xffff88;
        public static const Grey:uint       = 0x7F7F7F;
        public static const DeepGrey:uint   = 0x4F4F4F;
        public static const DarkGrey:uint   = 0x3F3F3F;

        public static const LightRed:uint   = 0xF99BAC;
        public static const MediumRed:uint  = 0xF33C5C;
		public static const MediumYellow:uint  = 0xF3F35C;
		public static const SoftYellow:uint  = 0xAAAA55;
		public static const SoftRed:uint  = 0xBE2C2F;
        public static const BrightRed:uint  = 0xEE002C;
        public static const ShadowRed:uint  = 0x770015;

        public static const ResultColor:uint = 0xE5FCE0;
        public static const TraceColor :uint = 0xE0EEFC;
        public static const ErrorColor :uint = 0xFFE3E6;

        public static const BackgroundGreen:uint = 0xDEFEC7;
        public static const CompositionGreen:uint = 0xE7F7DC;
		/*
            public static const AQUA:uint =   0x00FFFF ;
                public static const BLACK:uint =   0x000000 ;
                public static const BLUE:uint =   0x0000FF ;
                public static const FUCHSIA:uint =   0xFF00FF ;
                public static const GRAY:uint =   0x808080 ;
                public static const GREEN:uint =   0x008000 ;
                public static const LIME:uint =   0x00FF00 ;
                public static const MAROON:uint =   0x800000 ;
                public static const NAVY:uint =   0x000080 ;
                public static const OLIVE:uint =   0x808000 ;
                public static const PURPLE:uint =   0x800080 ;
                public static const RED:uint =   0xFF0000 ;
                public static const SILVER:uint =   0xC0C0C0 ;
                public static const TEAL:uint =   0x008080 ;
                public static const WHITE:uint =   0xFFFFFF ;
                public static const YELLOW:uint =   0xFFFF00 ;

                //SVG COLOR KEYWORDS - X11 ( INCLUDES THE 16 HTML4 - VGA COLORS )
                //@see http://www.w3.org/TR/css3-color/#svg-color
                public static const ALICE_BLUE:uint =   0xF0F8FF ;
                public static const ANTIQUE_WHITE:uint =   0xFAEBD7 ;
                public static const AQUAMARINE:uint =   0x7FFFD4 ;
                public static const AZURE:uint =   0xF0FFFF ;
                public static const BEIGE:uint =   0xF5F5DC ;
                public static const BISQUE:uint =   0xFFE4C4 ;
                public static const BLANCHED_ALMOND:uint =   0xFFEBCD ;
                public static const BLUE_VIOLET:uint =   0x8A2BE2 ;
                public static const BROWN:uint =   0xA52A2A ;
                public static const BURLY_WOOD:uint =   0xDEB887 ;
                public static const CADET_BLUE:uint =   0x5F9EA0 ;
                public static const CHARTREUSE:uint =   0x7FFF00 ;
                public static const CHOCOLATE:uint =   0xD2691E ;
                public static const CORAL:uint =   0xFF7F50 ;
                public static const CORNFLOWER_BLUE:uint =   0x6495ED ;
                public static const CORNSILK:uint =   0xFFF8DC ;
                public static const CRIMSON:uint =   0xDC143C ;
                public static const CYAN:uint =   0x00FFFF ;
                public static const DARK_BLUE:uint =   0x00008B ;
                public static const DARK_CYAN:uint =   0x008B8B ;
                public static const DARK_GOLDEN_ROD:uint =   0xB8860B ;
                public static const DARK_GRAY:uint =   0xA9A9A9 ;
                public static const DARK_GREY:uint =   0xA9A9A9 ;
                public static const DARK_GREEN:uint =   0x006400 ;
                public static const DARK_KHAKI:uint =   0xBDB76B ;
                public static const DARK_MAGENTA:uint =   0x8B008B ;
                public static const DARK_OLIVE_GREEN:uint =   0x556B2F ;
                public static const DARK_ORANGE:uint =   0xFF8C00 ;
                public static const DARK_ORCHID:uint =   0x9932CC ;
                public static const DARK_RED:uint =   0x8B0000 ;
                public static const DARK_SALMON:uint =   0xE9967A ;
                public static const DARK_SEA_GREEN:uint =   0x8FBC8F ;
                public static const DARK_SLATE_BLUE:uint =   0x483D8B ;
                public static const DARK_SLATE_GRAY:uint =   0x2F4F4F ;
                public static const DARK_SLATE_GREY:uint =   0x2F4F4F ;
                public static const DARK_TURQUOISE:uint =   0x00CED1 ;
                public static const DARK_VIOLET:uint =   0x9400D3 ;
                public static const DEEP_PINK:uint =   0xFF1493 ;
                public static const DEEP_SKY_BLUE:uint =   0x00BFFF ;
                public static const DIM_GRAY:uint =   0x696969 ;
                public static const DIM_GREY:uint =   0x696969 ;
                public static const DODGER_BLUE:uint =   0x1E90FF ;
                public static const FIRE_BRICK:uint =   0xB22222 ;
                public static const FLORAL_WHITE:uint =   0xFFFAF0 ;
                public static const FOREST_GREEN:uint =   0x228B22 ;
                public static const GAINSBORO:uint =   0xDCDCDC ;
                public static const GHOST_WHITE:uint =   0xF8F8FF ;
                public static const GOLD:uint =  0xFFD700 ;
                public static const GOLDEN_ROD:uint =   0xDAA520 ;
                public static const GREY:uint =   0x808080 ;
                public static const GREEN_YELLOW:uint =   0xADFF2F ;
                public static const HONEY_DEW:uint =   0xF0FFF0 ;
                public static const HOT_PINK:uint =   0xFF69B4 ;
                public static const INDIAN_RED:uint =   0xCD5C5C ;
                public static const INDIGO:uint =   0x4B0082 ;
                public static const IVORY:uint =   0xFFFFF0 ;
                public static const KHAKI:uint =   0xF0E68C ;
                public static const LAVENDER:uint =   0xE6E6FA ;
                public static const LAVENDER_BLUSH:uint =   0xFFF0F5 ;
                public static const LAWN_GREEN:uint =   0x7CFC00 ;
                public static const LEMON_CHIFFON:uint =   0xFFFACD ;
                public static const LIGHT_BLUE:uint =   0xADD8E6 ;
                public static const LIGHT_CORAL:uint =   0xF08080 ;
                public static const LIGHT_CYAN:uint =   0xE0FFFF ;
                public static const LIGHT_GOLDEN_ROD_YELLOW:uint =   0xFAFAD2 ;
                public static const LIGHT_GRAY:uint =   0xD3D3D3 ;
                public static const LIGHT_GREY:uint =   0xD3D3D3 ;
                public static const LIGHT_GREEN:uint =   0x90EE90 ;
                public static const LIGHT_PINK:uint =   0xFFB6C1 ;
                public static const LIGHT_SALMON:uint =   0xFFA07A ;
                public static const LIGHT_SEA_GREEN:uint =   0x20B2AA ;
                public static const LIGHT_SKY_BLUE:uint =   0x87CEFA ;
                public static const LIGHT_SLATE_GRAY:uint =   0x778899 ;
                public static const LIGHT_SLATE_GREY:uint =   0x778899 ;
                public static const LIGHT_STEEL_BLUE:uint =   0xB0C4DE ;
                public static const LIGHT_YELLOW:uint =   0xFFFFE0 ;
                public static const LIME_GREEN:uint =   0x32CD32 ;
                public static const LINEN:uint =   0xFAF0E6 ;
                public static const MAGENTA:uint =   0xFF00FF ;
                public static const MEDIUM_AQUA_MARINE:uint =   0x66CDAA ;
                public static const MEDIUM_BLUE:uint =   0x0000CD ;
                public static const MEDIUM_ORCHID:uint =   0xBA55D3 ;
                public static const MEDIUM_PURPLE:uint =   0x9370D8 ;
                public static const MEDIUM_SEA_GREEN:uint =   0x3CB371 ;
                public static const MEDIUM_SLATE_BLUE:uint =   0x7B68EE ;
                public static const MEDIUM_SPRING_GREEN:uint =   0x00FA9A ;
                public static const MEDIUM_TURQUOISE:uint =   0x48D1CC ;
                public static const MEDIUM_VIOLET_RED:uint =   0xC71585 ;
                public static const MIDNIGHT_BLUE:uint =   0x191970 ;
                public static const MINT_CREAM:uint =   0xF5FFFA ;
                public static const MISTY_ROSE:uint =   0xFFE4E1 ;
                public static const MOCCASIN:uint =   0xFFE4B5 ;
                public static const NAVAJO_WHITE:uint =   0xFFDEAD ;
                public static const OLD_LACE:uint =   0xFDF5E6 ;
                public static const OLIVE_DRAB:uint =   0x6B8E23 ;
                public static const ORANGE:uint =   0xFFA500 ;
                public static const ORANGE_RED:uint =   0xFF4500 ;
                public static const ORCHID:uint =   0xDA70D6 ;
                public static const PALE_GOLDEN_ROD:uint =   0xEEE8AA ;
                public static const PALE_GREEN:uint =   0x98FB98 ;
                public static const PALE_TURQUOISE:uint =   0xAFEEEE ;
                public static const PALE_VIOLET_RED:uint =   0xD87093 ;
                public static const PAPAYA_WHIP:uint =   0xFFEFD5 ;
                public static const PEACH_PUFF:uint =   0xFFDAB9 ;
                public static const PERU:uint =   0xCD853F ;
                public static const PINK:uint =   0xFFC0CB ;
                public static const PLUM:uint =   0xDDA0DD ;
                public static const POWDER_BLUE:uint =   0xB0E0E6 ;
                public static const ROSY_BROWN:uint =   0xBC8F8F ;
                public static const ROYAL_BLUE:uint =   0x4169E1 ;
                public static const SADDLE_BROWN:uint =   0x8B4513 ;
                public static const SALMON:uint =   0xFA8072 ;
                public static const SANDY_BROWN:uint =   0xF4A460 ;
                public static const SEA_GREEN:uint =   0x2E8B57 ;
                public static const SEA_SHELL:uint =   0xFFF5EE ;
                public static const SIENNA:uint =   0xA0522D ;
                public static const SKY_BLUE:uint =   0x87CEEB ;
                public static const SLATE_BLUE:uint =   0x6A5ACD ;
                public static const SLATE_GRAY:uint =   0x708090 ;
                public static const SLATE_GREY:uint =   0x708090 ;
                public static const SNOW:uint =   0xFFFAFA ;
                public static const SPRING_GREEN:uint =   0x00FF7F ;
                public static const STEEL_BLUE:uint =   0x4682B4 ;
                public static const TAN:uint =   0xD2B48C ;
                public static const THISTLE:uint =   0xD8BFD8 ;
                public static const TOMATO:uint =   0xFF6347 ;
                public static const TURQUOISE:uint =   0x40E0D0 ;
                public static const VIOLET:uint =   0xEE82EE ;
                public static const WHEAT:uint =   0xF5DEB3 ;
                public static const WHITE_SMOKE:uint =   0xF5F5F5 ;
                public static const YELLOW_GREEN:uint =   0x9ACD32 ;
		  
		 */
		public function Colors() 
		{
			
		}
		
	}

}