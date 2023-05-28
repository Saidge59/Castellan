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
	public class Level9 extends LevelBase
	{
		private var _anim:AnimLibrary;
		private var _pos:Vector2D;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 0, 0, 4, 0, 4, 0, 4, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 1,
				1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1,
				1, 3, 0, 5, 0, 0, 0, 0, 0, 0, 0, 5, 0, 3, 1,
				1, 1, 1, 1, 1, 0, 6, 2, 7, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level9()
		{
			mapWidth = 15;
			mapHeight = 10;

			_anim =  CacheLibrary.getInstance().getAnim("Level9_mc");
		}
		
		public override function init():void
		{
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 70;
			_gameScreen.twoStarsTime = 60;
			_gameScreen.oneStarTime = 50;
			_gameScreen.fullStarTime = 120;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isPurple = true;
			_gameScreen.numKindle = 3;
			
			levelS = new Array(new Level91(this), new Level92(this), new Level93(this), new LevelDead(this, Constants.NONE));
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
			directionPlayer = Constants.DIRECTION_RIGHT;
			cauldron[cauldron.length] = Constants.ORANGE;

			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createDoors(Constants.BLUE, levelS[2], _gameMap.cacheV2D.allocate(456, 216));
			createDoors(Constants.PURPLE, levelS[2], _gameMap.cacheV2D.allocate(168, 408));
			createDoors(Constants.ORANGE);
			createDoors(Constants.NONE, levelS[0], _gameMap.cacheV2D.allocate(504, 216));
			createDoors(Constants.NONE, levelS[1], _gameMap.cacheV2D.allocate(120, 216));
			createKeyRecess(Constants.ORANGE);
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