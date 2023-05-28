package character 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import gamemenu.GameSave;
	import geometry.AABB;
	import graphics.Animation;
	import maths.Vector2D;
	import levels.*;
	import geometry.Collide;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Helmet extends Enemy
	{
		public static const SLEEPS:int = 0;
		public static const ATTAKS:int = 1;
		public static const RUNS:int = 2;
		public static const BEMUSED:int = 3;
		public static const STANDS:int = 4;
		public static const NONE:int = 5;
		
		public static const STEP_TIME:int = 12;
		public static const ATTAKS_TIME:int = 8;

		private var _touchDetector:AABB;
		private var _downWall:AABB;
		private var _centerWall:AABB;
		private var p_downWall:Vector2D;
		private var p_centerWall:Vector2D;
		private var p_touchDetector:Vector2D;
		private var _renderMin:Vector2D;
		private var _renderMax:Vector2D;
		private var _stepTime:int;
		
		public function Helmet() 
		{
			_touchDetector = new AABB();
			_downWall = new AABB();
			_centerWall = new AABB();
			
			p_touchDetector = new Vector2D(110,0);
			p_downWall = new Vector2D(20,40);
			p_centerWall = new Vector2D(20, 0);
		}
		
		public override function free():void
		{
			_gameMap.cacheHelmet.set(this);
			_prpCntr.pos = _pos;
			_prpCntr.direction = this.scaleX;
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_halfSize = _gameMap.cacheV2D.allocate(Constants.PLAYER_HALF_SIZE.x, Constants.PLAYER_HALF_SIZE.y);
			_renderMin = _gameMap.cacheV2D.allocate(-Constants.PLAYER_SIZE.x, -Constants.PLAYER_SIZE.y);
			_renderMax = _gameMap.cacheV2D.allocate(Constants.SCREEN_SIZE.x + Constants.PLAYER_SIZE.x + 10, Constants.SCREEN_SIZE.y + Constants.PLAYER_SIZE.y * 2);
			
			_currentTime = 0;
			_stepTime = Helmet.STEP_TIME;
			_helmetState = Helmet.RUNS;
			super.switchAnimHelmet();
			
			_touchDetector.init(p.add(p_touchDetector), _gameMap.cacheV2D.allocate(80, 10));
			_downWall.init(p.add(p_downWall), _gameMap.cacheV2D.allocate(5, 5));
			_centerWall.init(p.add(p_centerWall), _gameMap.cacheV2D.allocate(5, 5));
			
			if (_gameMap.isRenderShape)
			{
				// render shape
				drawBox( -_halfSize.x * 2, -_halfSize.y * 2, _halfSize.x * 2 , _halfSize.y * 2, 0x008080); 
			}
			if (_gameMap.isPhysicsObject)
			{
				drawBox( -_halfSize.x, -_halfSize.y, _halfSize.x, _halfSize.y, 0xFF0000);
				drawBox(p_touchDetector.x - _touchDetector.halfSize.x, p_touchDetector.y - _touchDetector.halfSize.y, _touchDetector.halfSize.x, _touchDetector.halfSize.y, 0xFA00FF);
				drawBox(p_downWall.x - _downWall.halfSize.x, p_downWall.y - _downWall.halfSize.y, _downWall.halfSize.x, _downWall.halfSize.y, 0x00FF00);
				drawBox(p_centerWall.x - _centerWall.halfSize.x, p_centerWall.y - _centerWall.halfSize.y, _downWall.halfSize.x, _downWall.halfSize.y, 0x00FF00);
			}
			
			_speedMoving = _speedWalk;
			_vel.x = _speedMoving;
			super.init(p);
		}
		
		public override function update(delta:Number):void
		{
			//if (_gameShift.isUsed) return;
			switchAnimHelmet();
			switchSoundHelmet();
			_touchDetector.center.x = _pos.addX(p_touchDetector.x * this.scaleX).x;
			_downWall.center.x = _pos.addX(p_downWall.x * this.scaleX).x;
			_centerWall.center.x = _pos.addX(p_centerWall.x * this.scaleX).x;
			_vel.x = _speedMoving * this.scaleX; 
			
			super.update(delta);
		}
		
		protected override function InnerCollide(tileAabb:AABB, tileType:int, delta:Number, i:int, j:int ):void
		{
			var collided:Boolean = false;
			
			if ( tileType == TileTypes.EMPTY || tileType == TileTypes.SPIKE)
			{
				collided = AABB.overlap(_downWall, tileAabb);
				if ( collided )
				{
					_vel.x *= -1;
					this.scaleX *= -1;
				}
			}
			if ( tileType == TileTypes.TILE )
			{
				collided = AABB.overlap(_centerWall, tileAabb);
				if ( collided )
				{
					_vel.x *= -1;
					this.scaleX *= -1;
				}
			}
			super.InnerCollide(tileAabb,tileType,delta,i,j);
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			if (!_gameMap.camera.onScreenParam(_pos, _renderMin, _renderMax)) return;
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos).addTo(_gameMap.pos);
			_helmetAnim.render(bitmapData, vector);
		}
		
		protected override function switchAnimHelmet():void
		{			
			if (_helmetState != Helmet.SLEEPS)
			{
				var touchDetector:Boolean = AABB.overlap(_gameMap.knight, _touchDetector)
				if (touchDetector) 
				{
					if (_gameMap.knight.colorFire == _colorHelmet && _gameMap.knight.scaleX != this.scaleX)
					{
						if (!_gameMap.knight.isUsed) return;
						_helmetState = Helmet.SLEEPS;
						_currentTime = Enemy.TIME_SLEEP;
						_soundManager.stopSound(this);
						if(GameSave.inRange(GameSave.TAMER))GameSave.setAward(GameSave.TAMER);
					}
					else if (_gameMap.knight.isUsed && _helmetState != Helmet.ATTAKS) 
					{
						_soundManager.stopSound(this);
						_helmetState = Helmet.ATTAKS;
						_stepTime = 0;
					}
					
				}
				else if(_helmetState == Helmet.ATTAKS)
				{
					_currentTime = Enemy.TIME_BEMUSED;
					_helmetState = Helmet.BEMUSED;
					_soundManager.stopSound(this);
				}
				else if (_helmetState != Helmet.BEMUSED && _helmetState != Helmet.RUNS)  
				{
					_helmetState = Helmet.RUNS;
					_stepTime = 0;
					_soundManager.stopSound(this);
				}
			}
			if(_currentTime > 0)
			{
				_currentTime--;
				
				if (_currentTime == 0)
				{
					_currentTime = Enemy.TIME_BEMUSED;
					if (_helmetState == Helmet.BEMUSED)
					{
						_currentTime = 0;
						_helmetState = Helmet.RUNS;
						_stepTime = 0;
						_soundManager.stopSound(this);
					}
					else 
					{
						_helmetState = Helmet.BEMUSED;
						_soundManager.stopSound(this);
					}
				}
				
			}
			
			if (_oldHelmetState != _helmetState || _oldScaleX != this.scaleX)
			{
				super.switchAnimHelmet();
				_oldHelmetState = _helmetState;
				_oldScaleX = this.scaleX;
			}
			
		}
		
		protected function switchSoundHelmet():void
		{
			if (_gameShift.isUsed) return;
			if (_helmetState == Helmet.RUNS)
			{
				if (_stepTime <= 0)
				{
					_stepTime = Helmet.STEP_TIME;
					_soundManager.playSound("HelmetRuns", this);
				}
				_stepTime--;
			}
			else if (_helmetState == Helmet.ATTAKS)
			{
				if (_stepTime <= 0)
				{
					_stepTime = Helmet.ATTAKS_TIME;
					_soundManager.playSound("HelmetRuns", this);
				}
				_stepTime--;
			}
			else if (_helmetState == Helmet.BEMUSED)
			{
				if (_currentTime == 72 || _currentTime == 48 || _currentTime == 24)
				{
					_soundManager.playSound("HelmetSurprise", this);
				}
			}
			else if (_helmetState == Helmet.SLEEPS)
			{
				if (!_soundManager.soundPlayed(this))
				{
					_soundManager.playSound("HelmetSleep", this, 999);
				}
			}
		}
		
		protected override function get speedMoving():Number
        {
           return _speedMoving;
        }

        public override function get damageOnTouch():Boolean
        {
            return true;
        }
		
		protected override function get applyGravity( ):Boolean
		{
			return true;
		}
		
		protected override function get collisionWorld( ):Boolean
		{
			return true;
		}
		
	}

}