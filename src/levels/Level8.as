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
	public class Level8 extends LevelBase
	{
		private var _anim:AnimLibrary;
		private var _pos:Vector2D;
		//private var _levels:Array;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 1, 1, 0, 4, 0, 1, 1, 1, 0, 4, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 4, 0, 4, 0, 0, 0, 4, 0, 4, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 4, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 5, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 0, 7, 0, 6, 0, 6, 0, 7, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
			]
		)
		
		public function Level8()
		{
			mapWidth = 19;
			mapHeight = 10;

			_anim =  CacheLibrary.getInstance().getAnim("Level8_mc");
		}
		
		public override function init():void
		{
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 85;
			_gameScreen.twoStarsTime = 80;
			_gameScreen.oneStarTime = 75;
			_gameScreen.fullStarTime = 170;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isGreen = true;
			_gameScreen.numKindle = 3;
			
			levelS = new Array(new Level81(this), new Level_1D_6T(), new Level_1D_6T());
			levelS[0].createProperties();
			levelS[1].createProperties(this, _gameMap.cacheV2D.allocate(120,360), Constants.GREEN);
			levelS[2].createProperties(this, _gameMap.cacheV2D.allocate(792,360), Constants.BLUE);
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
			cauldron[cauldron.length] = Constants.GREEN;
			cauldron[cauldron.length] = Constants.BLUE;

			createTorches(Constants.BLUE);
			createTorches(Constants.GREEN);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.BLUE);
			createTorches(Constants.GREEN);
			createTorches(Constants.BLUE);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.BLUE);
			
			createDoors(Constants.NONE, levelS[0], _gameMap.cacheV2D.allocate(456, 360));
			createDoors(Constants.GREEN, levelS[1], _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.BLUE, levelS[2], _gameMap.cacheV2D.allocate(312, 312));
			createKeyRecess(Constants.BLUE);
			createKeyRecess(Constants.GREEN);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

		public override function get pos():Vector2D
		{
			return _pos;
		}

	}
	
}