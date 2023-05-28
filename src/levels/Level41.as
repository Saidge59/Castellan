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
	public class Level41 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 
				1, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 1, 
				1, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
				1, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 1, 
				1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 
				1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level41(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level4_mc");
			createProperties();
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			mapWidth = 15;
			mapHeight = 10;
			
			super.paramLevel();
			bmpBG = _anim.frames[1];
		}
		
		private function createProperties():void
		{
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createDoors(Constants.BLUE, _perentLevel, _gameMap.cacheV2D.allocate(168, 456));
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}