package ordnance 
{
	import flash.display.BitmapData;
	import gamemenu.GameSave;
	import geometry.AABB;
	import graphics.Animation;
	import levels.TileTypes;
	import maths.Scalar;
	import maths.Vector2D;
	import physics.PhysicsObject;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Core extends PhysicsObject
	{
		public var speed:int = 20;
		
		private var _animation:Animation;
		private var _renderMin:Vector2D;
		private var _renderMax:Vector2D;
		
		public function Core() 
		{
			_animation = new Animation();
			_animation.addAnim("CoreR_mc", "coreR");
			_animation.addAnim("CoreL_mc", "coreL");
			_animation.addAnim("Core_boom_mc", "boom");
		}
		
		public override function free():void
		{
			_vel.x = 0;
			_gameMap.cacheCore.set(this);
			_gameMap.cores.remove(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_halfSize = _gameMap.cacheV2D.allocate(Constants.CORE_HALF_SIZE, Constants.CORE_HALF_SIZE);
			_renderMin = _gameMap.cacheV2D.allocate(-Constants.CORE_HALF_SIZE, -Constants.CORE_HALF_SIZE);
			_renderMax = _gameMap.cacheV2D.allocate(Constants.SCREEN_SIZE.x + Constants.CORE_HALF_SIZE, Constants.SCREEN_SIZE.y + Constants.CORE_HALF_SIZE);
			
			_animation.index = 0;
			_animation.p_playOnce = false;
			
			if (_gameMap.isPhysicsObject)
			{
				drawBox(-_halfSize.x,-_halfSize.y, _halfSize.x ,_halfSize.y,0xFF99FF);
			}
			
			_gameMap.cores.add(this);
			super.init(p);
		}
		
		public override function update(delta:Number):void
		{
			if (_gameShift.isUsed) return;
			if (_animation.getAnim != "boom")
			{
				_vel.addToX(speed);
				_vel.x = Scalar.Clamp( _vel.x, -Constants.SPEED_CORE, Constants.SPEED_CORE);
				
				if (!_gameMap.knight.isDead)
				{
					var collided:Boolean = AABB.overlap(this, _gameMap.knight);
					if (collided)
					{
						if(GameSave.inRange(GameSave.CANNON_FODDER))GameSave.setAward(GameSave.CANNON_FODDER);
						_gameMap.knight.hurt(_pos);
						_animation.switchAnim("boom");
						_vel.x = 0; 
						if (_gameMap.camera.onScreenParam(_pos, _renderMin, _renderMax))
						{
							_soundManager.playSound("Cannon", this, 1);
						}
					}
				}
			}

			super.update(delta);
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			if (!_gameMap.camera.onScreenParam(_pos, _renderMin, _renderMax)) return;
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos).addTo(_gameMap.pos);
			if (_animation.getAnim != "boom")
			{
				_animation.render(bitmapData, vector, true);
			}
			else
			{
				_animation.playOnce();
				_animation.render(bitmapData, vector, false);
				if (_animation.p_playOnce) free();
			}
		}
		
		protected override function InnerCollide(tileAabb:AABB, tileType:int, delta:Number, i:int, j:int ):void
		{
			var collided:Boolean = false;
			if ( tileType == TileTypes.TILE && _animation.getAnim != "boom")
			{
				collided = AABB.overlap(this, tileAabb);
				if ( collided )
				{
					if (_gameMap.camera.onScreenParam(_pos, _renderMin, _renderMax))
					{
						_soundManager.playSound("CannonFire", this, 1);
					}
					_animation.switchAnim("boom");
					_vel.x = 0;
				}
			}
			//super.InnerCollide(tileAabb,tileType,delta,i,j);
		}

		public function set direction(dir:int):void
		{
			if (dir == -1)_animation.switchAnim("coreL");
			else _animation.switchAnim("coreR");
		}
		
		protected override function get collisionWorld( ):Boolean
		{
			return true;
		}
		
	}

}