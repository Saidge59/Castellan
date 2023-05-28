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
	public class Level7 extends LevelBase
	{
		private var _anim:AnimLibrary;
		private var _pos:Vector2D;
		//private var _levels:Array;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 4, 0, 4, 0, 0, 1, 1, 1,
				1, 0, 0, 4, 0, 0, 0, 0, 0, 4, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 1,
				1, 3, 2, 0, 0, 1, 1, 1, 0, 0, 0, 3, 1,
				1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 1,
				1, 0, 6, 0, 1, 1, 1, 1, 1, 0, 6, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level7()
		{
			mapWidth = 13;
			mapHeight = 11;

			_anim =  CacheLibrary.getInstance().getAnim("Level7_mc");
		}
		
		public override function init():void
		{
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 95;
			_gameScreen.twoStarsTime = 90;
			_gameScreen.oneStarTime = 80;
			_gameScreen.fullStarTime = 150;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isGreen = true;
			_gameScreen.numKindle = 3;
			
			var v:Vector2D = _gameMap.cacheV2D.allocate(0, 0);
			levelS = new Array(new Level71(this), new Level_2D_5T_1C(), new Level_2D_5T_1C());
			levelS[0].createProperties();
			levelS[1].createProperties(levelS[0], levelS[0], _gameMap.cacheV2D.allocateV2D(v.init(168, 360)), _gameMap.cacheV2D.allocateV2D(v.init(408, 408)), Constants.NONE, Constants.BLUE);
			levelS[2].createProperties(levelS[0], levelS[0], _gameMap.cacheV2D.allocateV2D(v.init(693, 408)), _gameMap.cacheV2D.allocateV2D(v.init(936, 360)), Constants.GREEN, Constants.NONE);
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
			cauldron[cauldron.length] = Constants.BLUE;
			cauldron[cauldron.length] = Constants.GREEN;
			
			createKeyRecess(Constants.ORANGE);
			
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createDoors(Constants.NONE, levelS[0], _gameMap.cacheV2D.allocate(552, 216));
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