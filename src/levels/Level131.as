package levels
{
	import controller.PropertiesController;
	import doors.DoorBase;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import graphics.*;
	import maths.Vector2D;
	import graphics.TileMapCache;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class Level131 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 4, 0, 4, 0, 0, 1, 1, 1,
				1, 0, 0, 4, 0, 0, 0, 0, 0, 4, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 3, 0, 5, 0, 0, 0, 0, 0, 5, 0, 3, 1,
				1, 1, 1, 1, 1, 0, 5, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level131(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level13_mc");
			//createProperties();
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			mapWidth = 13;
			mapHeight = 13;
			
			super.paramLevel();
			bmpBG = _anim.frames[1];
		}
		
		internal function createProperties():void
		{
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createDoors(Constants.NONE, _perentLevel, _gameMap.cacheV2D.allocate(648, 312));
			createDoors(Constants.NONE, _perentLevel, _gameMap.cacheV2D.allocate(120, 504));
			createDoors(Constants.NONE, _perentLevel, _gameMap.cacheV2D.allocate(1176, 504));
			createDoors(Constants.ORANGE);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}