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
	public class Level71 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 4, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4, 0, 0, 1,
				1, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 5, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1,
				1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1,
				1, 3, 0, 5, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 5, 0, 3, 1,
				1, 1, 1, 1, 1, 1, 1, 0, 5, 0, 0, 5, 0, 0, 5, 0, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level71(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level7_mc");
			//createProperties();
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			mapWidth = 23;
			mapHeight = 10;
			
			super.paramLevel();
			bmpBG = _anim.frames[1];
		}
		
		internal function createProperties():void
		{
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			
			createKeyRecess(Constants.GREEN);
			createKeyRecess(Constants.BLUE);
			
			createDoors(Constants.NONE, _perentLevel, _gameMap.cacheV2D.allocate(312, 264));
			createDoors(Constants.NONE, _perentLevel.levelS[1], _gameMap.cacheV2D.allocate(168, 360));
			createDoors(Constants.NONE, _perentLevel.levelS[2], _gameMap.cacheV2D.allocate(456, 360));
			createDoors(Constants.BLUE, _perentLevel.levelS[1], _gameMap.cacheV2D.allocate(456, 360));
			createDoors(Constants.ORANGE);
			createDoors(Constants.GREEN, _perentLevel.levelS[2], _gameMap.cacheV2D.allocate(168, 360));
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}