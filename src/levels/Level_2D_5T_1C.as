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
	public class Level_2D_5T_1C extends LevelBase
	{		
		private var _perentLevel:LevelBase;
		private var _anim:AnimLibrary;
		
		private var _map:Vector.<int> = Vector.<int>
		(
			[	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 
				1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 
				1, 0, 4, 0, 4, 0, 0, 0, 4, 0, 4, 0, 0,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				1, 3, 0, 5, 0, 0, 6, 0, 0, 5, 0, 3, 0, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			]
		)
		
		public function Level_2D_5T_1C()
		{
			_anim =  CacheLibrary.getInstance().getAnim("Level_2D_5T_1C_mc");
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
		
		internal function createProperties(oneLevel:LevelBase, twoLevel:LevelBase, posOneDoor:Vector2D, posTwoDoor:Vector2D, colorOneDoor:int = Constants.NONE, colorTwoDoor:int = Constants.NONE, colorTorches:int = Constants.ORANGE, colorCauldron:int = Constants.ORANGE):void
		{
			cauldron[cauldron.length] = colorCauldron;
			
			createTorches(colorTorches);
			createTorches(colorTorches);
			createTorches(colorTorches);
			createTorches(colorTorches);
			createTorches(colorTorches);
			createDoors(colorOneDoor, oneLevel, posOneDoor);
			createDoors(colorTwoDoor, twoLevel, posTwoDoor);
		}
		
		public override function get map():Vector.<int>
		{
			return _map;
		}

	}
	
}