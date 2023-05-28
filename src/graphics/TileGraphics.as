package graphics 
{
	import flash.display.BitmapData;
	import maths.Vector2D;
	import physics.PhysicsObject;
	/**
	 * ...
	 * @author falcon12
	 */
	public class TileGraphics extends PhysicsObject
	{
		
		public function TileGraphics() 
		{
			
		}
		
		public override function free():void
		{
			_gameMap.cacheTileGraphics.set(this);
			_gameMap.tiles.remove(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_gameMap.tiles.add(this);
			super.init(p);
			
			_halfSize = _gameMap.cacheV2D.allocate(Constants.TILE_HALF_SIZE, Constants.TILE_HALF_SIZE);
				// render shape
			drawBox( -Constants.TILE_HALF_SIZE, -Constants.TILE_HALF_SIZE, Constants.TILE_HALF_SIZE, Constants.TILE_HALF_SIZE, 0x008080); 
		}
		
		public override function update(delta:Number):void
		{
		}
		
		public override function render(bitmapData:BitmapData):void
		{
		}		
	}

}