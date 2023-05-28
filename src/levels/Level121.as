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
	public class Level121 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 5, 0, 0, 0, 5, 0, 0, 0, 5, 0, 0, 1,
				1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1,
				1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 6, 0, 6, 0, 0, 5, 0, 0, 7, 0, 7, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level121(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level12_mc");
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			mapWidth = 15;
			mapHeight = 10;
			
			super.paramLevel();
			bmpBG = _anim.frames[1];
		}
		
		internal function createProperties():void
		{
			cauldron[cauldron.length] = Constants.BLUE;
			cauldron[cauldron.length] = Constants.ORANGE;

			createDoors(Constants.BLUE, _perentLevel.levelS[1], _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.NONE, _perentLevel.levelS[2], _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.GREEN, _perentLevel, _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.NONE, _perentLevel.levelS[1], _gameMap.cacheV2D.allocate(312, 504));
			
			createKeyRecess(Constants.ORANGE);
			createKeyRecess(Constants.BLUE);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}