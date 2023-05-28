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
	public class Level22 extends LevelBase
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
				1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 5, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 5, 0, 0, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level22(perentLevel:LevelBase)
		{
			mapWidth = 13;
			mapHeight = 10;
			
			_perentLevel = perentLevel;
			cauldron = [Constants.ORANGE];
			_anim =  CacheLibrary.getInstance().getAnim("SimpleLevel_mc");
			//createProperties();
		}
		
		public override function init():void
		{
			paramLevel();
		}
		
		public override function paramLevel():void
		{
			super.paramLevel();
			bmpBG = _anim.frames[2];
		}
		
		private function createProperties():void
		{
			//lighting = Constants.ORANGE;
			var pc:PropertiesController = new PropertiesController();
				//pc.pos = new Vector2D( 216, 1032);
				//pc.colorTorch = Constants.ORANGE;
			//lamp[lamp.length] = pc;
				//pc = new PropertiesController();
				//pc.pos = new Vector2D( 312, 1032);
				//pc.colorTorch = Constants.GREEN;
			//lamp[lamp.length] = pc;
				//pc = new PropertiesController();
				//pc.pos = new Vector2D( 408, 1032);
				//pc.colorTorch = Constants.BLUE;
			//lamp[lamp.length] = pc;
				//pc = new PropertiesController();
				//pc.pos = new Vector2D( 120, 1272);
				//pc.colorTorch = Constants.PURPLE;
			//lamp[lamp.length] = pc;
				//pc = new PropertiesController();
				//pc.pos = new Vector2D( 312, 1272);
				//pc.colorTorch = Constants.BLUE;
			//lamp[lamp.length] = pc;
			
			//pc = new PropertiesController();
				//pc.pos = new Vector2D( 408, 120);
				//pc.colorTorch = Constants.BLUE;
			//lamp[lamp.length] = pc;
				//pc = new PropertiesController();
				//pc.pos = new Vector2D( 552, 120);
				//pc.colorTorch = Constants.GREEN;
			//lamp[lamp.length] = pc;
				//pc = new PropertiesController();
				//pc.pos = new Vector2D( 696, 120);
				//pc.colorTorch = Constants.PURPLE;
			//lamp[lamp.length] = pc;
			
				pc = new PropertiesController();
				pc.pos = _gameMap.cacheV2D.allocate( 504, 216);
				pc.colorDoor = Constants.ORANGE;
				//pc.toClass = new SimpleSubLevel1();
				//pc.movePos = _gameMap.cacheV2D.allocate( 936, 264);
			door[door.length] = pc;
			
				pc = new PropertiesController();
				pc.pos = _gameMap.cacheV2D.allocate( 168, 408);
				pc.colorDoor = Constants.NONE;
				pc.toClass = _perentLevel;
				pc.movePos = _gameMap.cacheV2D.allocate( 888, 216);
			door[door.length] = pc;
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