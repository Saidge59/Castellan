package gamemenu 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import graphics.AnimClip;
	import maths.Vector2D;
	import system.KeyCodes;
	import system.SimpleCache;
	import system.SoundManager;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameAward extends Sprite
	{
		private static const COLUMN:int = 2;
		private static const SPRITES:int = 6;
		private static const LAST_PAGE:int = 2;
		private static const FIRST_PAGE:int = 0;
		
		private static var _instance:GameAward;
		private var _screen:Screen;
		private var _gameMap:GameMap;
		private var _levelSelection:LevelSelection;
		private var _spriteAward:SpriteAward;
		private var _gameShift:GameShift;
		private var _soundManager:SoundManager;
		private var _cacheSprite:SimpleCache;
		private var _animBG:AnimClip;
		private var _close:AnimClip;
		private var _arrowR:AnimClip;
		private var _arrowL:AnimClip;
		private var _isUsed:Boolean;
		private var _pos:Vector2D;
		private var _spriteList:Array;
		private var _logoList:Array;
		private var _index:int;
		
		public function GameAward() 
		{
			if (_instance)
			{
				throw ("Error :: LevelSelection.getInstance()");
			}
			_instance = this;
			
			_screen = Screen.getInstance();
			_gameMap = GameMap.getInstance();
			_levelSelection = LevelSelection.getInstance();
			_gameShift = GameShift.getInstance();
			_soundManager = SoundManager.getInstance();
			_animBG = new AnimClip();
			_close = new AnimClip();
			_arrowR = new AnimClip();
			_arrowL = new AnimClip();
			_animBG.addAnim("Award_bg_mc", "bg", true);
			_close.addAnim("Text_lose_mc", "close", true);
			_arrowR.addAnim("Arrow_award_btn", "right");
			_arrowL.addAnim("Arrow_award_btn", "left");
			_pos = new Vector2D();
			_spriteList = new Array();
			_logoList = new Array("Collector spikes", "Pillow for needles", "50 ignition", "75 ignition", "100 ignition", "20 open doors", "30 open doors", "50 open doors", "Immortal", "First blood", "Lord of the keys", "Tamer", "Sacrifice", "Cannon fodder", "King of levels");
			_cacheSprite = new SimpleCache(SpriteAward, 15);
		}
		
		public function free():void
		{
			_isUsed = false;
			_levelSelection.isUsed = true;
			
			removeSprite();
			removeButton(_close, clickClose);
			removeButton(_arrowR, clickArrowR);
			removeButton(_arrowL, clickArrowL);

			if (this.contains(_animBG))
			{
				this.removeChild(_animBG)
			}
			if (_screen.contains(this))
			{
				_screen.removeChild(this)
			}
		}
		
		public function init():void
		{
			_spriteList.length = 0;
			_isUsed = true;
			_index = 0;
			
			if (_animBG != null)
			{
				//_animBG.mouseChildren = false;
				_animBG.mouseEnabled = false;
				this.addChild(_animBG)
			}
			
			_soundManager.playMusic("sample", true, 999);
			createSprite();
			
			createButton(_close, clickClose, 8, _pos.init(312, 430));
			createButton(_arrowR, clickArrowR, 0, _pos.init(542, 240));
			createButton(_arrowL, clickArrowL, 2, _pos.init(82, 240));
			_arrowR.visible = true;
			_arrowL.visible = false;

			_screen.addChild(this);
		}
		
		private function removeSprite():void
		{
			var i:int = _spriteList.length;
			var _sprite:SpriteAward;
			while (--i > -1)
			{
				_sprite = _spriteList[i];
				_sprite.free();
				_cacheSprite.set(_sprite);
				_animBG.removeChild(_sprite);
			}
			_spriteList.length = 0;
			_pos.clear();
		}
		
		private function createSprite():void
		{
			var i:int = 0;
			var numSprite:int = _index * GameAward.SPRITES;
			var difference:int = _logoList.length - numSprite;
			var amountSprite:int = ( difference < GameAward.SPRITES ) ? difference : GameAward.SPRITES;
			
			while (++i <= amountSprite)
			{
				var usedIndex:int = numSprite + i - 1;
				
				var ax:int = Math.floor((i+1) % GameAward.COLUMN);
				var ay:int = Math.ceil(i / GameAward.COLUMN);
				
				var tx:int = getPosX(ax);
				var ty:int = getPosY(ay);
					
				_pos.init(tx, ty);
				_spriteAward = _cacheSprite.get as SpriteAward;
				_spriteAward.curentIndex = GameSave.getAward(usedIndex);
				_spriteAward.maxIndex = GameSave.getMaxIndex(usedIndex);
				//trace(GameSave.getAward(usedIndex),GameSave.getMaxIndex(usedIndex));
				_spriteAward.logoT = _logoList[usedIndex];
				_spriteAward.init(_pos, usedIndex);
				_spriteList[_spriteList.length] = _spriteAward;
				_animBG.addChild(_spriteAward);
			}
		}
		
		private function createButton(anim:AnimClip, metod:Function, frame:int,  pos:Vector2D):void
		{
			if (anim != null)
			{
				anim.x = pos.x;
				anim.y = pos.y;
				anim.buttonMode = true;
				anim.mouseChildren = false;
				anim.goto(frame);
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
		
		public function update(delta:Number):void
		{
			if (!_isUsed) return;
			if (_gameShift.isUsed) return;
			if (_screen.keyboard.isKeyDownTransition(KeyCodes.ESC))
			{
				clickClose();
			}
			if (_screen.keyboard.isKeyDownTransition(KeyCodes.RIGHT))
			{
				pageManagement(1);
			}
			if (_screen.keyboard.isKeyDownTransition(KeyCodes.LEFT))
			{
				pageManagement(-1);
			}
		}
		
		private function pageManagement(i:int):void
		{
			_index += i;
			if (_index > GameAward.LAST_PAGE || _index < GameAward.FIRST_PAGE)
			{
				_index -= i;
				return;
			}
			removeSprite();
			if (_index == GameAward.FIRST_PAGE)_arrowL.visible = false;
			else _arrowL.visible = true;
			if (_index == GameAward.LAST_PAGE)_arrowR.visible = false;
			else _arrowR.visible = true;
			createSprite();
		}
		private function callbackClose():void
		{
			//_soundManager.resume();
			_screen.levelSelection();
			free();
		}

		private function clickClose(e:MouseEvent = null):void
		{
			if (!_isUsed) return;
			_soundManager.stopMusic();
			_screen.gameShift(callbackClose);
			_screen.stageFocus();
		}
		private function clickArrowR(e:MouseEvent):void
		{
			pageManagement(1);
		}
		private function clickArrowL(e:MouseEvent):void
		{
			pageManagement(-1);
		}
		private function overAnim(e:MouseEvent):void
		{
			var anim:AnimClip = e.currentTarget as AnimClip;
				anim.goto(anim.index + 1);
		}
		private function outAnim(e:MouseEvent):void
		{
			var anim:AnimClip = e.currentTarget as AnimClip;
				anim.goto(anim.index - 1);
		}

		private function getPosX(tx:int):int
		{
			return (tx * 216) + 144;
		}
		
		private function getPosY(ty:int):int
		{
			return ((ty - 1) * 96) + 144;
		}
		
		public static function getInstance():GameAward
		{
			return (_instance == null) ? new GameAward() : _instance;
		}
		
	}

}