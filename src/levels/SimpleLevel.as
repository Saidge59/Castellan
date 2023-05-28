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
	public class SimpleLevel extends LevelBase
	{		
		private var _anim:AnimLibrary;
		private var _maxLighting:int = 4;
		private var _pos:Vector2D;
		//private var _levels:Array;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1, 1,	1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	1,
				1, 0, 0, 0, 0, 4, 0, 0, 4, 0, 0, 4, 0, 0, 4, 0, 0, 0, 0, 0,	1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	1,
				1, 3, 2, 6, 0, 0, 0, 1, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1,	1,
				1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	1,
				1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 3, 3, 0,	1,
				1, 1, 1, 1, 1, 1, 1, 0, 7, 10, 7, 0, 7, 0, 7, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1, 1,	1
			]
		)
		
		public function SimpleLevel()
		{
			mapWidth = 21;
			mapHeight = 10;

			_anim =  CacheLibrary.getInstance().getAnim("SimpleLevel_mc");
		}
		
		public override function init():void
		{
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 90;
			_gameScreen.twoStarsTime = 60;
			_gameScreen.oneStarTime = 30;
			_gameScreen.fullStarTime = 120;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isGreen = true;
			_gameScreen.isPurple = true;
			_gameScreen.numKindle = 4;
			
			levelS = new Array(new SimpleSubLevel1(this), new SimpleSubLevel2(this));
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
			
			createTorches(Constants.ORANGE);
			createTorches(Constants.BLUE);
			createTorches(Constants.GREEN);
			createTorches(Constants.PURPLE);
			createDoors(Constants.NONE, levelS[1], _gameMap.cacheV2D.allocate(168,408));
			createKeyRecess(Constants.ORANGE);
			createKeyRecess(Constants.GREEN);
			createKeyRecess(Constants.BLUE);
			createKeyRecess(Constants.PURPLE);
			
			createEnemy(Constants.GREEN, Constants.DIRECTION_RIGHT);
			createEnemy(Constants.BLUE, Constants.DIRECTION_LEFT);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}
		
		//public override function get levels():Array
		//{
			//return _levels;
		//}

		public override function get pos():Vector2D
		{
			return _pos;
		}
		
		public override function get maxLighting():int
		{
			return _maxLighting;
		}

	}
	
}