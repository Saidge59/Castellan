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
	public class SimpleSubLevel1 extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		private var _maxLighting:int = 2;
		private var _pos:Vector2D;
		
		//private var _levels:Array;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 1, 0, 0, 4, 0, 4, 0, 4, 0, 1, 1, 1,
				1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1,
				1, 0, 4, 0, 0, 0, 4, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 5, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
			]
		)
		
		public function SimpleSubLevel1(perentLevel:LevelBase)
		{
			mapWidth = 13;
			mapHeight = 30;
			
			_perentLevel = perentLevel;
			_anim =  CacheLibrary.getInstance().getAnim("SimpleLevel_mc");
			//createProperties();
		}
		
		public override function init():void
		{
			paramLevel();
		
			//createTorch();
			//_levels = new Array(new SimpleLevel());
		}
		
		public override function paramLevel():void
		{
			super.paramLevel();
			bmpBG = _anim.frames[1];
		}
		
		private function createProperties():void
		{
			createTorches(Constants.ORANGE);
			createTorches(Constants.BLUE);
			createTorches(Constants.GREEN);
			createTorches(Constants.PURPLE);
			createTorches(Constants.PURPLE);
			createDoors(Constants.ORANGE);
			createDoors(Constants.NONE, _perentLevel,_gameMap.cacheV2D.allocate( 888, 216));
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}
		
		//public override function get levels():Array
		//{
			//return _levels;
		//}
		
		//public override function get lamp():Array
		//{
			//return _lamp;
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