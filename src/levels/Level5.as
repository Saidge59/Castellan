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
	public class Level5 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 
				1, 1, 1, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 5, 0, 2, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 3, 7, 3, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level5()
		{
			mapWidth = 21;
			mapHeight = 10;
			
			_anim =  CacheLibrary.getInstance().getAnim("Level5_mc");
		}
		
		public override function init():void
		{
			if (GameSave.countScene < 7)
			{
				GameSave.countScene = 7;
				_gameGuide.openSceneTo = 6;
			}
			GameGuide.showGuide = true;
			
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 110;
			_gameScreen.twoStarsTime = 105;
			_gameScreen.oneStarTime = 100;
			_gameScreen.fullStarTime = 135;
			
			_gameScreen.isOrange = true;
			_gameScreen.isGreen = true;
			_gameScreen.numKindle = 2;
			
			levelS = new Array(new Level51(this));
			levelS[0].createProperties();
			createProperties();
		}
		
		public override function paramLevel():void
		{			
			super.paramLevel();
			bmpBG = _anim.frames[0];
		}
		
		internal function createProperties():void
		{
			lighting = Constants.GREEN;
			directionPlayer = Constants.DIRECTION_RIGHT;
			
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createDoors(Constants.ORANGE);
			createDoors(Constants.GREEN, levelS[0], _gameMap.cacheV2D.allocate(312, 504));
			createKeyRecess(Constants.GREEN);
			createEnemy(Constants.GREEN, Constants.DIRECTION_LEFT);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}