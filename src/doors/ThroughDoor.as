package doors 
{
	import levels.Level11;
	import levels.LevelBase;
	import maths.Vector2D;
	import geometry.AABB;
	/**
	 * ...
	 * @author falcon12
	 */
	public class ThroughDoor extends DoorBase
	{
		private var _level:LevelBase;
		
		public function ThroughDoor() 
		{
			_animation.addAnim("Door_orange_mc", "door_Orange");
		}
		
		public override function free():void
		{
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_halfSize = new Vector2D(Constants.DOOR_SIZE.x * .5, Constants.DOOR_SIZE.y * .5);
			switchAnimDoor();
			super.init(p);
			//trace( -Constants.DOOR_SIZE.x * .5, -Constants.DOOR_SIZE.y * .5,Constants.DOOR_SIZE.x, Constants.DOOR_SIZE.y);
		}
		
		public override function update(delta:Number):void
		{
			super.update(delta);

			var contact:Boolean = AABB.overlap(_gameMap.knight, this);
			if (contact && _gameMap.knight.isDown)
			{
				//trace(_gameMap.levelBase.maping[0]);
				//_gameMap.oldLevel = _gameMap.currLevel;
				_gameMap.clear();
				//_gameMap.knight.oldPos = _gameMap.knight.pos;
				_gameMap.currLevel = _level;
				_gameMap.lampa = _level.lamp;
				//_gameMap.tileMap.classFromCache(_level.levelMC);
				_gameMap.CreateTileMap(_level.map, false);
				_gameMap.knight.pos = _level.pos;
			}
		}
		
		public override function switchAnimDoor():void
		{
			graphics.clear();
			graphics.lineStyle(2,0xE5FF80,.5);
			graphics.beginFill(0xCCFF00,.5);
			graphics.drawRect( -Constants.DOOR_SIZE.x * .5, -Constants.DOOR_SIZE.y * .5,
								Constants.DOOR_SIZE.x, Constants.DOOR_SIZE.y);
			graphics.endFill();
		}
		
		public override function set level(value:LevelBase):void
		{
			_level = value;
		}
	}

}