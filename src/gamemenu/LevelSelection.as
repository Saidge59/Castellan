package gamemenu 
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import graphics.Animation;
	import graphics.AnimClip;
	import levels.LevelBase;
	import levels.LevelManager;
	import maths.Vector2D;
	import system.KeyCodes;
	import system.SimpleCache;
	import system.SoundManager;
	/**
	 * ...
	 * @author falcon12
	 */
	public class LevelSelection 
	{
		private static const SPRITES:int = 3;
		private static const LAST_PAGE:int = 2;
		private static const FIRST_PAGE:int = 0;
		private static const LAST_LEVEL:int = 12;
		private static const FIRST_LEVEL:int = 0;
		
		private static var _instance:LevelSelection;
		private var _screen:Screen;
		private var _gameMap:GameMap;
		private var _soundManager:SoundManager;
		private var _gameGuide:GameGuide;
		private var _gameShift:GameShift;
		private var _animBG:Animation;
		private var _menuBtn:AnimClip;
		private var _awardBtn:AnimClip;
		private var _guideBtn:AnimClip;
		private var _arrowR:AnimClip;
		private var _arrowL:AnimClip;
		private var _posList:Array;
		private var _thumbList:Array;
		private var _thumbnail:SimpleCache;
		private var _state:int;
		private var _numLevel:int;
		private var _isUsed:Boolean;
		private var _usedBtn:Boolean;
		private var _pos:Vector2D;
		
		public function LevelSelection() 
		{
			if (_instance)
			{
				throw ("Error :: LevelSelection.getInstance()");
			}
			_instance = this;
			
			_screen = Screen.getInstance();
			_gameMap = GameMap.getInstance();
			_soundManager = SoundManager.getInstance();
			_gameGuide = GameGuide.getInstance();
			_gameShift = GameShift.getInstance();
			
			_pos = new Vector2D();
			_menuBtn = new AnimClip();
			_awardBtn = new AnimClip();
			_guideBtn = new AnimClip();
			_arrowR = new AnimClip();
			_arrowL = new AnimClip();
			_animBG = new Animation();
			_animBG.addAnim("LevelSelection_mc", "bg", true);
			_menuBtn.addAnim("Menu_btn", "menu", true);
			_awardBtn.addAnim("Award_btn", "award", true);
			_guideBtn.addAnim("Guide_btn", "award", true);
			_arrowR.addAnim("Arrow_award_btn", "right");
			_arrowL.addAnim("Arrow_award_btn", "left");
			
			_thumbnail = new SimpleCache(LevelThumbnail, 3);
			_posList = [new Vector2D(120,288),new Vector2D(312,240),new Vector2D(504,288)];
			_thumbList = [];
		}
		
		public function free():void
		{
			_usedBtn = _isUsed = false;
			
			removeButton(_menuBtn, clickMenu);
			removeButton(_awardBtn, clickAward);
			removeButton(_guideBtn, clickGuide);
			removeButton(_arrowR, clickArrowR);
			removeButton(_arrowL, clickArrowL);

			removeSprite();
		}
		
		public function init():void
		{
			_usedBtn = _isUsed = true;
			_arrowR.visible = true;
			_arrowL.visible = false;
			_numLevel = _state = 0;

			createSprite();
			_soundManager.playMusic("Menu", true, 999, .2);
			_soundManager.fadeIn(.2, 1);
			
			createButton(_menuBtn, clickMenu, _pos.init(72, 72));
			createButton(_awardBtn, clickAward, _pos.init(168, 72));
			createButton(_guideBtn, clickGuide, _pos.init(552, 72));
			createButton(_arrowR, clickArrowR, _pos.init(542, 390), 0);
			createButton(_arrowL, clickArrowL, _pos.init(82, 390), 2);
		}
		
		private function removeSprite():void
		{
			var i:int = _thumbList.length;
			var levelThumbnail:LevelThumbnail;
			
			while (--i>-1)
			{
				levelThumbnail = _thumbList[i];
				levelThumbnail.free();
			}
			_thumbList.length = 0;
			_pos.clear();
		}
		
		private function createSprite():void
		{
			var i:int = _posList.length;
			var level:LevelBase;
			var levelThumbnail:LevelThumbnail;
			
			while (--i>-1)
			{
				level = LevelManager.getLevel(getLevel(i));
				//trace(i, GameSave.getLevelStar(i));
				level.countStars = GameSave.getLevelStar(getLevel(i));
				level.isPlay = GameSave.getLevelPlaying(getLevel(i));
				levelThumbnail = _thumbnail.get as LevelThumbnail;
				levelThumbnail.pos = _posList[getPos(i)];
				levelThumbnail.init(getLevel(i), level.countStars);
				_thumbList[_thumbList.length] = levelThumbnail;
			}
		}
		
		private function createButton(anim:AnimClip, metod:Function, pos:Vector2D, frame:int = 0):void
		{
			if (anim != null)
			{
				anim.goto(frame);
				anim.buttonMode = true;
				anim.mouseChildren = false;
				anim.pos = pos;
				_screen.addChild(anim);
				
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
				_screen.removeChild(anim);
			}
		}
		
		private function callbackMenu():void
		{
			_soundManager.resume();
			_soundManager.fadeIn(.2, 1);
			_screen.gameMenu();
			free();
		}
		private function callbackAward():void
		{
			_soundManager.resume();
			_soundManager.fadeIn(.2, 1);
			_screen.gameAward();
			free();
		}
		
		private function callbackPlay():void
		{
			free();
			_gameMap.playGame(GameSave.levelPassed);
		}
		
		private function overAnim(e:MouseEvent):void
		{
			//_soundManager.playSound("skip1");
			_soundManager.playSound("Button");
			var anim:AnimClip = e.currentTarget as AnimClip;
			anim.goto(anim.index + 1);
		}
		
		private function outAnim(e:MouseEvent):void
		{
			var anim:AnimClip = e.currentTarget as AnimClip;
			anim.goto(anim.index - 1);
		}
		
		private function clickMenu(e:MouseEvent = null):void
		{
			if (!_usedBtn) return;
			//_soundManager.pause();
			_soundManager.fadeOut(0, .25, true);
			_isUsed = false;
			_screen.gameShift(callbackMenu);
			_screen.stageFocus();
		}
		
		private function clickAward(e:MouseEvent = null):void
		{
			if (!_usedBtn) return;
			//_soundManager.pause();
			_soundManager.fadeOut(0, .25, true);
			_isUsed = false;
			_screen.stageFocus();
			_screen.gameShift(callbackAward);
		}
		
		private function clickGuide(e:MouseEvent = null):void
		{
			if (!_usedBtn) return;
			GameGuide.showGuide = true;
			_gameGuide.openSceneTo = 1;
			_soundManager.playSound("skip1");
			usedBtn = false;
			_screen.gameGuide();
			_screen.stageFocus();
		}
		
		private function clickArrowR(e:MouseEvent):void
		{
			if(_usedBtn)pageManagement(1);
		}
		private function clickArrowL(e:MouseEvent):void
		{
			if(_usedBtn)pageManagement(-1);
		}
		
		private function pageManagement(i:int):void
		{
			_numLevel += i;
			if (_numLevel > LevelSelection.LAST_LEVEL || _numLevel < LevelSelection.FIRST_LEVEL)
			{
				_numLevel -= i;
				return;
			}
			removeSprite();
			if (_numLevel == LevelSelection.FIRST_LEVEL)_arrowL.visible = false;
			else _arrowL.visible = true;
			if (_numLevel == LevelSelection.LAST_LEVEL)_arrowR.visible = false;
			else _arrowR.visible = true;
			createSprite();
		}
		
		public function update(delta:Number):void
		{
			if (!_isUsed || !_usedBtn) return;
			if (_gameShift.isUsed) return;
			if(_screen.keyboard.isKeyDownTransition(KeyCodes.ENTER))
			{
				//_soundManager.stopMusic();
				if (GameSave.levelPassed >= LevelManager.TOTAL_LEVEL) return;
				_soundManager.fadeOut(0, .25);
				_soundManager.stopAllSound();
				_screen.gameShift(callbackPlay);
			}
			if(_screen.keyboard.isKeyDownTransition(KeyCodes.ESC))
			{
				clickMenu();
			}
			if(_screen.keyboard.isKeyDownTransition(KeyCodes.SPACE))
			{
				clickAward();
			}
			if(_screen.keyboard.isKeyDownTransition(KeyCodes.CTRL))
			{
				clickGuide();
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
		
		public function render(bitmapData:BitmapData):void
		{
			if (!_isUsed) return;
			_animBG.render(bitmapData, _pos.init(0, 0));
			
			var i:int = _thumbList.length;
			var levelThumbnail:LevelThumbnail;
			
			while (--i>-1)
			{
				levelThumbnail = _thumbList[i];
				levelThumbnail.render(bitmapData);
			}
		}
		
		private function getLevel(i:int):int
		{
			return _numLevel + i + 1;
		}

		private function getPos(i:int):int
		{
			var numb:int = i + _state;
			if (numb < 0) numb = LevelManager.TOTAL_LEVEL - 1;
			if (numb >= LevelManager.TOTAL_LEVEL) numb = 0;
			return numb;
		}
		
		public function set isUsed(value:Boolean):void
		{
			_isUsed = value;
		}
		
		public function set usedBtn(value:Boolean):void
		{
			_usedBtn = value;

			var i:int = _thumbList.length;
			var levelThumbnail:LevelThumbnail;
			
			while (--i>-1)
			{
				levelThumbnail = _thumbList[i];
				levelThumbnail.usedBtn = value;
			}
		}
		
		public static function getInstance():LevelSelection
		{
			return (_instance == null) ? new LevelSelection() : _instance;
		}
		
	}

}