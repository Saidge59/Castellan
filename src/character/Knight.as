package character
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gamemenu.GameSave;
	import geometry.AABB;
	import graphics.Animation;
	import graphics.AnimLibrary;
	import graphics.CacheLibrary;
	import maths.*;
	import system.KeyCodes;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class Knight extends Character
	{
		public static const STEP_TIME:int = 12;
		public static const STOP_TIME:int = 6;
		public var torchAABB:AABB;
		public var colorFire:int;
		public var isDead:Boolean;
		public var isWon:Boolean;
		public var isDown:Boolean;
		public var isUsed:Boolean;
		
		private var _animTorch:Animation;
		private var _animKnight:Animation;
		private var _isMoving:Boolean;
		private var _posTorch:Vector2D;
		private var _stepTime:int = 0;
		
		public function Knight()
		{
			//_halfSize = new Vector2D(Constants.PLAYER_HALF_SIZE.x, Constants.PLAYER_HALF_SIZE.y);
			_halfSize = _gameMap.cacheV2D.allocate(Constants.PLAYER_HALF_SIZE.x, Constants.PLAYER_HALF_SIZE.y);
			
			//_posTorch = new Vector2D(28, -32);
			_posTorch = _gameMap.cacheV2D.allocate(28, -32);
			torchAABB = new AABB();
			
			_animKnight = new Animation();
			_animKnight.addAnim("Knight_die_mc", "die");
			_animKnight.addAnim("Knight_moveR", "moveR");
			_animKnight.addAnim("Knight_moveL", "moveL");
			_animKnight.addAnim("Knight_stayL", "stayL");
			_animKnight.addAnim("Knight_stayR", "stayR");
			_animKnight.addAnim("Knight_jumpL", "jumpL");
			_animKnight.addAnim("Knight_jumpR", "jumpR");
			_animKnight.addAnim("Knight_fallL", "fallL");
			_animKnight.addAnim("Knight_fallR", "fallR");
			
			_animTorch = new Animation();
			_animTorch.addAnim("KnTorchR_orange_mc", "orangeR");
			_animTorch.addAnim("KnTorchL_orange_mc", "orangeL");
			_animTorch.addAnim("KnTorchL_blue_mc", "blueL");
			_animTorch.addAnim("KnTorchR_blue_mc", "blueR");
			_animTorch.addAnim("KnTorchL_green_mc", "greenL");
			_animTorch.addAnim("KnTorchR_green_mc", "greenR");
			_animTorch.addAnim("KnTorchL_purple_mc", "purpleL");
			_animTorch.addAnim("KnTorchR_purple_mc", "purpleR");
			_animTorch.addAnim("KnTorchL_none_mc", "noneL");
			_animTorch.addAnim("KnTorchR_none_mc", "noneR");
		}
		
		public override function free():void
		{
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			torchAABB.init(_gameMap.cacheV2D.allocateV2D(p).addTo(_posTorch), _gameMap.cacheV2D.allocate(10, 10));
			super.init(p);
			_onGround = _onGroundLast = true;
			m_hurtTimer = 0;
			_stepTime = Knight.STOP_TIME;
			_isMoving = false;
			isDown = false;
			isDead = false;
			isWon = false;
			isUsed = false;
			
			if (_gameMap.isPhysicsObject)
			{
				drawBox(_posTorch.x - torchAABB.halfSize.x,_posTorch.y - torchAABB.halfSize.y, torchAABB.halfSize.x,torchAABB.halfSize.y,0xFF00FF);
				drawBox(-_halfSize.x, -_halfSize.y, _halfSize.x, _halfSize.y,0x00FF00);
			}
		}
		
		public override function hurt(p:Vector2D = null) : void
        {
			if (GameSave.inRange(GameSave.FIRST_BLOOD)) GameSave.setAward(GameSave.FIRST_BLOOD);
			_soundManager.playSound("HeroGrave");
            m_hurtTimer = 60;
			isDead = true;
			isUsed = false;
			_isMoving = false;
			_vel.mulValueTo(0);
            _vel.addTo(_gameMap.cacheV2D.allocate(0, -600));
			if(!_gameScreen.isPause)_gameScreen.stopTicker();
        }
		
		public function win():void
		{
			m_hurtTimer = 20;
			isWon = true;
			isUsed = false;
			_gameScreen.stopTicker();
			free();
		}
		
		public function pause():void
		{
			_screen.gamePause();
			_vel.mulValueTo(0);
			isUsed = false;
			_isMoving = false;
			_gameScreen.stopTicker();
		}
		
		public override function update(delta:Number):void
		{
			if (!_gameScreen.isDied && !isHurt && isDead && !_gameScreen.isPause)
			{
				_gameScreen.isDied = !isHurt && isDead;
				_screen.gameDied();
			}
			
			if (!_gameScreen.isWon && !isHurt && isWon)
			{
				_gameScreen.isWon = !isHurt && isWon;
				_screen.gameWon();
			}
			monitorKeystroke( delta );

			_vel.addToY(Constants.GRAVITY);
			_vel.x = Scalar.Clamp( _vel.x, -Constants.MAX_SPEED, Constants.MAX_SPEED );
			_vel.y = Scalar.Clamp( _vel.y, -Constants.MAX_SPEED_2, Constants.MAX_SPEED_2 );
			
			 torchAABB.center.x = _pos.addX(_posTorch.x * this.scaleX).x;
			 torchAABB.center.y = _pos.addY(_posTorch.y).y;
			
			super.update( delta );
			if ( _onGround && !_onGroundLast && _vel.y > 0 && !isDead)
			{
				//_soundManager.playSound("HelmetRuns");
			}
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			if (isWon) return;
			switchAnimKnight();
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos).addTo(_gameMap.pos);
			if (!isDead) 
			{
				_animTorch.render(bitmapData, _gameMap.cacheV2D.allocate(vector.x, vector.y - 10));
			}
				
			_animKnight.render(bitmapData, _gameMap.cacheV2D.allocateV2D(vector));
		}
		
		private function monitorKeystroke(delta:Number):void
		{
			if (_gameShift.isUsed) return;
			if (isDead || isWon || !isUsed || _gameScreen.isPause || _gameScreen.isMisson) return;
			_isMoving = false;
			
			if (_screen.keyboard.isKeyDownTransition(KeyCodes.UP) && _onGround)
			{
				_vel.subFromY(Constants.JUMP);
				
			}
			isDown = _screen.keyboard.isKeyDownTransition(KeyCodes.ENTER) && _onGround;

			if (_screen.keyboard.isKeyDown(KeyCodes.LEFT))
			{
				if (_onGround && _vel.x > 0) _vel.x = 0;
				_vel.subFromX(Constants.SPEED_MOVE);
				this.scaleX = -1;
				_isMoving = true;
			}
			else if(_screen.keyboard.isKeyDown(KeyCodes.RIGHT))
			{
				if (_onGround && _vel.x < 0) _vel.x = 0;
				_vel.addToX(Constants.SPEED_MOVE);
				this.scaleX = 1;
				_isMoving = true;
			}

			if (_isMoving && _onGround)
			{
				if (_stepTime <= 0)
				{
					_stepTime = Knight.STEP_TIME;
					_soundManager.playSound("HelmetRuns", this);
				}
				_stepTime--;
			}
			else
			{
				_stepTime = Knight.STOP_TIME;
			}			
			
			//if (_screen.keyboard.isKeyDownTransition(KeyCodes.SPACE))
			//{
				//if (colorFire == Constants.NONE) colorFire = Constants.ORANGE;
				//else colorFire++;
			//}
			
			if(_screen.keyboard.isKeyDownTransition(KeyCodes.P) || _screen.keyboard.isKeyDownTransition(KeyCodes.ESC))
			{
				pause();
			}
		}
		
		private function switchAnimKnight():void
		{
			if (isDead)
			{
				_animKnight.switchAnim("die");
				return;
			}
			if (_onGround)
			{
				if (!_isMoving)
				{
					if (this.scaleX == Constants.DIRECTION_LEFT)_animKnight.switchAnim("stayL");
					else _animKnight.switchAnim("stayR");
				}
				else
				{
					if (this.scaleX == Constants.DIRECTION_LEFT)_animKnight.switchAnim("moveL");
					else _animKnight.switchAnim("moveR");
				}
			}
			else
			{
				if (_vel.y < 0)
				{
					if (this.scaleX == Constants.DIRECTION_LEFT)_animKnight.switchAnim("jumpL");
					else _animKnight.switchAnim("jumpR");
				}
				else
				{
					if (this.scaleX == Constants.DIRECTION_LEFT)_animKnight.switchAnim("fallL");
					else _animKnight.switchAnim("fallR");
				}
			}
			
			switch(colorFire)
			{
				case Constants.ORANGE:
					if (this.scaleX == Constants.DIRECTION_LEFT)_animTorch.switchAnim("orangeL");
					else _animTorch.switchAnim("orangeR");
					break;
				case Constants.BLUE:
					if (this.scaleX == Constants.DIRECTION_LEFT)_animTorch.switchAnim("blueL");
					else _animTorch.switchAnim("blueR");
					break;
				case Constants.GREEN:
					if (this.scaleX == Constants.DIRECTION_LEFT)_animTorch.switchAnim("greenL");
					else _animTorch.switchAnim("greenR");
					break;
				case Constants.PURPLE:
					if (this.scaleX == Constants.DIRECTION_LEFT)_animTorch.switchAnim("purpleL");
					else _animTorch.switchAnim("purpleR");
					break;
				case Constants.NONE:
					if (this.scaleX == Constants.DIRECTION_LEFT)_animTorch.switchAnim("noneL");
					else _animTorch.switchAnim("noneR");
					break;
					
			}
		}
		protected override function get applyFriction( ):Boolean
		{
			return !_isMoving;
		}
		
		protected override function get applyGravity( ):Boolean
		{
			return false;
		}
		
		protected override function get collisionWorld( ):Boolean
		{
			return true;
		}
		
		public function get changePos():Boolean
		{
			return _isMoving || !_onGround;
		}
		
	}
	
}