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
	public class Level10 extends LevelBase
	{
		private var _anim:AnimLibrary;
		private var _pos:Vector2D;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 7, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 6, 0, 2, 6, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 7, 0, 0, 5, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 6, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 7, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 5, 0, 0, 6, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 7, 0, 0, 5, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 6, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
			]
		)
		
		public function Level10()
		{
			mapWidth = 23;
			mapHeight = 17;

			_anim =  CacheLibrary.getInstance().getAnim("Level10_mc");
		}
		
		public override function init():void
		{
			clearList();
			paramLevel();
			
			_gameScreen.threeStarsTime = 60;
			_gameScreen.twoStarsTime = 45;
			_gameScreen.oneStarTime = 30;
			_gameScreen.fullStarTime = 120;
			
			_gameScreen.isOrange = true;
			_gameScreen.isBlue = true;
			_gameScreen.isGreen = true;
			_gameScreen.isPurple = true;
			_gameScreen.numKindle = 4;
			
			createProperties();
		}
		
		public override function paramLevel():void
		{
			super.paramLevel();
			bmpBG = _anim.frames[0];
		}
		
		private function createProperties():void
		{
			lighting = Constants.PURPLE;
			directionPlayer = Constants.DIRECTION_LEFT;
			
			cauldron[cauldron.length] = Constants.ORANGE;
			cauldron[cauldron.length] = Constants.PURPLE;
			cauldron[cauldron.length] = Constants.GREEN;
			cauldron[cauldron.length] = Constants.BLUE;
			cauldron[cauldron.length] = Constants.ORANGE;
			
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			createTorches(Constants.GREEN);
			
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			createTorches(Constants.BLUE);
			
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			
			createDoors(Constants.PURPLE, this, _gameMap.cacheV2D.allocate(840, 360));
			createDoors(Constants.GREEN, this, _gameMap.cacheV2D.allocate(840, 552));
			createDoors(Constants.PURPLE, this, _gameMap.cacheV2D.allocate(264, 168));
			createDoors(Constants.BLUE, this, _gameMap.cacheV2D.allocate(840, 744));
			createDoors(Constants.GREEN, this, _gameMap.cacheV2D.allocate(264, 360));
			createDoors(Constants.ORANGE);
			createDoors(Constants.BLUE, this, _gameMap.cacheV2D.allocate(264, 552));
			
			createKeyRecess(Constants.PURPLE);
			createKeyRecess(Constants.GREEN);
			createKeyRecess(Constants.BLUE);
			createKeyRecess(Constants.ORANGE);
			
			createEnemy(Constants.ORANGE, Constants.DIRECTION_LEFT);
			createEnemy(Constants.PURPLE, Constants.DIRECTION_RIGHT);
			createEnemy(Constants.GREEN, Constants.DIRECTION_LEFT);
			createEnemy(Constants.BLUE, Constants.DIRECTION_RIGHT);
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