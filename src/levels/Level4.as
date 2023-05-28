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
	public class Level4 extends LevelBase
	{		
		private var _anim:AnimLibrary;
		//private var _levels:Array;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 4, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
				1, 3, 0, 5, 0, 0, 4, 0, 0, 5, 0, 3, 1,
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 4, 0, 0, 7, 0, 7, 0, 0, 4, 0, 1,
				1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
				1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1,
				1, 0, 6, 0, 1, 1, 1, 1, 1, 0, 6, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level4()
		{
			mapWidth = 13;
			mapHeight = 19;

			_anim =  CacheLibrary.getInstance().getAnim("Level4_mc");
		}
		
		public override function init():void
		{
			GameGuide.showGuide = false;
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 75;
			_gameScreen.twoStarsTime = 60;
			_gameScreen.oneStarTime = 45;
			_gameScreen.fullStarTime = 120;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isGreen = true;
			_gameScreen.numKindle = 3;
			
			levelS = new Array(new Level41(this),new Level42(this));
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
			cauldron[cauldron.length] = Constants.GREEN;
			
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createDoors(Constants.BLUE, levelS[0], _gameMap.cacheV2D.allocate(360,312));
			createDoors(Constants.GREEN, levelS[1], _gameMap.cacheV2D.allocate(312, 312));
			createKeyRecess(Constants.ORANGE);
			createKeyRecess(Constants.BLUE);
			createKeyRecess(Constants.GREEN);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}