package doors 
{
	import clue.Key;
	import flash.display.BitmapData;
	import lighting.Lighting;
	import maths.Vector2D;
	import geometry.*;
	/**
	 * ...
	 * @author falcon12
	 */
	public class ExitDoor extends DoorBase
	{
		
		public function ExitDoor() 
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
			//switchAnimDoor();
			
			super.init(p);
		}
		
		public override function update(delta:Number):void
		{
			super.update(delta);

			/*var keys:Array = _gameMap.keys.objects;
			var i:int = keys.length;
			var key:Key;
			
			while (--i>-1)
			{
				key = keys[i];
				if(_gameMap.keyPicked)
				{
					getGraphics(.5);
					var contact:Boolean = AABB.overlap(_gameMap.knight, this);
					if (contact && _gameMap.knight.isDown)
					{
						trace("LEVEL COMPLETE!");
					}
				}
			}*/
			
			if(_gameMap.keyPicked)
			{
				var contact:Boolean = AABB.overlap(_gameMap.knight, this);
				if (contact && _gameMap.knight.isDown)
				{
					trace("LEVEL COMPLETE!");
				}
			}
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			_animation.nextFrame();

			_point.x = _pos.x + _animation.offsetX + _gameMap.x;
			_point.y = _pos.y + _animation.offsetY + _gameMap.y;
			bitmapData.copyPixels(_animation.bmp, _animation.rect, _point, null, null, true);
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