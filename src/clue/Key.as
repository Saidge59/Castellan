package clue 
{
	import controller.PropertiesController;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import gamemenu.GameSave;
	import gamemenu.GameScreen;
	import graphics.Animation;
	import maths.Vector2D;
	import physics.PhysicsObject;
	import system.IGameObjects;
	import geometry.*;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Key extends PhysicsObject
	{
		private var _animGrate:Animation;
		private var _animKey:Animation;
		private var _colorKey:int;
		private var _isPicked:Boolean;
		private var _playOnce:Boolean;
		private var _prpCntr:PropertiesController;
		private var _renderMin:Vector2D;
		private var _renderMax:Vector2D;
		
		public function Key() 
		{
			_animGrate = new Animation();
			_animKey = new Animation();
			_halfSize = new Vector2D(10, 10);
			_renderMin = new Vector2D(-Constants.KEY_SIZE.x, -Constants.KEY_SIZE.y * 1.4);
			_renderMax = new Vector2D(Constants.SCREEN_SIZE.x + Constants.KEY_SIZE.x, Constants.SCREEN_SIZE.y + Constants.KEY_SIZE.y);
			
			_animGrate.addAnim("Anim_grate_mc", "grate");
			_animKey.addAnim("Recess_none_mc", "key_None");
			_animKey.addAnim("Recess_orange_mc", "key_Orange");
			_animKey.addAnim("Recess_blue_mc", "key_Blue");	
			_animKey.addAnim("Recess_green_mc", "key_Green");
			_animKey.addAnim("Recess_purple_mc", "key_Purple");
			
		}
		
		public override function free():void
		{
			_gameMap.cacheKey.set(this);
			_gameMap.keys.remove(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{			
			_pos = _gameMap.cacheV2D.allocateV2D(p);
			_gameMap.keys.add(this);
			super.init(p);
			_animGrate.p_playOnce = false;
			
			if (_gameMap.isRenderShape)
			{
				// render shape
				drawBox( -Constants.KEY_SIZE.x, -Constants.KEY_SIZE.y * 1.4, Constants.KEY_SIZE.x, Constants.KEY_SIZE.y, 0x008080);
			}
			if (_gameMap.isPhysicsObject)
			{	
				// key shape
				drawBox(-_halfSize.x,-_halfSize.y, _halfSize.x ,_halfSize.y,0x0000FF);
			}
		}
		
		public override function update(delta:Number):void
		{
			if (!_isPicked && _playOnce)
			{
				var contact:Boolean = AABB.overlap(_gameMap.knight, this);
				if (contact)
				{
					pikedKey = _prpCntr.isPicked = _isPicked = true;
					_animKey.switchAnim("key_None");
					_soundManager.playSound("KeyUp", this);
					if (_gameScreen.pikedKeyOrange && _gameScreen.pikedKeyBlue && _gameScreen.pikedKeyGreen && _gameScreen.pikedKeyPurple)
					{
						if(GameSave.inRange(GameSave.LORD_KEYS))GameSave.setAward(GameSave.LORD_KEYS);
					}
				}
			}
			
			//if (_gameScreen.pikedKeyOrange)
			//{
				//_playOnce = true;
			//}

		}
		
		public override function render(bitmapData:BitmapData):void
		{
			if (!_gameMap.camera.onScreenParam(_pos, _renderMin, _renderMax)) return;
			//if(!_isPicked)_animKey.nextFrame();
			
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos).addTo(_gameMap.pos);
			_animKey.render(bitmapData, vector, !_isPicked);
			
			if (!_playOnce && openKey)
			{
				if (!_soundManager.soundPlayed(this))
				{
					_soundManager.playSound("CageUp", this, 1);
				}
				_animGrate.playOnce();
				_prpCntr.playOnce = _playOnce = _animGrate.p_playOnce;
			}
			
			_animGrate.render(bitmapData, vector, false);
			
		}
		
		public function set pc(prpC:PropertiesController):void
		{
			_prpCntr = prpC;
		}
		
		public function set isPicked(value:Boolean):void
		{
			_isPicked = value;
			if (value)_animKey.switchAnim("key_None");
		}
		
		public function set playOnce(value:Boolean):void
		{
			_playOnce = value;
			if (value)_animGrate.goToLastFrame();
			else _animGrate.goToFrame(0);
		}
		
		public function get openKey():Boolean
		{
			var bool:Boolean;
			switch(_colorKey)
			{
				case Constants.ORANGE: bool = _gameScreen.openKeyOrange;break;
				case Constants.BLUE: bool = _gameScreen.openKeyBlue;break;	
				case Constants.GREEN: bool = _gameScreen.openKeyGreen;break;
				case Constants.PURPLE: bool = _gameScreen.openKeyPurple;break;	
			}
			return bool;
		}
		
		public function set pikedKey(value:Boolean):void
		{
			switch(_colorKey)
			{
				case Constants.ORANGE: _gameScreen.pikedKeyOrange = value;break;
				case Constants.BLUE: _gameScreen.pikedKeyBlue = value;break;
				case Constants.GREEN: _gameScreen.pikedKeyGreen = value;break;
				case Constants.PURPLE: _gameScreen.pikedKeyPurple = value;break;
			}
		}
		
		public function set colorKey(color:int):void
		{
			_colorKey = color;
			switch(color)
			{
				case Constants.ORANGE:_animKey.switchAnim("key_Orange");break;
				case Constants.BLUE:_animKey.switchAnim("key_Blue");break;	
				case Constants.GREEN:_animKey.switchAnim("key_Green");break;
				case Constants.PURPLE:_animKey.switchAnim("key_Purple");break;	
			}
		}
		
	}

}