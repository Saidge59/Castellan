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
	public class Level14 extends LevelBase
	{		
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 4, 0, 4, 0, 4, 0, 0, 1, 1, 1, 1, 1,
				1, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
				1, 0, 5, 0, 0, 5, 0, 0, 5, 0, 0, 2, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level14()
		{
			mapWidth = 15;
			mapHeight = 10;
			
			_anim =  CacheLibrary.getInstance().getAnim("Level14_mc");
		}
		
		public override function init():void
		{
			GameGuide.showGuide = false;
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 55;
			_gameScreen.twoStarsTime = 50;
			_gameScreen.oneStarTime = 45;
			_gameScreen.fullStarTime = 115;
			
			_gameScreen.isOrange = true;
			_gameScreen.isGreen = true;
			_gameScreen.isPurple = true;
			_gameScreen.numKindle = 3;
			
			levelS = new Array(new Level141(this), new Level142(this), new Level143(this), new Level144(this), new Level145(this));
			levelS[0].createProperties();
			levelS[1].createProperties();
			levelS[2].createProperties();
			levelS[3].createProperties();
			levelS[4].createProperties();
			//levelS[3].createProperties(levelS[0], _gameMap.cacheV2D.allocate(168,408), Constants.PURPLE);
			//levelS[4].createProperties(levelS[0], _gameMap.cacheV2D.allocate(648,408), Constants.GREEN);
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
			createTorches(Constants.ORANGE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.GREEN);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.PURPLE);
			
			createDoors(Constants.NONE, levelS[1], _gameMap.cacheV2D.allocate(168, 360));
			createDoors(Constants.ORANGE);
			createDoors(Constants.NONE, levelS[2], _gameMap.cacheV2D.allocate(456, 360));
			
			createArtillery(Constants.DIRECTION_LEFT, -15, 60);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}