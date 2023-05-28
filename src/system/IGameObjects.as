package system
{
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public interface IGameObjects  
	{
		function free():void;
		function update(delta:Number):void;
		function render(bitmapData:BitmapData):void;
	}
	
}