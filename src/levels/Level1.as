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
	public class Level1 extends LevelBase
	{
		private var _anim:AnimLibrary;
		private var _pos:Vector2D;
		//private var _levels:Array;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 2, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 5, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1
			]
		)
		
		public function Level1()
		{
			mapWidth = 19;
			mapHeight = 10;

			_anim =  CacheLibrary.getInstance().getAnim("Level1_mc");
		}
		
		public override function init():void
		{
			if (GameSave.countScene < 3)
			{
				GameSave.countScene = 3;
				_gameGuide.openSceneTo = 1;
			}
			GameGuide.showGuide = true;
			
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 75;
			_gameScreen.twoStarsTime = 60;
			_gameScreen.oneStarTime = 45;
			_gameScreen.fullStarTime = 90;
			
			_gameScreen.isOrange = true;
			_gameScreen.numKindle = 1;
			
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
			createDoors(Constants.ORANGE);
			createKeyRecess(Constants.ORANGE);
			//createArtillery(Constants.DIRECTION_RIGHT, 20 , 30);
			//createArtillery(Constants.DIRECTION_LEFT, -20 , 30);
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