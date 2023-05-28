package doors 
{
	import maths.Vector2D
	/**
	 * ...
	 * @author falcon12
	 */
	public class EntranceDoor extends DoorBase
	{
		
		public function EntranceDoor() 
		{
			
		}
		
		public override function free():void
		{
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_halfSize = new Vector2D(Constants.DOOR_SIZE.x * .5, Constants.DOOR_SIZE.y * .5);
			graphics.clear();
			graphics.lineStyle(2,0x3AE2FF,.5);
			graphics.beginFill(0x72B8F5,.5);
			graphics.drawRect( -Constants.DOOR_SIZE.x * .5, -Constants.DOOR_SIZE.y * .5,
								Constants.DOOR_SIZE.x, Constants.DOOR_SIZE.y);
			graphics.endFill();
			super.init(p);
		}
		
		public override function update(delta:Number):void
		{
			super.update(delta);
		}
		
	}

}