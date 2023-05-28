package levels
{
	import controller.PropertiesController;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import gamemenu.GameGuide;
	import gamemenu.GameScreen;
	import geometry.AABB;
	import graphics.TileMap;
	import maths.Vector2D;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class LevelBase
	{
		public var rect:Rectangle;
		public var bmpBG:BitmapData;
		public var mapWidth:int;
		public var mapHeight:int;
		
		public var countStars:int;
		public var lighting:int;
		public var isPlay:Boolean;
		public var directionPlayer:int;
		public var lamp:Array;
		public var door:Array;
		public var enemy:Array;
		public var keyRecess:Array;
		public var levelS:Array;
		public var cauldron:Array;
		public var artillery:Array;
		
		protected var _gameMap:GameMap;
		protected var _gameScreen:GameScreen;
		protected var _gameGuide:GameGuide;
		
		private var _tileCenter:Vector2D;
		private var _tileHalf:Vector2D;
		private var _aabb:AABB;
		
		public function LevelBase()
		{
			countStars = 4;
			_gameMap = GameMap.getInstance();
			_gameScreen = GameScreen.getInstance();
			_gameGuide = GameGuide.getInstance();
			_aabb = new AABB();
			
			_tileCenter = _gameMap.cacheV2D.allocate(Constants.TILE_HALF_SIZE, Constants.TILE_HALF_SIZE);
			_tileHalf = _gameMap.cacheV2D.allocate(Constants.TILE_HALF_SIZE, Constants.TILE_HALF_SIZE);
			
			lamp = [];
			door = [];
			enemy = [];
			keyRecess = [];
			cauldron = [];
			artillery = [];
		}
		
		public function init():void
		{
		
		}
		
		public function paramLevel():void
		{
			Constants.WORLD_SIZE = _gameMap.cacheV2D.allocate(mapWidth * Constants.TILE_SIZE, mapHeight * Constants.TILE_SIZE);
			Constants.WORLD_HALF_SIZE = Constants.WORLD_SIZE.mulValue(0.5);
			
			rect = new Rectangle(0, 0, mapWidth * Constants.TILE_SIZE, mapHeight * Constants.TILE_SIZE);
		}
		
		public function clearList():void
		{
			lamp.length = 0;
			door.length = 0;
			enemy.length = 0;
			keyRecess.length = 0;
			cauldron.length = 0;
			artillery.length = 0;
		}
		
		protected function createTorches(colorTorch:int, colorFire:int = Constants.NONE, included:Boolean = false, active:Boolean = true):void
		{
			var pc:PropertiesController = new PropertiesController();
			pc.colorTorch = colorTorch;
			pc.colorFire = colorFire;
			pc.isIncluded = included;
			lamp[lamp.length] = pc;
			if (active)
			{
				_gameScreen.torchArray[_gameScreen.torchArray.length] = pc;
			}
		}
		
		protected function createEnemy(colorHelmet:int, direction:int = -1, p:Vector2D = null):void
		{
			var pc:PropertiesController = new PropertiesController();
			pc.pos = p;
			pc.colorHelmet = colorHelmet;
			pc.direction = direction;
			enemy[enemy.length] = pc;
		}
		
		protected function createDoors(colorDoor:int, toClass:LevelBase = null, movePos:Vector2D = null):void
		{
			var pc:PropertiesController = new PropertiesController();
			pc.colorDoor = colorDoor;
			pc.toClass = toClass;
			pc.movePos = movePos;
			door[door.length] = pc;
		}
		
		protected function createKeyRecess(colorKey:int, playOnce:Boolean = false, isPicked:Boolean = false):void
		{
			var pc:PropertiesController = new PropertiesController();
			pc.colorKey = colorKey;
			pc.playOnce = playOnce;
			pc.isPicked = isPicked;
			keyRecess[keyRecess.length] = pc;
		}
		
		protected function createArtillery(direction:int, speedCore:int = 20, timeDelay:int = 60):void
		{
			var pc:PropertiesController = new PropertiesController();
			pc.direction = direction;
			pc.speedCore = speedCore;
			pc.timeDelay = timeDelay;
			artillery[artillery.length] = pc;
		}
		
		public static function toPixX(tx:int):Number
		{
			return tx * Constants.TILE_SIZE;
		}
		
		public static function toPixY(ty:int):Number
		{
			return ty * Constants.TILE_SIZE;
		}
		
		public static function toTileX(px:Number):int
		{
			return px / Constants.TILE_SIZE;
		}
		
		public static function toTileY(py:Number):int
		{
			return py / Constants.TILE_SIZE; // <=============== !!!!
		}
		
		public function GetTile(i:int, j:int):int
		{
			return GetTileSafe(map, i, j);
		}
		
		public function GetTileSafe(map:Vector.<int>, i:int, j:int):int
		{
			if (i >= 0 && i < mapWidth && j >= 0 && j < mapHeight)
			{
				return map[j * mapWidth + i];
			}
			else
			{
				return TileTypes.EMPTY;
			}
		}
		
		static public function IsTileObstacle(tile:int):Boolean
		{
			return tile == TileTypes.TILE;
		}
		
		public function FillInTileAabb(i:int, j:int, aabb:AABB):void
		{
			var center:Vector2D = _gameMap.cacheV2D.allocate(toPixX(i), toPixY(j));
			center.addTo(_tileCenter);
			
			aabb.init(center, _tileHalf);
		
			//trace(aabb.center,aabb.halfSize);
		}
		
		public function DoActionToTilesWithinAabb(min:Vector2D, max:Vector2D, action:Function, delta:Number):void
		{
			var minI:int = toTileX(min.x);
			var minJ:int = toTileY(min.y);
			
			// round up
			var maxI:int = toTileX(max.x + .5);
			var maxJ:int = toTileY(max.y + .5);
			
			for (var i:int = minI; i <= maxI; i++)
			{
				for (var j:int = minJ; j <= maxJ; j++)
				{
					// generate aabb for this tile
					// генерировать ААВВ для этой плитки
					FillInTileAabb(i, j, _aabb);
					action(_aabb, GetTile(i, j), delta, i, j);
						// call the delegate on the main collision map
						// вызвать делегат на главной карте столкновения
						//action( m_aabbTemp, GetTile( i, j ), dt, i, j );
				}
			}
		}
		
		public function get map():Vector.<int>
		{
			throw "Error LevelBase:: map";
		}
		
		//public function get levels():Array
		//{
		//throw "Error LevelBase:: levels";
		//}
		
		//public function get lamp():Array
		//{
		//throw "Error LevelBase:: lamp";
		//}
		
		public function get pos():Vector2D
		{
			throw "Error LevelBase:: pos";
		}
		
		public function get maxLighting():int
		{
			throw "Error LevelBase:: maxLighting";
		}
	
	}

}