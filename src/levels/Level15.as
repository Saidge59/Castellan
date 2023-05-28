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
	public class Level15 extends LevelBase
	{		
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 4, 0, 4, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 5, 0, 0, 0, 0, 0, 5, 0, 0, 1,
				1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1,
				1, 0, 0, 4, 0, 0, 5, 0, 0, 4, 0, 0, 1,
				1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 3, 0, 5, 0, 0, 2, 0, 0, 5, 0, 3, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level15()
		{
			mapWidth = 13;
			mapHeight = 10;
			
			_anim =  CacheLibrary.getInstance().getAnim("Level15_mc");
		}
		
		public override function init():void
		{
			GameGuide.showGuide = false;
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 30;
			_gameScreen.twoStarsTime = 25;
			_gameScreen.oneStarTime = 20;
			_gameScreen.fullStarTime = 100;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isGreen = true;
			_gameScreen.numKindle = 3;
			
			levelS = new Array(new Level151(this), new Level152(this), new Level153(this),  new Level_1D_6T(),  new Level_1D_6T(), new LevelDead(this, Constants.GREEN), new LevelDead(this, Constants.BLUE));
			levelS[0].createProperties();
			levelS[1].createProperties();
			levelS[2].createProperties();
			levelS[3].createProperties(this, _gameMap.cacheV2D.allocate(168, 168), Constants.GREEN);
			levelS[4].createProperties(this, _gameMap.cacheV2D.allocate(456, 408), Constants.BLUE);
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
			directionPlayer = Constants.DIRECTION_RIGHT;
			
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			
			createDoors(Constants.GREEN, levelS[3], _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.NONE, levelS[0], _gameMap.cacheV2D.allocate(120, 360));
			createDoors(Constants.NONE, levelS[2], _gameMap.cacheV2D.allocate(792, 360));
			createDoors(Constants.NONE, levelS[1], _gameMap.cacheV2D.allocate(504, 360));
			createDoors(Constants.BLUE, levelS[4], _gameMap.cacheV2D.allocate(312, 312));
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}