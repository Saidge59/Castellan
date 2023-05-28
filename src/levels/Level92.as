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
	public class Level92 extends LevelBase
	{
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 0, 0, 4, 0, 0, 1, 1, 1, 1, 1, 				
				1, 0, 0, 0, 4, 0, 4, 0, 0, 4, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 1,
				1, 0, 5, 0, 0, 6, 3, 0, 0, 4, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 0, 4, 0, 0, 11, 1, 
				1, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 
				1, 0, 5, 0, 0, 5, 0, 0, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level92(perentLevel:LevelBase)
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
			bmpBG = _anim.frames[2];
		}
		
		internal function createProperties():void
		{
			cauldron[cauldron.length] = Constants.PURPLE;
			
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			
			createDoors(Constants.NONE, _perentLevel, _gameMap.cacheV2D.allocate(552, 360));
			createDoors(Constants.NONE, _perentLevel.levelS[3], _gameMap.cacheV2D.allocate(312, 240));
			createDoors(Constants.NONE, _perentLevel.levelS[2], _gameMap.cacheV2D.allocate(456, 408));
			
			createArtillery(Constants.DIRECTION_LEFT, -15 , 60);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}