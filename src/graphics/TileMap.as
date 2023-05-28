package graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import geometry.AABB;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class TileMap 
	{
		public var tileRect:Rectangle;
		public var identifier:int;
		public var tileNum:int;
		
		private var _tileFrames:Vector.<BitmapData>;
		private var _numX:int;
		private var _numY:int;
		private var _tileW:int;
		private var _tileH:int;
		private var _camera:Camera;
		
		private var _tempAabb:AABB;
		private var _cam:Vector2D;
		private var _min:Vector2D;
		private var _max:Vector2D;
		
		public function TileMap() 
		{
			identifier = 0;
			tileRect = new Rectangle(0, 0, Constants.TILE_SIZE, Constants.TILE_SIZE);
			_cam = new Vector2D(0, 0);
			_min = new Vector2D( -Constants.TILE_SIZE, -Constants.TILE_SIZE);
			_max = new Vector2D(Constants.SCREEN_SIZE.x + Constants.TILE_SIZE, Constants.SCREEN_SIZE.y + Constants.TILE_SIZE);
		}
		
		public function classFromCache(clipClass:MovieClip):void
		{
			_numX = clipClass.width/Constants.TILE_SIZE;
			_numY = clipClass.height/Constants.TILE_SIZE;
 
			_tileFrames = new Vector.<BitmapData>( _numX * _numY );
			
			//var map:MovieClip = new clipClass();
				
			var bd:BitmapData = new BitmapData(clipClass.width, clipClass.height, true, 0xFF);
				bd.draw(clipClass);
			
			var tx:int = 0;
			var ty:int = 0;
			var p:Point = new Point(0, 0);
			for ( var j:int = 0; j<_numY; j++ )
			{
				for ( var i:int = 0; i<_numX; i++ )
				{
					var index:int = j * _numX + i;
					var bmd:BitmapData = new BitmapData(Constants.TILE_SIZE, Constants.TILE_SIZE, true, 0xFF);
					var r:Rectangle = new Rectangle(tx, ty, Constants.TILE_SIZE, Constants.TILE_SIZE);
					bmd.copyPixels(bd, r, p);
					_tileFrames[index] = bmd;
					tx += Constants.TILE_SIZE;
				}
				tx = 0;
				ty += Constants.TILE_SIZE;
			}
			tileNum = index;
			
		}
		
		public function get tileBD():BitmapData
		{
			return _tileFrames[identifier];
		}
		
		public function get tilePoint():Point
		{
			var p:Point = new Point();
			var tx:int = identifier % _numX;
			var ty:int = identifier / _numX;
				
			p.x = tx * Constants.TILE_SIZE;
			p.y = ty * Constants.TILE_SIZE;
			
			return p;
		}
		
	}

}