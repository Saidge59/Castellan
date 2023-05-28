package controller
{
	import flash.display.BitmapData;
	import system.IGameObjects;
	/**
	 * ...
	 * @author falcon12
	 */
	public class ObjectController extends Object
	{
		public var objects:Array = [];
		
		public function ObjectController()
		{
			//...
		}
		
		public function add(obj:IGameObjects):void
		{
			objects[objects.length] = obj;
		}
		
		public function remove(obj:IGameObjects):void
		{
			var i:int = objects.length;
			while(--i>-1)
			{
				if (objects[i] == obj)
				{
					objects[i] = null;
					objects.splice(i, 1);
					break;
				}
			}
		}
		
		public function update(delta:Number):void
		{
			var i:int = objects.length;
			var obj:IGameObjects;
			while (--i>-1)
			{
				obj = objects[i];
				obj.update(delta);
			}
		}
		
		public function render(bitmapData:BitmapData):void
		{
			var i:int = objects.length;
			var obj:IGameObjects;
			while (--i>-1)
			{
				obj = objects[i];
				obj.render(bitmapData);
			}
		}
		
		public function clear():void
		{
			while (objects.length>0)
			{
				objects[0].free();
			}
		}
	}
	
}