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
	public class Level61 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 4, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 1,
				1, 11, 0, 0, 1, 1, 1, 1, 1, 0, 0, 11, 1,
				1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
				1, 3, 0, 6, 0, 0, 0, 0, 0, 7, 0, 3, 1,
				1, 1, 1, 1, 1, 0, 5, 0, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level61(perentLevel:LevelBase)
		{
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("Level6_mc");
			//createProperties();
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			mapWidth = 13;
			mapHeight = 13;
			
			super.paramLevel();
			bmpBG = _anim.frames[1];
		}
		
		internal function createProperties():void
		{
			cauldron[cauldron.length] = Constants.ORANGE;
			
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createTorches(Constants.ORANGE);
			createDoors(Constants.PURPLE, _perentLevel, _gameMap.cacheV2D.allocate(1272, 360));
			createDoors(Constants.ORANGE);
			createKeyRecess(Constants.ORANGE);
			createArtillery(Constants.DIRECTION_RIGHT, 20 , 30);
			createArtillery(Constants.DIRECTION_LEFT, -20 , 30);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}