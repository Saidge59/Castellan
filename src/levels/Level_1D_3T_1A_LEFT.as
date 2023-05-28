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
	public class Level_1D_3T_1A_LEFT extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		private var _posReturn:Vector2D;
		private var _colorOneDoor:int;
		private var _colorTorches:int;
		private var _colorKey:int;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 
				1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 1,
				1, 11, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0, 1,
				1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 3, 0, 7, 0, 0, 0, 0, 0, 0, 5, 0, 1,
				1, 1, 1, 1, 1, 3, 3, 3, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level_1D_3T_1A_LEFT(perentLevel:LevelBase, posReturn:Vector2D, colorOneDoor:int = Constants.NONE, colorTorches:int = Constants.ORANGE, colorKey:int = Constants.ORANGE)
		{
			_perentLevel = perentLevel;
			_posReturn = posReturn;
			_colorOneDoor = colorOneDoor;
			_colorTorches = colorTorches;
			_colorKey = colorKey;
			_anim =  CacheLibrary.getInstance().getAnim("Level_1D_3T_1A_mc");
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
			bmpBG = _anim.frames[1];
		}
		
		private function createProperties():void
		{
			createTorches(_colorTorches);
			createTorches(_colorTorches);
			createTorches(_colorTorches);
			createDoors(_colorOneDoor, _perentLevel, _posReturn);
			createKeyRecess(_colorKey);
			createArtillery(Constants.DIRECTION_RIGHT, 20 , 45);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}