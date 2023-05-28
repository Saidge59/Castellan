package levels
{
	import controller.PropertiesController;
	import doors.DoorBase;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import gamemenu.GameGuide;
	import gamemenu.GameSave;
	import graphics.*;
	import maths.Vector2D;
	import graphics.TileMapCache;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class Level13 extends LevelBase
	{		
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 0, 1,
				1, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 7, 0, 7, 0, 7, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 5, 0, 10, 0, 5, 0, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 1, 0, 5, 0, 10, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 0, 0, 2, 0, 0, 5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 5, 0, 3, 0, 6, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 6, 0, 3, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level13()
		{
			mapWidth = 27;
			mapHeight = 13;
			
			_anim =  CacheLibrary.getInstance().getAnim("Level13_mc");
		}
		
		public override function init():void
		{
			GameGuide.showGuide = false;
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 30;
			_gameScreen.twoStarsTime = 25;
			_gameScreen.oneStarTime = 20;
			_gameScreen.fullStarTime = 135;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isPurple = true;
			_gameScreen.numKindle = 3;
			
			levelS = new Array(new Level131(this), new Level_2D_5T_1C(), new Level_2D_5T_1C(), new Level_1D_6T(), new Level_1D_6T());
			levelS[0].createProperties();
			levelS[1].createProperties(this, this, _gameMap.cacheV2D.allocate(120, 312), _gameMap.cacheV2D.allocate(504, 456), Constants.NONE, Constants.NONE, Constants.BLUE);
			levelS[2].createProperties(this, this, _gameMap.cacheV2D.allocate(792, 456), _gameMap.cacheV2D.allocate(1176, 312), Constants.NONE, Constants.NONE, Constants.PURPLE);
			levelS[3].createProperties(this, _gameMap.cacheV2D.allocate(312, 312), Constants.BLUE);
			levelS[4].createProperties(this, _gameMap.cacheV2D.allocate(984, 312), Constants.PURPLE);
			createProperties();
		}
		
		public override function paramLevel():void
		{
			super.paramLevel();
			bmpBG = _anim.frames[0];
		}

		private function createProperties():void
		{
			lighting = Constants.ORANGE;
			directionPlayer = Constants.DIRECTION_LEFT;
			
			cauldron[cauldron.length] = Constants.BLUE;
			cauldron[cauldron.length] = Constants.PURPLE;
			
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.BLUE);
			createTorches(Constants.PURPLE);
			
			createDoors(Constants.NONE, levelS[1], _gameMap.cacheV2D.allocate(168, 360));
			createDoors(Constants.BLUE, levelS[3], _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.NONE, levelS[0], _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.PURPLE, levelS[4], _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.NONE, levelS[2], _gameMap.cacheV2D.allocate(456, 360));
			createDoors(Constants.NONE, levelS[1], _gameMap.cacheV2D.allocate(456, 360));
			createDoors(Constants.NONE, levelS[2], _gameMap.cacheV2D.allocate(168, 360));
			createDoors(Constants.NONE, levelS[0], _gameMap.cacheV2D.allocate(168, 456));
			createDoors(Constants.NONE, levelS[0], _gameMap.cacheV2D.allocate(456, 456));
			
			createKeyRecess(Constants.BLUE);
			createKeyRecess(Constants.ORANGE);
			createKeyRecess(Constants.PURPLE);
			
			createEnemy(Constants.BLUE, Constants.DIRECTION_RIGHT);
			createEnemy(Constants.PURPLE, Constants.DIRECTION_LEFT);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}