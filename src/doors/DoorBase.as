package doors 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import gamemenu.GameScreen;
	import graphics.Animation;
	import levels.LevelBase;
	import lighting.Lighting;
	import maths.Vector2D;
	import physics.PhysicsObject;
	import system.IGameObjects;
	import geometry.*;
	/**
	 * ...
	 * @author falcon12
	 */
	public class DoorBase extends PhysicsObject
	{		
		public var toClass:LevelBase;
		public var movePos:Vector2D;

		protected var _animDoor:Animation;
		protected var _animFlag:Animation;
		protected var _colorDoor:int;
		protected var _renderMin:Vector2D;
		protected var _renderMax:Vector2D;
		protected var _openDoor:Boolean;
	
		
		public function DoorBase() 
		{
			_animDoor = new Animation();
			_animFlag = new Animation();
		}
		
		public override function free():void
		{
			_gameMap.door.remove(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			
			_gameMap.door.add(this);
			super.init(p);
			pos = p;
		}
		
		public override function update(delta:Number):void
		{
			
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			
		}
		
		public function switchAnimDoor():void
		{
			//...
		}
		
		public function set level(value:LevelBase):void
		{
			//...
		}

		public function set colorDoor(color:int):void
		{
			_colorDoor = color;
			switch(color)
			{
				case Constants.ORANGE:
					_animDoor.goToFrame(0);
					break;
				case Constants.BLUE:
					_animDoor.goToFrame(2);
					break;
				case Constants.GREEN:
					_animDoor.goToFrame(4);
					break;
				case Constants.PURPLE:
					_animDoor.goToFrame(6);
					break;
				case Constants.NONE:
					_animDoor.goToFrame(9);
					break;
			}
		}
		
	}

}