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
	public class Level2 extends LevelBase
	{
		private var _anim:AnimLibrary;
		private var _pos:Vector2D;
		//private var _levels:Array;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 5, 0, 3, 1, 1, 1, 1, 1, 1, 1, 3, 0, 5, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
			]
		)
		
		public function Level2()
		{
			mapWidth = 19;
			mapHeight = 10;

			_anim =  CacheLibrary.getInstance().getAnim("Level2_mc");
		}
		
		public override function init():void
		{
			GameGuide.showGuide = false;
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 85;
			_gameScreen.twoStarsTime = 75;
			_gameScreen.oneStarTime = 60;
			_gameScreen.fullStarTime = 105;
			
			_gameScreen.isOrange = true;
			_gameScreen.numKindle = 1;
			
			levelS = new Array(new Level21(this));
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
			createDoors(Constants.NONE, levelS[0], _gameMap.cacheV2D.allocate(216, 264));
			createDoors(Constants.ORANGE);
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