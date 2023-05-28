package 
{
	import maths.Vector2D;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class Constants
	{
		public static const PROJECT_DATE:String = "Castellan - 10.10.2013";
		public static const SCREEN_SIZE:Vector2D = new Vector2D(624, 480);
		public static const SCREEN_HALF_SIZE:Vector2D = new Vector2D(312, 240);
		public static var WORLD_HALF_SIZE:Vector2D;
		public static var WORLD_SIZE:Vector2D;
		
		public static const TILE_SIZE:Number = 48;
		public static const TILE_HALF_SIZE:Number = 24;
		//public static const TILE_SIZE:Vector2 = new Vector2(40, 40);
		//public static const TILE_HALF_SIZE:Vector2 = new Vector2(20, 20);
		public static const PLAYER_SIZE:Vector2D = new Vector2D(24, 46);
		public static const PLAYER_HALF_SIZE:Vector2D = new Vector2D(12, 23);
		
		public static const MAX_SPEED:int = 200;
		public static const MAX_SPEED_2:int = 900;
		public static const SPEED_CORE:int = 300;
		
		public static const ORANGE:int = 0;
		public static const BLUE:int = 1;
		public static const GREEN:int = 2;
		public static const PURPLE:int = 3;
		public static const NONE:int = 4;
		
		public static const DIRECTION_RIGHT:int = 1;
		public static const DIRECTION_LEFT:int = -1;
		
		static public const EXPAND:Vector2D = new Vector2D(1,1);
		public static const GRAVITY:Number = 70;
		public static const SPEED_MOVE:Number = 15;
		public static const JUMP:Number = 900;
		public static const SUB_TIME:Number = 10;
		
		public static const DOOR_SIZE:Vector2D = new Vector2D(58, 56);
		public static const CAULDRON_SIZE:Vector2D = new Vector2D(48, 36);
		public static const TORCH_SIZE:Vector2D = new Vector2D(30, 30);
		public static const KEY_SIZE:Vector2D = new Vector2D(48, 36);
		public static const CORE_HALF_SIZE:int = 10;
		
	}
	
}