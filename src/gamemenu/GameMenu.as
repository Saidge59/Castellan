package gamemenu 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import graphics.Animation;
	import graphics.AnimClip;
	import maths.Vector2D;
	import system.KeyCodes;
	import system.SoundManager;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameMenu extends Sprite
	{
		private static var _instance:GameMenu;
		private var _gameMap:GameMap;
		private var _screen:Screen;
		private var _gameShift:GameShift;
		private var _soundManager:SoundManager;
		private var _animMenu:Animation;
		private var _animPlay:AnimClip;
		private var _animSetting:AnimClip;
		private var _animSpike1:Animation;
		private var _animSpike2:Animation;
		private var _animSpike3:Animation;	
		private var _animTorch1:Animation;
		private var _animTorch2:Animation;
		private var _animCauldron1:Animation;
		private var _animCauldron2:Animation;
		private var _animDoor:Animation;
		private var _animFlag:Animation;
		private var _pos:Vector2D;
		private var _isUsed:Boolean;
		private var _usedBtn:Boolean;
		
		public function GameMenu() 
		{
			if (_instance)
			{
				throw ("Error :: GameMap.getInstance()");
			}
			_instance = this;
			
			_gameMap = GameMap.getInstance();
			_screen = Screen.getInstance();
			_gameShift = GameShift.getInstance();
			_soundManager = SoundManager.getInstance();
			
			_animMenu = new Animation();
			_animSpike1 = new Animation();
			_animSpike2 = new Animation();
			_animSpike3 = new Animation();
			_animTorch1 = new Animation();
			_animTorch2 = new Animation();
			_animCauldron1 = new Animation();
			_animCauldron2 = new Animation();
			_animDoor = new Animation();
			_animFlag = new Animation();
			_animMenu.addAnim("Menu_mc","menu", true);
			_animSpike1.addAnim("Spike_mc", "spike1", true);
			_animSpike2.addAnim("Spike_mc", "spike2", true);
			_animSpike3.addAnim("Spike_mc", "spike3", true);
			_animTorch1.addAnim("Torch_menu_mc", "torch1", true);
			_animTorch2.addAnim("Torch_menu_mc", "torch2", true);
			_animCauldron1.addAnim("Cauldron_orange_mc", "cauldron1", true);
			_animCauldron2.addAnim("Cauldron_blue_mc", "cauldron2", true);
			_animDoor.addAnim("Doors_mc", "door", true);
			_animFlag.addAnim("Flag_orange_mc", "flag_orange", true);
			
			_animPlay = new AnimClip();
			_animSetting = new AnimClip();
			_animPlay.addAnim("Play_btn", "play", true);
			_animSetting.addAnim("Setting_btn", "setting", true);
		}
		
		public function free():void
		{
			_usedBtn = _isUsed = false;
			removeButton(_animPlay, clickPlay);
			removeButton(_animSetting, clickSetting);
			_screen.removeChild(this);
		}
		
		public function init():void
		{
			_soundManager.playMusic("Menu", true, 999, .2);
			_soundManager.fadeIn(.2, 1);
			
			_usedBtn = _isUsed = true;
			_pos = _gameMap.cacheV2D.allocate(0,0);

			createButton(_animPlay, clickPlay, _pos.init(Constants.SCREEN_HALF_SIZE.x, 288));
			createButton(_animSetting, clickSetting, _pos.init(Constants.SCREEN_HALF_SIZE.x, 338));
			_screen.addChild(this);
		}
		
		private function createButton(anim:AnimClip, metod:Function, pos:Vector2D, frame:int = 0):void
		{
			if (anim != null)
			{
				anim.goto(frame);
				anim.buttonMode = true;
				anim.mouseChildren = false;
				//anim.x = pos.x;
				//anim.y = pos.y;
				anim.pos = pos;
				this.addChild(anim);
				
				anim.addEventListener(MouseEvent.CLICK, metod, false, 0, true);
				anim.addEventListener(MouseEvent.ROLL_OVER, overAnim, false, 0, true);
				anim.addEventListener(MouseEvent.ROLL_OUT, outAnim, false, 0, true);
			}
		}
		
		private function removeButton(anim:AnimClip, metod:Function):void
		{
			if (anim != null)
			{
				anim.removeEventListener(MouseEvent.CLICK, metod);
				anim.removeEventListener(MouseEvent.ROLL_OVER, overAnim);
				anim.removeEventListener(MouseEvent.ROLL_OUT, outAnim);
				this.removeChild(anim);
			}
		}
		
		private function callbackPlay():void
		{
			_soundManager.resume();
			_soundManager.fadeIn(.2, 1);
			_screen.levelSelection();
			free();
		}
		
		private function clickPlay(e:MouseEvent):void
		{
			if (!_usedBtn) return;
			//_soundManager.pause();
			_soundManager.fadeOut(0, .25, true);
			_screen.gameShift(callbackPlay);
		}
		private function clickSetting(e:MouseEvent):void
		{
			if (!_usedBtn) return;
			_screen.gameSetting();
		}

		private function overAnim(e:MouseEvent):void
		{
			if (!_usedBtn) return;
			_soundManager.playSound("Button");
			var anim:AnimClip = e.currentTarget as AnimClip;
			anim.goto(1);
			//_soundManager.playLooping("skip1", anim, 5);
		}
		private function outAnim(e:MouseEvent):void
		{
			if (!_usedBtn) return;
			var anim:AnimClip = e.currentTarget as AnimClip;
			anim.goto(0);
			//_soundManager.stopLooping("skip1", anim);
		}
		
		public function update(delta:Number):void
		{
			if (!_isUsed) return;
			if (_gameShift.isUsed) return;
			if(_screen.keyboard.isKeyDownTransition(KeyCodes.ENTER))
			{
				if (_usedBtn)
				{
					_soundManager.pause();
					_screen.gameShift(callbackPlay);
				}
			}
			if(_screen.keyboard.isKeyDownTransition(KeyCodes.SPACE))
			{
				if (_usedBtn) 
				{
					_usedBtn = false;
					_screen.gameSetting();
				}
			}
			
		}
		
		public function render(bitmapData:BitmapData):void
		{
			if (!_isUsed) return;
			_animMenu.render(bitmapData, _pos.init(0,0));
			_animSpike1.render(bitmapData, _pos.init(264,168));
			_animSpike2.render(bitmapData, _pos.init(312,168));
			_animSpike3.render(bitmapData, _pos.init(360, 168));
			_animCauldron1.render(bitmapData, _pos.init(72,312));
			_animCauldron2.render(bitmapData, _pos.init(168,312));
			_animTorch1.render(bitmapData, _pos.init(120,120));
			_animTorch2.render(bitmapData, _pos.init(504, 120));
			_animFlag.render(bitmapData, _pos.init(504, 300));
			_animDoor.render(bitmapData, _pos.init(504, 360), false);
		}
		
		public function set usedBtn(value:Boolean):void
		{
			_usedBtn = value;
		}
		
		public static function getInstance():GameMenu
		{
			return (_instance == null) ? new GameMenu() : _instance;
		}
		
	}

}