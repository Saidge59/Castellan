package levels
{
	import controller.PropertiesController;
	import doors.DoorBase;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import gamemenu.GameSave;
	import graphics.*;
	import maths.Vector2D;
	import graphics.TileMapCache;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class Level51 extends LevelBase
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
				1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 10, 7, 0, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 3, 6, 0, 0, 0, 0, 0, 0, 0, 6, 3, 1,
				1, 1, 1, 1, 1, 0, 5, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level51(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level5_mc");
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
			cauldron[cauldron.length] = Constants.GREEN;
			cauldron[cauldron.length] = Constants.ORANGE;
			
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createDoors(Constants.GREEN, _perentLevel, _gameMap.cacheV2D.allocate(888, 312));
			createKeyRecess(Constants.ORANGE);
			createEnemy(Constants.ORANGE, Constants.DIRECTION_RIGHT);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}