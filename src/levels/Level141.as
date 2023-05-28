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
	public class Level141 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 4, 0, 4, 0, 0, 0, 0, 0, 4, 0, 4, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 11, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 11, 1,
				1, 1, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 1, 1,
				1, 0, 0, 1, 1, 1, 0, 4, 0, 4, 0, 1, 1, 1, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 1, 1,
				1, 0, 10, 5, 0, 0, 1, 1, 1, 1, 1, 0, 0, 5, 10, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level141(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level14_mc");
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			mapWidth = 17;
			mapHeight = 10;
			
			super.paramLevel();
			bmpBG = _anim.frames[1];
		}
		
		internal function createProperties():void
		{
			cauldron[cauldron.length] = Constants.ORANGE;
			
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			
			createDoors(Constants.NONE, _perentLevel.levelS[2], _gameMap.cacheV2D.allocate(168, 360));
			createDoors(Constants.NONE, _perentLevel.levelS[1], _gameMap.cacheV2D.allocate(456, 360));
			createDoors(Constants.PURPLE, _perentLevel.levelS[3], _gameMap.cacheV2D.allocate(408, 312));
			createDoors(Constants.GREEN, _perentLevel.levelS[4], _gameMap.cacheV2D.allocate(216, 312));
			
			createKeyRecess(Constants.ORANGE);
			
			createArtillery(Constants.DIRECTION_RIGHT, 15, 60);
			createArtillery(Constants.DIRECTION_LEFT, -15, 60);
			
			createEnemy(Constants.PURPLE, Constants.DIRECTION_RIGHT);
			createEnemy(Constants.GREEN, Constants.DIRECTION_LEFT);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}