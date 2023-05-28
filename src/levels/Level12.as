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
	public class Level12 extends LevelBase
	{		
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 4, 0, 4, 0, 0, 1, 1, 1,
				1, 0, 0, 4, 0, 0, 0, 0, 0, 4, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 4, 0, 0, 5, 0, 0, 4, 0, 0, 1,
				1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1,
				1, 3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1,
				1, 1, 1, 0, 0, 0, 7, 0, 0, 0, 1, 1, 1,
				1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level12()
		{
			mapWidth = 13;
			mapHeight = 13;
			
			_anim =  CacheLibrary.getInstance().getAnim("Level12_mc");
		}
		
		public override function init():void
		{
			GameGuide.showGuide = false;
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 70;
			_gameScreen.twoStarsTime = 55;
			_gameScreen.oneStarTime = 45;
			_gameScreen.fullStarTime = 145;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isGreen = true;
			_gameScreen.numKindle = 3;
			
			levelS = new Array(new Level121(this), new Level122(this), new Level123(this));
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
			lighting = Constants.GREEN;
			directionPlayer = Constants.DIRECTION_RIGHT;
			
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			
			createDoors(Constants.GREEN, levelS[0], _gameMap.cacheV2D.allocate(552, 216));
			createKeyRecess(Constants.GREEN);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}