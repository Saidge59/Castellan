package ordnance 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import graphics.Animation;
	import maths.Vector2D;
	import physics.PhysicsObject;
	import system.IGameObjects;
	import levels.TileTypes;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Artillery extends PhysicsObject
	{
		public var timeDelay:int = 60;
		public var timeCurrentDelay:int = 0;
		public var speedCore:int;
		public var indexMap:int;
		
		private var _animation:Animation;
		private var _renderMin:Vector2D;
		private var _renderMax:Vector2D;
		private var _core:Core;
		
		public function Artillery() 
		{
			_animation = new Animation();
			_animation.addAnim("Cannon_mc", "cannon");
		}
		
		public override function free():void
		{
			_gameMap.currLevel.map[indexMap] = TileTypes.ARTILLERY;
			_gameMap.cacheArtillery.set(this);
			_gameMap.artillery.remove(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_halfSize = _gameMap.cacheV2D.allocate(Constants.TILE_HALF_SIZE, Constants.TILE_HALF_SIZE);
			_renderMin = _gameMap.cacheV2D.allocate(-Constants.TILE_HALF_SIZE, -Constants.TILE_HALF_SIZE);
			_renderMax = _gameMap.cacheV2D.allocate(Constants.SCREEN_SIZE.x + Constants.TILE_HALF_SIZE, Constants.SCREEN_SIZE.y + Constants.TILE_HALF_SIZE);
			
			if (_gameMap.isPhysicsObject)
			{
				drawBox(-_halfSize.x,-_halfSize.y, _halfSize.x ,_halfSize.y,0x0099FF);
			}
			
			timeCurrentDelay = 0;
			_gameMap.currLevel.map[indexMap] = TileTypes.TILE;
			_gameMap.artillery.add(this);
			super.init(p);
		}
		
		public override function update(delta:Number):void
		{
			if (_gameShift.isUsed) return;
			if (timeCurrentDelay <= 0)
			{
				_core = _gameMap.cacheCore.get as Core;
				_core.speed = speedCore;
				_core.direction = this.scaleX;
				_core.init(_gameMap.cacheV2D.allocate(_pos.x + (40 * this.scaleX), _pos.y - 5));
				timeCurrentDelay = timeDelay;
				_soundManager.playSound("Cannon", this);
				
			}
			else timeCurrentDelay--;
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			if (!_gameMap.camera.onScreenParam(_pos, _renderMin, _renderMax)) return;
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos).addTo(_gameMap.pos);
			_animation.render(bitmapData, vector, false);
		}
		
		public function set direction(direction:int):void
		{
			this.scaleX = direction;
			if (direction == -1)_animation.goToFrame(1);
			else _animation.goToFrame(0);
		}
		
	}

}