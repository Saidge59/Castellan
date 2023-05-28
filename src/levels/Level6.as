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
	public class Level6 extends LevelBase
	{		
		private var _anim:AnimLibrary;
		//private var _levels:Array;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 0, 4, 0, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 4, 0, 4, 0, 1, 1, 1, 1, 1, 
				1, 0, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1,
				1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 2, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
			]
		)
		
		public function Level6()
		{
			mapWidth = 29;
			mapHeight = 10;

			_anim =  CacheLibrary.getInstance().getAnim("Level6_mc");
		}
		
		public override function init():void
		{
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 85;
			_gameScreen.twoStarsTime = 80;
			_gameScreen.oneStarTime = 75;
			_gameScreen.fullStarTime = 150;
			
			_gameScreen.isOrange = true;
			_gameScreen.isGreen = true;
			_gameScreen.isPurple = true;
			_gameScreen.numKindle = 3;
			
			levelS = new Array(new Level_1D_6T(), new Level_1D_3T_1A_LEFT(this, _gameMap.cacheV2D.allocate(552, 360), Constants.NONE, Constants.GREEN, Constants.GREEN), new Level_1D_3T_1A_RIGHT(this, _gameMap.cacheV2D.allocate(840, 360), Constants.NONE, Constants.PURPLE, Constants.PURPLE), new Level61(this));
			levelS[0].createProperties(this, _gameMap.cacheV2D.allocate(120,360), Constants.GREEN);
			levelS[3].createProperties();
			createProperties();
		}
		
		public override function paramLevel():void
		{
			super.paramLevel();
			bmpBG = _anim.frames[0];
		}

		internal function createProperties():void
		{
			lighting = Constants.ORANGE;
			directionPlayer = Constants.DIRECTION_LEFT;
			cauldron[cauldron.length] = Constants.GREEN;
			cauldron[cauldron.length] = Constants.PURPLE;
			
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createDoors(Constants.GREEN, levelS[0], _gameMap.cacheV2D.allocate(312, 312));
			createDoors(Constants.NONE, levelS[1], _gameMap.cacheV2D.allocate(504,312));
			createDoors(Constants.NONE, levelS[2], _gameMap.cacheV2D.allocate(120, 312));
			createDoors(Constants.PURPLE, levelS[3], _gameMap.cacheV2D.allocate(312,312));
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}