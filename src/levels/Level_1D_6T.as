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
	public class Level_1D_6T extends LevelBase
	{		
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 
				1, 1, 1, 0, 0, 4, 0, 4, 0, 0, 1, 1, 0, 
				1, 0, 0, 4, 0, 0, 0, 0, 0, 4, 0, 0, 0,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				1, 0, 0, 4, 0, 0, 5, 0, 0, 4, 0, 0, 0,
				1, 3, 0, 0, 0, 1, 1, 1, 0, 0, 0, 3, 0, 
				1, 1, 1, 3, 0, 3, 0, 3, 0, 3, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level_1D_6T()
		{
			_anim =  CacheLibrary.getInstance().getAnim("Level_1D_6T_mc");
			//createProperties();
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
			bmpBG = _anim.frames[0];
		}
		
		internal function createProperties(perentLevel:LevelBase, posReturn:Vector2D, colorOneDoor:int = Constants.NONE, colorTorches:int = Constants.ORANGE):void
		{
			createTorches(colorTorches);
			createTorches(colorTorches);
			createTorches(colorTorches);
			createTorches(colorTorches);
			createTorches(colorTorches);
			createTorches(colorTorches);
			createDoors(colorOneDoor, perentLevel, posReturn);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}