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
	public class Level93 extends LevelBase
	{
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 				
				1, 0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 5, 0, 0, 7, 0, 0, 5, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
				1, 0, 0, 5, 0, 0, 7, 0, 0, 5, 0, 0, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level93(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level9_mc");
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
			bmpBG = _anim.frames[3];
		}
		
		internal function createProperties():void
		{
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			
			createDoors(Constants.NONE, _perentLevel.levelS[0], _gameMap.cacheV2D.allocate(504, 408));
			createDoors(Constants.BLUE, _perentLevel, _gameMap.cacheV2D.allocate(168, 168));
			createDoors(Constants.PURPLE, _perentLevel, _gameMap.cacheV2D.allocate(552, 168));
			createDoors(Constants.NONE, _perentLevel.levelS[1], _gameMap.cacheV2D.allocate(264, 408));
			createKeyRecess(Constants.BLUE);
			createKeyRecess(Constants.PURPLE);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}