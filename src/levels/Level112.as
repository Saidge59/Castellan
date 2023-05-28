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
	public class Level112 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 4, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 5, 0, 0, 0, 6, 0, 1,
				1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 3, 7, 3, 1, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 0, 5, 0, 3, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level112(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level11_mc");
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
			bmpBG = _anim.frames[2];
		}
		
		internal function createProperties():void
		{
			cauldron[cauldron.length] = Constants.GREEN;
			
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			
			createDoors(Constants.NONE, _perentLevel.levelS[1], _gameMap.cacheV2D.allocate(312, 504));
			createDoors(Constants.NONE, _perentLevel.levelS[1], _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.NONE, _perentLevel, _gameMap.cacheV2D.allocate(168, 504));
			
			createKeyRecess(Constants.GREEN);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}