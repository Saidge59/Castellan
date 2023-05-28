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
	public class Level3 extends LevelBase
	{		
		private var _anim:AnimLibrary;
		//private var _levels:Array;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 0, 0, 0, 4, 0, 0, 0, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 1,
				1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 5, 0, 0, 6, 0, 1,
				1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 0, 5, 0, 0, 6, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1
			]
		)
		
		public function Level3()
		{
			mapWidth = 19;
			mapHeight = 13;

			_anim =  CacheLibrary.getInstance().getAnim("Level3_mc");
		}
		
		public override function init():void
		{
			if (GameSave.countScene < 5)
			{
				GameSave.countScene = 5;
				_gameGuide.openSceneTo = 4;
			}
			else _gameGuide.openSceneTo = 4;
			GameGuide.showGuide = true;
			
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 85;
			_gameScreen.twoStarsTime = 75;
			_gameScreen.oneStarTime = 70;
			_gameScreen.fullStarTime = 120;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.numKindle = 2;
			
			levelS = new Array(new Level31(this));
			createProperties();
		}
		
		public override function paramLevel():void
		{
			super.paramLevel();
			bmpBG = _anim.frames[0];
		}

		private function createProperties():void
		{
			lighting = Constants.BLUE;
			directionPlayer = Constants.DIRECTION_LEFT;
			cauldron[cauldron.length] = Constants.BLUE;
			cauldron[cauldron.length] = Constants.ORANGE;
			
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createDoors(Constants.ORANGE);
			createDoors(Constants.BLUE, levelS[0], _gameMap.cacheV2D.allocate(312,504));
			createKeyRecess(Constants.BLUE);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}