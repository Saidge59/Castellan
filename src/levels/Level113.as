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
	public class Level113 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 0, 0, 4, 0, 4, 0, 4, 0, 4, 0, 0, 1,
				1, 0, 4, 0, 0, 0, 3, 0, 0, 0, 4, 0, 1,
				1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 5, 0, 0, 0, 5, 0, 0, 0, 1,
				1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1,
				1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
				1, 3, 0, 7, 0, 3, 3, 3, 0, 6, 0, 3, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level113(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level11_mc");
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			mapWidth = 13;
			mapHeight = 10;
			
			super.paramLevel();
			bmpBG = _anim.frames[3];
		}
		
		internal function createProperties():void
		{
			cauldron[cauldron.length] = Constants.ORANGE;
			
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			
			createDoors(Constants.GREEN, _perentLevel, _gameMap.cacheV2D.allocate(216, 312));
			createDoors(Constants.BLUE, _perentLevel, _gameMap.cacheV2D.allocate(408, 312));
			
			createKeyRecess(Constants.ORANGE);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}