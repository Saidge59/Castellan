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
	public class Level11 extends LevelBase
	{		
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 4, 0, 0, 0, 4, 0, 1, 1, 1,
				1, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 5, 0, 2, 0, 5, 0, 0, 0, 1,
				1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
				1, 3, 0, 5, 0, 0, 5, 0, 0, 5, 0, 3, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level11()
		{
			mapWidth = 13;
			mapHeight = 13;

			_anim =  CacheLibrary.getInstance().getAnim("Level11_mc");
		}
		
		public override function init():void
		{
			GameGuide.showGuide = false;
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 90;
			_gameScreen.twoStarsTime = 75;
			_gameScreen.oneStarTime = 60;
			_gameScreen.fullStarTime = 150;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isGreen = true;
			_gameScreen.numKindle = 3;
			
			levelS = new Array(new Level111(this), new Level112(this), new Level113(this));
			levelS[0].createProperties();
			levelS[1].createProperties();
			levelS[2].createProperties();
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
			
			createTorches(Constants.GREEN);
			createTorches(Constants.BLUE);
			createTorches(Constants.GREEN);
			createTorches(Constants.ORANGE);
			createTorches(Constants.BLUE);
			
			createDoors(Constants.GREEN, levelS[2], _gameMap.cacheV2D.allocate(216, 264));
			createDoors(Constants.BLUE, levelS[2], _gameMap.cacheV2D.allocate(408, 264));
			createDoors(Constants.NONE, levelS[1], _gameMap.cacheV2D.allocate(504, 504));
			createDoors(Constants.ORANGE);
			createDoors(Constants.NONE, levelS[0], _gameMap.cacheV2D.allocate(120, 504));
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}