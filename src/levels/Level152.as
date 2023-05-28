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
	public class Level152 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 4, 0, 4, 0, 4, 0, 1, 1, 1,
				1, 1, 1, 0, 0, 4, 0, 4, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 7, 10, 6, 0, 0, 0, 0, 1,
				1, 0, 5, 0, 1, 1, 1, 1, 1, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level152(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level15_mc");
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			mapWidth = 13;
			mapHeight = 10;
			
			super.paramLevel();
			bmpBG = _anim.frames[1];
		}
		
		internal function createProperties():void
		{
			cauldron[cauldron.length] = Constants.BLUE;
			
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			
			createDoors(Constants.BLUE, _perentLevel.levelS[6], _gameMap.cacheV2D.allocate(312, 240));
			createDoors(Constants.NONE, _perentLevel, _gameMap.cacheV2D.allocate(168, 408));
			
			createKeyRecess(Constants.BLUE);
			
			createEnemy(Constants.BLUE, Constants.DIRECTION_LEFT);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}