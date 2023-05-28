package controller 
{
	import levels.LevelBase;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class PropertiesController
	{
		public var pos:Vector2D;
		
		// TORCH
		public var isIncluded:Boolean;
		public var isDisparity:Boolean;
		public var colorTorch:int;
		public var colorFire:int;
		
		// DOOR
		public var colorDoor:int;
		public var movePos:Vector2D;
		public var toClass:LevelBase;
		
		// KEY
		public var playOnce:Boolean;
		public var isPicked:Boolean;
		public var colorKey:int;
		
		// HELMET
		public var colorHelmet:int;
		public var direction:int;

		// ARTILLERY
		public var speedCore:int;
		public var timeDelay:int;
		
		public function PropertiesController() 
		{
			
		}
		
		public function init(p:Vector2D,included:Boolean):void
		{
			this.pos = p;
			this.isIncluded = included;
		}
		
	}

}