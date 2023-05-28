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
	public class ReturnDoor extends DoorBase
	{
		
		public function ReturnDoor() 
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
				_gameMap.clear();
				//trace(_gameMap.knight.pos, _gameMap.knight.oldPos);
				//_gameMap.knight.pos = _gameMap.knight.oldPos;
				_gameMap.currLevel = _gameMap.perentLevel;
				_gameMap.lampa = _gameMap.perentLevel.lamp;
				//_gameMap.tileMap.classFromCache(_gameMap.perentLevel.levelMC);
				_gameMap.CreateTileMap(_gameMap.perentLevel.map, false);
				
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
		
	}

}