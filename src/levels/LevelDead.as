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
	public class LevelDead extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var p_colorDoor:int;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 3, 0, 5, 0, 3, 0, 0, 0, 1,
				1, 0, 3, 0, 1, 0, 0, 0, 1, 0, 3, 0, 1,
				1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function LevelDead(perentLevel:LevelBase, colorDoor:int)
		{
			_perentLevel = perentLevel;
			p_colorDoor = colorDoor;
			_anim =  CacheLibrary.getInstance().getAnim("LevelDead_mc");
			createProperties();
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
		
		internal function createProperties():void
		{
			createDoors(p_colorDoor);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}