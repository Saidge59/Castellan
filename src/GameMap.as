package 
{
	import character.Helmet;
	import flash.display.Shape;
	import gamemenu.GameMenu;
	import gamemenu.GameScreen;
	import lighting.Cauldron;
	import ordnance.Artillery;
	import character.Knight;
	import doors.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import graphics.Camera;
	import clue.Key;
	import graphics.*;
	import lighting.Lighting;
	import lighting.Torch;
	import ordnance.Core;
	import physics.PhysicsObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import levels.*;
	import maths.*;
	import cusp.MetalSpike;
	import system.*;
	import controller.*;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameMap extends Sprite 
	{
		public var currNumLevel:int;
		public var isPhysicsObject:Boolean = false;
		public var isRenderShape:Boolean = false;
		public var isTileShape:Boolean = false;
		public var isUsed:Boolean;
		public var playerPos:Vector2D;
		
		public var tiles:ObjectController;
		public var lightings:ObjectController;
		public var door:ObjectController;
		public var spikes:ObjectController;
		public var keys:ObjectController;
		public var enemies:ObjectController;
		public var artillery:ObjectController;
		public var cores:ObjectController;
		
		public var cacheTorch:SimpleCache;
		public var cacheCore:SimpleCache;
		public var cacheShape:SimpleCache;
		public var cacheTileGraphics:SimpleCache;
		public var cacheDoor:SimpleCache;
		public var cacheArtillery:SimpleCache;
		public var cacheCauldron:SimpleCache;
		public var cacheHelmet:SimpleCache;
		public var cacheMetalSpike:SimpleCache;
		public var cacheKey:SimpleCache;
		public var cacheV2D:VectorCache;
		
		private static var _instance:GameMap;
		private var _screen:Screen;
		private var _gameScreen:GameScreen;
		private var _gameMenu:GameMenu;
		private var _soundManager:SoundManager;
		private var _stage:Stage;
		private var _camera:Camera;
		private var _bitmapDataBG:BitmapData;
		private var _bgRect:Rectangle;
		private var _bgPoint:Point;
		private var _currLevel:LevelBase;
		private var _perentLevel:LevelBase;
		private var _knight:Knight;
		
		private var _knightPos:Vector2D;
		private var _pos:Vector2D;
		private var _throughMap:Array;
		
		public function GameMap(stage:Stage)
		{
			if (_instance)
			{
				throw ("Error :: GameMap.getInstance()");
			}
			_instance = this;
			
			_stage = stage;
			_screen = Screen.getInstance();
			_gameScreen = GameScreen.getInstance();
			_gameMenu = GameMenu.getInstance();
			_soundManager = SoundManager.getInstance();
			
			tiles = new ObjectController();
			lightings = new ObjectController();
			door = new ObjectController();
			spikes = new ObjectController();
			keys = new ObjectController();
			enemies = new ObjectController();
			artillery = new ObjectController();
			cores = new ObjectController();
			
			cacheShape = new SimpleCache(Shape, 100);
			cacheTileGraphics = new SimpleCache(TileGraphics, 100);
			cacheTorch = new SimpleCache(Torch, 20);
			cacheCore = new SimpleCache(Core, 50);
			cacheDoor = new SimpleCache(Door, 10);
			cacheArtillery = new SimpleCache(Artillery, 10);
			cacheCauldron = new SimpleCache(Cauldron, 10);
			cacheHelmet = new SimpleCache(Helmet, 10);
			cacheMetalSpike = new SimpleCache(MetalSpike, 50);
			cacheKey = new SimpleCache(Key, 50);
			cacheV2D = new VectorCache(1000);
			playerPos = cacheV2D.allocate(0, 0);
			
			_knight = new Knight();
			_camera = new Camera();
			
			_knightPos = cacheV2D.allocate(0,0);
			_pos = cacheV2D.allocate(0,0);
			_bgRect = new Rectangle(0, 0, 0, 0);
			_bgPoint = new Point()
			//createBitmap();			
		}
		
		//private function createBitmap():void 
        //{
            //_bitmapData = new BitmapData(Constants.SCREEN_SIZE.x, Constants.SCREEN_SIZE.y, true , 0x00000000);
            //_bgRect = new Rectangle(0, 0, 0, 0);
            //_bitmap = new Bitmap(_bitmapData, "never", true );
			//addChildAt(_bitmap, 0);
			//_rectScreen = new Rectangle(0,0,Constants.SCREEN_SIZE.x,Constants.SCREEN_SIZE.y);
        //}

		
		public function CreateTileMap(tileMap:Vector.<int>, addToMap:Boolean = true):void
		{
			var index:int = 0;
			var indThroughDoor:int = 0;
			var indEnemy:int = 0;
			var indLamp:int = 0;
			var indDoor:int = 0;
			var indCauldron:int = 0;
			var indKey:int = 0;
			var indArtillery:int = 0;
			var pc:PropertiesController;
			
			for each(var tileCode:int in tileMap)
			{
				var i:int = index % _currLevel.mapWidth;
				var j:int = index / _currLevel.mapWidth;
				
				var tileX:int = LevelBase.toPixX(i);
				var tileY:int = LevelBase.toPixY(j);
				
				//var tilePos:Vector2D = new Vector2D(tileX, tileY);
				var tilePos:Vector2D = cacheV2D.allocate(tileX,tileY);
				
				switch(tileCode)
				{
					case TileTypes.TILE:
						if (isTileShape)
						{
							var tile:TileGraphics = cacheTileGraphics.get as TileGraphics;
							tilePos.addValueTo(Constants.TILE_HALF_SIZE);
							tile.init(tilePos);
						}
						break;
					case TileTypes.PLAYER:
						if (!playerPos.isZero()) break;
						tilePos.addTo(Constants.PLAYER_HALF_SIZE);
						playerPos = tilePos;
						//_knight.init(tilePos);
						break;
					case TileTypes.HELMET:
						var helmet:Helmet = cacheHelmet.get as Helmet;
							pc = _currLevel.enemy[indEnemy];
							if (pc.pos != null ) tilePos = pc.pos;
							else tilePos.addValueTo(Constants.TILE_HALF_SIZE);
							helmet.colorHelmet = pc.colorHelmet;
							helmet.direction = pc.direction;
							helmet.pc = pc;
							helmet.init(tilePos);
							indEnemy++;
						break;
					case TileTypes.SPIKE:
						var spike:MetalSpike = cacheMetalSpike.get as MetalSpike;
							tilePos.addValueTo(Constants.TILE_HALF_SIZE);
							spike.frame = ((i % 2) == 0) ? 0 : 15;
							spike.init(tilePos);
						break;
					case TileTypes.CAULDRON:
						var cauldron:Cauldron = cacheCauldron.get as Cauldron;
							tilePos.addValueTo(Constants.TILE_HALF_SIZE);
							cauldron.colorFire = _currLevel.cauldron[indCauldron];
							cauldron.init(tilePos);
							indCauldron++;
						break;
					case TileTypes.TORCH:
						var torch:Torch = cacheTorch.get as Torch;
							tilePos.addValueTo(Constants.TILE_HALF_SIZE);
							pc = _currLevel.lamp[indLamp];
							torch.isIncluded = pc.isIncluded;
							torch.colorTorch = pc.colorTorch;
							torch.colorFire = pc.colorFire;
							torch.pc = pc;
							torch.init(tilePos);
							indLamp++;
						break;
					case TileTypes.DOOR:
						var doorT:Door = new Door();
							tilePos.addValueTo(Constants.TILE_HALF_SIZE);
							pc = _currLevel.door[indDoor];  
							doorT.colorDoor = pc.colorDoor;
							doorT.toClass = pc.toClass;
							doorT.movePos = pc.movePos;
							doorT.init(tilePos);
							indDoor++;
						break;
					case TileTypes.ARTILLERY:
						var arty:Artillery = cacheArtillery.get as Artillery;
							tilePos.addValueTo(Constants.TILE_HALF_SIZE);
							pc = _currLevel.artillery[indArtillery];
							arty.direction = pc.direction;
							arty.speedCore = pc.speedCore;
							arty.timeDelay = pc.timeDelay;
							arty.indexMap = index;
							arty.init(tilePos);
							indArtillery++;
						break;
					
					case TileTypes.KEY:
						var key:Key = cacheKey.get as Key;
							tilePos.addValueTo(Constants.TILE_HALF_SIZE);
							pc = _currLevel.keyRecess[indKey]; 
							key.colorKey = pc.colorKey;
							key.playOnce = pc.playOnce;
							key.isPicked = pc.isPicked;
							key.pc = pc;
							key.init(tilePos);
							indKey++;
						break;
				}
				index++;
			}
			//tilePos.addTo(Constants.PLAYER_HALF_SIZE);
			_knight.init(playerPos);
			SoundManager.listener = _knight;
			
			_camera.init(this, _knight);
			_bitmapDataBG = _currLevel.bmpBG;
			_bgRect.width = Constants.WORLD_SIZE.x;
			_bgRect.height = Constants.WORLD_SIZE.y;
			update(.03);
			
		}
		
		public function clear():void
		{
			SoundManager.listener = null;
			_knight.free();
			tiles.clear();
			keys.clear();
			spikes.clear();
			lightings.clear();
			door.clear();
			enemies.clear();
			artillery.clear();
			cores.clear();
			isUsed = false;
			playerPos.clear()
			//trace(artillery.objects);

			//trace(this.numChildren);
			//trace(this.numChildren, this.getChildAt(0));
		}
		
		public function update( delta:Number ):void
		{
			if (!isUsed) return;

			//_screen.keyboard.update();
			
			_knight.update(delta);
			_camera.update(delta);
			keys.update(delta);
			spikes.update(delta);
			lightings.update(delta);
			door.update(delta);
			enemies.update(delta);
			cores.update(delta);
			artillery.update(delta);
			
			_bgRect.x = -this.x;
			_bgRect.y = -this.y;
			
			cacheV2D.clear();
		}
		
		public function render(bitmapData:BitmapData):void
		{
			if (!isUsed) return;
			bitmapData.copyPixels(_bitmapDataBG, _bgRect, _bgPoint, null, null, true);
			keys.render(bitmapData);
			door.render(bitmapData);
			lightings.render(bitmapData);
			spikes.render(bitmapData);
			enemies.render(bitmapData);
			artillery.render(bitmapData);
			_knight.render(bitmapData);
			cores.render(bitmapData);
			_gameScreen.render(bitmapData);
		}
		
		public function playGame(level:int):void
		{
			isUsed = true;
			currNumLevel = level;
			_perentLevel = _currLevel = LevelManager.getLevel(level);
			_currLevel.init();
			_gameScreen.init();
			_knight.colorFire = _currLevel.lighting;
			_knight.direction = _currLevel.directionPlayer;
			CreateTileMap(_currLevel.map);
			_screen.keyboard.resetAllPressedKey();
			_soundManager.playMusic("Gameplay", true, 999, .2);
			_soundManager.fadeIn(.2, 1);
		}
		
		public function restartLevel():void
		{
			clear();
			playGame(currNumLevel);
		}
		public function nextLevel():void
		{
			clear();
			playGame(currNumLevel+1);
		}

	// ===========
	//  GET / SET
	// ===========
	
		public static function getInstance(stage:Stage = null):GameMap
		{
			return (_instance == null) ? new GameMap(stage) : _instance;
		}

		public function get pos():Vector2D
		{
			return _pos.init(this.x,this.y);
		}
		
		public function get perentLevel():LevelBase
		{
			return _perentLevel;
		}
		
		public function set perentLevel(value:LevelBase):void
		{
			_perentLevel = value;
		}
		
		public function get currLevel():LevelBase
		{
			return _currLevel;
		}
		
		public function set currLevel(value:LevelBase):void
		{
			_currLevel = value;
		}
		
		public function get knight():Knight
		{
			return _knight;
		}
		
		public function get camera():Camera
		{
			return _camera;
		}
		
	}
	
}