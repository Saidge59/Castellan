package levels
{
	import controller.PropertiesController;
	import doors.DoorBase;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import graphics.*;
	import maths.Vector2D;
	import graphics.TileMapCache;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class Level153 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
				1, 1, 1, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 0, 6, 0, 0, 5, 0, 0, 6, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1,
			]
		)
		
		public function Level153(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level15_mc");
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			mapWidth = 19;
			mapHeight = 10;
			
			super.paramLevel();
			bmpBG = _anim.frames[2];
		}
		
		internal function createProperties():void
		{
			cauldron[cauldron.length] = Constants.ORANGE;
			cauldron[cauldron.length] = Constants.ORANGE;
			
			createTorches(Constants.BLUE, Constants.BLUE, true, false);
			createTorches(Constants.BLUE, Constants.BLUE, true, false);
			createTorches(Constants.BLUE, Constants.BLUE, true, false);
			createTorches(Constants.BLUE, Constants.BLUE, true, false);
			createTorches(Constants.BLUE, Constants.BLUE, true, false);
			createTorches(Constants.BLUE, Constants.BLUE, true, false);
			createTorches(Constants.BLUE, Constants.BLUE, true, false);
			createTorches(Constants.BLUE, Constants.BLUE, true, false);
			createTorches(Constants.BLUE, Constants.BLUE, true, false);
			
			createTorches(Constants.ORANGE, Constants.ORANGE, true, false);
			createTorches(Constants.ORANGE, Constants.ORANGE, true, false);
			createTorches(Constants.ORANGE, Constants.ORANGE, true, false);
			createTorches(Constants.ORANGE, Constants.ORANGE, true, false);
			createTorches(Constants.ORANGE, Constants.ORANGE, true, false);
			createTorches(Constants.ORANGE, Constants.ORANGE, true, false);
			createTorches(Constants.ORANGE, Constants.ORANGE, true, false);
			createTorches(Constants.ORANGE, Constants.ORANGE, true, false);
			createTorches(Constants.ORANGE, Constants.ORANGE, true, false);
			
			createDoors(Constants.NONE, _perentLevel, _gameMap.cacheV2D.allocate(312, 264));
			createDoors(Constants.ORANGE);
			
			createKeyRecess(Constants.ORANGE);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}