package physics
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import gamemenu.GameScreen;
	import gamemenu.GameShift;
	import geometry.*;
	import maths.*;
	import system.*;
	import levels.LevelBase;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class PhysicsObject extends Sprite implements IGameObjects,IAABB
	{
		protected var _screen:Screen;
		protected var _gameMap:GameMap;
		protected var _gameScreen:GameScreen;
		protected var _gameShift:GameShift;
		protected var _soundManager:SoundManager;
		protected var _pos:Vector2D;
		protected var _posCorrect:Vector2D;
		protected var _vel:Vector2D;
		protected var _halfSize:Vector2D;
		protected var _friction:Number = .4;
		protected var _onGround:Boolean = false;
		protected var _onGroundLast:Boolean = false;
		protected var _contact:Contact;
		protected var _shape:Shape;
		protected var _played:Boolean;
		
		public function PhysicsObject()
		{
			_screen = Screen.getInstance();
			_gameMap = GameMap.getInstance();
			_gameScreen = GameScreen.getInstance();
			_gameShift = GameShift.getInstance();
			_soundManager = SoundManager.getInstance();
			_vel = new Vector2D();
			_posCorrect = new Vector2D();
			_contact = new Contact();
		}
		
		public function free():void
		{
			if (_shape != null && this.contains(_shape))
			{
				this.removeChild(_shape);
				_gameMap.cacheShape.set(_shape);
			}
			if (_gameMap.contains(this))
			{
				_gameMap.removeChild(this);
			}
		}
		
		public function init(p:Vector2D):void
		{
			this.pos = p;
			_gameMap.addChild(this);
		}
		
		public function drawBox(cX:Number, cY:Number, wx:Number, wy:Number, color:uint = 0x2FFFF):void
		{
			_shape = _gameMap.cacheShape.get as Shape;
			_shape.graphics.lineStyle(1, 0x333333, .5);
			_shape.graphics.beginFill(color,.3);
			_shape.graphics.drawRect(cX,cY, wx * 2, wy * 2);
			_shape.graphics.endFill();
			this.addChild(_shape);
		}
		
		public function update(delta:Number):void
		{
			if (applyGravity)
			{
				_vel.addToY(Constants.GRAVITY);
			}
			if (collisionWorld)
			{
				Collision(delta);
			}
			_pos.mulAddTo(_vel.add(_posCorrect), delta);
			pos = _pos;
			_posCorrect.clear();
		}
		
		public function render(bitmapData:BitmapData):void
		{
			//...
		}
		
		protected function preCollisionCode( ):void
		{
			_onGroundLast = _onGround;
			_onGround = false;
		}
		
		protected function Collision( delta:Number ):void
		{
			var predictedPos:Vector2D = _pos.mulAdd( _vel, delta );
			
			var min:Vector2D = _pos.min( predictedPos );
			var max:Vector2D = _pos.max( predictedPos );

			min.subFrom(_halfSize);
			max.addTo(_halfSize);	
			
			if (!_onGround)
			{
				max.subFromX(Constants.EXPAND.x);
			}
			else
			{
				min.subFromX(5);
				max.addToX(5);
			}
			//max.subFromX(Constants.EXPAND.x);
			//min.addToX(Constants.EXPAND.x);
			
			//min.subFromX(5);
			//max.addToX(5);
			
			preCollisionCode();
			_gameMap.currLevel.DoActionToTilesWithinAabb( min, max, this.InnerCollide, delta );
		}
		
		protected function InnerCollide(tileAabb:AABB, tileType:int, delta:Number, i:int, j:int ):void
		{
			// is it collidable?
			if ( LevelBase.IsTileObstacle( tileType ) )
			{
				// standard collision responce
				var collided:Boolean = Collide.AabbVsAabb( this, tileAabb, _contact, i, j, _gameMap.currLevel );
				if ( collided )
				{
					CollisionResponse( _contact.normal, _contact.dist, delta );
				}
			}
		}
		
		protected function CollisionResponse( normal:Vector2D, dist:Number, delta:Number ):void
		{
			var separation:Number = Math.max( dist, 0 );
			var penetration:Number = Math.min( dist, 0 );

			var nv:Number = _vel.dot( normal ) + separation / delta;
			
			_posCorrect.subFrom( normal.mulValue( penetration/delta ) );
			
			if ( nv<0 )
			{
				_vel.subFrom( normal.mulValue( nv ) ); // <====================
				
				if ( normal.y < 0 )
				{
					_onGround = true;
					
					if ( applyFriction )
					{
						var tangent:Vector2D = normal.perp;
						var tv:Number = _vel.dot( tangent ) * _friction;
						_vel.subFrom( tangent.mulValue( tv ) );
					}
					
				}
			}
		}
		
		/*private function Collision(delta:Number):void
		{
			var positon:Vector2D = _pos.mulAdd(_vel, delta);
			var max:Vector2 = _pos.max(positon);
			var min:Vector2 = _pos.min(positon);
			
			max.addTo(_halfSize);
			min.subFrom(_halfSize);
			
			_map.currLevel.DoActionToTilesWithinAabb( min, max, InnerCollide, delta );
		}
		
		protected function InnerCollide(tileAabb:AABB, tileType:int, delta:Number, i:int, j:int ):void
		{
			//trace(tileAabb,i,j);
			// is it collidable?
			if ( LevelBase.IsTileObstacle( tileType ) )
			{
				// standard collision responce
				var collided:Boolean = Collide.AabbVsAabb( this, tileAabb, _contact, i, j, _map.currLevel );
				if ( collided )
				{
					CollisionResponse( _contact.normal, _contact.dist, delta );
				}
			}
		}
		
		protected function CollisionResponse( normal:Vector2, dist:Number, delta:Number ):void
		{
			var separation:Number = Math.max( dist, 0 );
			var penetration:Number = Math.min( dist, 0 );

			var nv:Number = _vel.dotProd( normal ) + separation/delta;

			_posCorrect.subFrom( normal.mulScalar( penetration/delta ) );
			
			if ( nv<0 )
			{
				_vel.subFrom( normal.mulScalar( nv ) ); // <====================
				trace(_vel);
				// is this some ground?
				if ( normal.y<0 )
				{
					_onGround = true;
					
					// friction
					if ( applyFriction )
					{
						var tangent:Vector2 = normal.perp;
						var tv:Number = _vel.dotProd( tangent ) * _friction;
						_vel.subFrom( tangent.mulScalar( tv ) );
					}
				
				}
			}
		}*/
		
	// ===========
	//  GET / SET
	// ===========
	
		public function get pos():Vector2D
		{
			return _pos;
		}
		
		public function set pos(p:Vector2D):void
		{
			_pos = p;
			this.x = _pos.x;
			this.y = _pos.y;
		}

		protected function get applyFriction( ):Boolean
		{
			return false;
		}
		
		protected function get applyGravity( ):Boolean
		{
			return false;
		}
		
		protected function get collisionWorld( ):Boolean
		{
			return false;
		}

		public function get center( ):Vector2D
		{
			return _pos;
		}
		
		public function get halfSize():Vector2D
		{
			return _halfSize;
		}
	}
	
}