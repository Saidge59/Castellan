package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import geometry.AABB;
	import graphics.Camera;
	import maths.Vector2D;
	import levels.LevelBase;
	/**
	 * ...
	 * @author falcon12
	 */
	public class TileRenderer 
	{		
		private var _bitmap:Bitmap;
		private var _bitmapData:BitmapData;
		private var m_tiles:Vector.<BitmapData>;
		private var m_numX:int;
		private var m_numY:int;
		private var m_tileWidth:int;
		private var m_tileHeight:int;
		private var m_camera:Camera;
		private var m_zDepth:Number;
 
		private var m_tempAabb:AABB;
		private var _cam:Vector2D;
		private var _min:Vector2D;
		private var _max:Vector2D;
		private var _tileRectangle:Rectangle;
 
		/// <summary>
		/// Constructor
		/// </summary>	
		public function TileRenderer( tileType:Class, width:int, height:int, camera:Camera, stage:GameMap, zDepth:Number )
		{
			m_tileWidth = width;
			m_tileHeight = height;
			m_camera = camera;
			m_zDepth = zDepth;
 
			m_tempAabb = new AABB( );
			_tileRectangle = new Rectangle(0, 0, m_tileWidth, m_tileHeight);
			_cam = new Vector2D(0, 0);
			_min = new Vector2D( -Constants.TILE_SIZE, -Constants.TILE_SIZE);
			_max = new Vector2D(Constants.SCREEN_SIZE.x + Constants.TILE_SIZE, Constants.SCREEN_SIZE.y + Constants.TILE_SIZE);
 
			m_numX = Constants.SCREEN_SIZE.x/width;
			m_numY = Constants.SCREEN_SIZE.y/height;
 
			m_tiles = new Vector.<BitmapData>( 20 * 12 );
			
			var map:MovieClip = new tileType();
				
			_bitmapData = new BitmapData(960, 576, true, 0xFF);
			//var r:Rectangle = new Rectangle(-480,-288,960, 576);
			//var m:Matrix = new Matrix();
				//m.identity();
				//m.translate( -r.x, -r.y);
			_bitmapData.draw(map);
			
			var tileX:int = 0;
			var tileY:int = 0;
			var pt:Point = new Point(0, 0);
			for ( var j:int = 0; j<12; j++ )
			{
				for ( var i:int = 0; i<20; i++ )
				{
					var index:int = j * 20 + i;
					var bmd:BitmapData = new BitmapData(m_tileWidth, m_tileHeight, true, 0xFF);
					var rect:Rectangle = new Rectangle(tileX, tileY, m_tileWidth, m_tileHeight);
					bmd.copyPixels(_bitmapData, rect, pt);
					m_tiles[index] = bmd;
					tileX += m_tileWidth;
				}
				tileX = 0;
				tileY += m_tileHeight;
			}
	
			update();
			
			_bitmap = new Bitmap(_bitmapData);
			_bitmap.x = -Constants.WORLD_HALF_SIZE.x;
			_bitmap.y = -Constants.WORLD_HALF_SIZE.y;
			stage.addChildAt(_bitmap,0);
		}		

		public function update( ):void
		{
			/*PositionLogic( function( index:int, xCoord:int, yCoord:int ):void
			{
				//m_tiles[index].x = xCoord;
				//m_tiles[index].y = yCoord;
			});*/
			_bitmapData.lock();
			_bitmapData.fillRect(new Rectangle(0, 0, 960, 576), 0x00);
			var p:Point = new Point();
			var bmd:BitmapData;
			for ( var k:int = 0; k<m_tiles.length; k++ )
			{
				bmd = m_tiles[k] as BitmapData;
				var s:int = k % 20;
				var q:int = k / 20;
				
				var tileX:int = s * Constants.TILE_SIZE;
				var tileY:int = q * Constants.TILE_SIZE;
				p.x = tileX;
				p.y = tileY;

				_cam.init(tileX, tileY);
				_cam.subFrom(Constants.WORLD_HALF_SIZE);
				if (m_camera.onScreenParam(_cam,_min,_max))
				{
					_bitmapData.copyPixels(bmd, _tileRectangle, p);
				}				
			}
			_bitmapData.unlock();
		}
		
		/// <summary>
		/// This function runs through and computes the position of each tile - it takes a closeure 
		/// so you can insert your own inner logic to run at each location
		/// </summary>
		private function PositionLogic( action:Function ):void
		{
			m_camera.getWorldSpaceOnScreenAABB( m_tempAabb );
 
			var screenTopLeft:Vector2D = m_tempAabb.topLeft;
 
			// stop the background from crawling around due to pixel trucation
			screenTopLeft.roundTo( );
 
			// calculate the top left of the screen, scaled for z depth
			var scaledTopLeft:Vector2D = screenTopLeft.mulValue( 1/m_zDepth );
			var tileX:int = Math.floor(scaledTopLeft.x / m_tileWidth);
			var tileY:int = Math.floor(scaledTopLeft.y / m_tileHeight);
 
			// this offset corrects for translation caused by the divide by z
			var offset:Vector2D = scaledTopLeft.sub( screenTopLeft );
 
			// get the starting tile coords
			var startX:int = tileX*m_tileWidth - offset.x;
			var startY:int = tileY*m_tileHeight - offset.y;
			var xCoord:int = startX;
			var yCoord:int = startY;
 
			// run though and call the closure for each tile position
			for ( var j:int = 0; j<m_numY; j++ )
			{
				xCoord = startX;
				for ( var i:int = 0; i<m_numX; i++ )
				{
					var index:int = j*m_numX+i;
 
					action(index, xCoord, yCoord);
 
					xCoord += m_tileWidth;
				}
				yCoord += m_tileHeight;
			}
		}
 
		
	}

}