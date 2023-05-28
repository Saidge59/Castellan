package gamemenu 
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import graphics.Animation;
	import graphics.AnimClip;
	import levels.LevelManager;
	import maths.Vector2D;
	import system.KeyCodes;
	import system.SoundManager;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameWindows 
	{
		protected var _gameScreen:GameScreen;
		protected var _screen:Screen;
		protected var _gameMap:GameMap;
		protected var _gameGuide:GameGuide;
		protected var _soundManager:SoundManager;
		protected var _gameShift:GameShift;
		protected var _pos:Vector2D;
		
		protected var _animWindow:Animation;
		protected var _animStaticStars:Animation;
		protected var _torchAnim:AnimClip;
		protected var _animRestart:AnimClip;
		protected var _animMenu:AnimClip;
		protected var _animNext:AnimClip;
		protected var _animContinue:AnimClip;
		protected var _textTimeFor1Star:TextField;
		protected var _textTimeFor2Star:TextField;
		protected var _textTimeFor3Star:TextField;
		
		protected var _openParam:Boolean;
		protected var _isUsed:Boolean;
		protected var _isWindow:Boolean;
		protected var _embeddedFont:Font;
		protected var _textFormat:TextFormat;
		protected var _textPlayerTime:TextField;
		protected var _glow:GlowFilter;
		
		public function GameWindows() 
		{
			_gameScreen = GameScreen.getInstance();
			_gameMap = GameMap.getInstance();
			_screen = Screen.getInstance();
			_gameGuide = GameGuide.getInstance();
			_soundManager = SoundManager.getInstance();
			_gameShift = GameShift.getInstance();
		
			_glow = new GlowFilter(0x302C29, 1, 2, 2, 800, 1);
		}

		public function free():void
		{
			_screen.stageFocus();
			removeAnimLink(_animContinue, onClickContinue);
			removeAnimLink(_animRestart, onClickRestart);
			removeAnimLink(_animMenu, onClickMenu);
			removeAnimLink(_animNext, onClickNext);
			
			removeAnimLink(_textPlayerTime);
			removeAnimLink(_textTimeFor1Star);
			removeAnimLink(_textTimeFor2Star);
			removeAnimLink(_textTimeFor3Star);
		}

		public function init():void
		{
			_pos = _gameMap.cacheV2D.allocate(Constants.SCREEN_HALF_SIZE.x, Constants.SCREEN_HALF_SIZE.y);
			_animWindow.index = 0;
			_animWindow.p_playOnce = false;
			_animWindow.p_reversOnce = false;
			_screen.visibleBG = _isUsed = _isWindow = _gameScreen.openWindow = true;
			_openParam = false;
			
			if (_textPlayerTime != null)
			{
				//_textFormat.font = "Eras Bold ITC";
				_textFormat.font = _embeddedFont.fontName;
				_textFormat.size = 40;
				_textFormat.color = 0xE2E1E9;
				
				_textPlayerTime.defaultTextFormat = _textFormat;
				_textPlayerTime.autoSize = "center";
				_textPlayerTime.embedFonts = true;
				_textPlayerTime.mouseEnabled = false;
				_textPlayerTime.filters = [_glow];
				_gameScreen.cuttingTime(_gameScreen.countTime, _textPlayerTime);
			}
			//====================================================================
			if (_textTimeFor3Star != null)
			{
				allTextTime(_textTimeFor1Star);
				_textTimeFor1Star.y = Constants.SCREEN_HALF_SIZE.y - 35;
				_gameScreen.cuttingTime(_gameScreen.threeStarsTime, _textTimeFor1Star);
			}
			if (_textTimeFor2Star != null)
			{
				allTextTime(_textTimeFor2Star);
				_textTimeFor2Star.y = Constants.SCREEN_HALF_SIZE.y - 10;
				_gameScreen.cuttingTime(_gameScreen.twoStarsTime, _textTimeFor2Star);
			}
			if (_textTimeFor1Star != null)
			{
				allTextTime(_textTimeFor3Star);
				_textTimeFor3Star.y = Constants.SCREEN_HALF_SIZE.y + 15;
				_gameScreen.cuttingTime(_gameScreen.oneStarTime, _textTimeFor3Star);
			}
			//====================================================================
			if (_animRestart != null)
			{
				_animRestart.goto(0);
				_animRestart.buttonMode = true;
			}
			if (_animMenu != null)
			{
				_animMenu.goto(2);
				_animMenu.buttonMode = true;
			}
			if (_animNext != null)
			{
				_animNext.goto(4);
				_animNext.buttonMode = true;
			}
			if (_animContinue != null)
			{
				_animContinue.buttonMode = true;
			}
		}
		
		protected function allTextTime(text:TextField):void
		{
			//_textFormat.font = "Eras Bold ITC";
			_textFormat.font = _embeddedFont.fontName;
			_textFormat.size = 24;
			_textFormat.color = 0xCCBEAE;
			_textFormat.align = "right";
				
			text.defaultTextFormat = _textFormat;
			text.width = 65;
			text.embedFonts = true;
			text.x = Constants.SCREEN_HALF_SIZE.x - 75;
			text.filters = [_glow];
			text.mouseEnabled = false;
		}
		
		public function render(bitmapData:BitmapData):void
		{
			if (_isWindow)
			{
				if (_isUsed)
				{
					if (!_openParam && _animWindow.p_playOnce) openParamFun();
					_animWindow.playOnce();
					if (_openParam)monitorKeystroke();
				}
				else
				{
					if (_animWindow.p_reversOnce)
					{
						//_gameMap.knight.isUsed = true;
						_gameScreen.isMisson = _gameScreen.isPause = false;
						_isUsed = _isWindow = _openParam = false;
						_gameScreen.openWindow = false;
						_screen.keyboard.resetAllPressedKey();
					}
					_animWindow.playOnceRevers();
				}
				
				_animWindow.render(bitmapData, _gameMap.cacheV2D.allocateV2D(_pos),false);
			}
		}
		
		protected function openParamFun():void
		{
			_openParam = true
			
			addAnimLink(_textPlayerTime);
			addAnimLink(_textTimeFor1Star);
			addAnimLink(_textTimeFor2Star);
			addAnimLink(_textTimeFor3Star);
			
			addAnimLink(_animContinue, onClickContinue);
			addAnimLink(_animRestart, onClickRestart);
			addAnimLink(_animMenu, onClickMenu);
			addAnimLink(_animNext, onClickNext);
		}
		
		// LINKS =====================================================================
		
		private function removeAnimLink(anim:*, metod:Function = null):void
		{
			if (anim != null && _gameScreen.contains(anim))
			{
				if (metod != null)
				{
					anim.removeEventListener(MouseEvent.CLICK, metod);
					anim.removeEventListener(MouseEvent.ROLL_OVER, overText);
					anim.removeEventListener(MouseEvent.ROLL_OUT, outText);
				}
				_gameScreen.removeChild(anim);
			}
		}
		
		private function addAnimLink(anim:*, metod:Function = null):void
		{
			if (anim != null)
			{
				if (metod != null)
				{
					anim.addEventListener(MouseEvent.CLICK, metod, false, 0, true);
					anim.addEventListener(MouseEvent.ROLL_OVER, overText, false, 0, true);
					anim.addEventListener(MouseEvent.ROLL_OUT, outText, false, 0, true);
				}
				_gameScreen.addChild(anim);
			}
		}
		
		// END LINKS =====================================================================
		
		private function callbackMenu():void
		{
			_isWindow = false;
			free();
			_gameScreen.free();
			_gameMap.clear();
			_screen.levelSelection();
			_screen.visibleBG = false;
			_screen.visibleAlpha();
		}
		
		private function callbackNext():void
		{
			_isWindow = false;
			free();
			_gameScreen.free();
			_gameMap.nextLevel();
		}
		
		private function callbackRestart():void
		{
			if (_gameMap.knight.isDead)
			{
				if(GameSave.inRange(GameSave.IMMORTAL))GameSave.setAward(GameSave.IMMORTAL);
			}
			_isWindow = false;
			free();
			_gameScreen.free();
			_gameMap.restartLevel();
		}
		
		protected function callbackContinue():void
		{
			free();
			_openParam = _screen.visibleBG = _isUsed = false;
			if(!_gameMap.knight.isDead)_gameScreen.startTicker();
		}
		
		// MOUSE EVENT =======================================================
		
		private function onClickContinue(e:MouseEvent):void
		{
			callbackContinue();
		}
		
		private function onClickRestart(e:MouseEvent):void
		{
			_soundManager.stopAllSound();
			//_soundManager.stopMusic();
			_soundManager.fadeOut(0, .25);
			_screen.gameShift(callbackRestart);
		}
		
		private function onClickMenu(e:MouseEvent):void
		{
			_soundManager.stopAllSound();
			//_soundManager.stopMusic();
			_soundManager.fadeOut(0, .25);
			_screen.gameShift(callbackMenu);
		}
		
		private function onClickNext(e:MouseEvent):void
		{
			if (_gameScreen.countStars == 0 && !_gameMap.perentLevel.isPlay) return;
			if (_gameMap.currNumLevel >= LevelManager.TOTAL_LEVEL) return;
			_soundManager.stopAllSound();
			//_soundManager.stopMusic();
			_soundManager.fadeOut(0, .25);
			_screen.gameShift(callbackNext);
		}
		
		protected function overText(e:MouseEvent):void
		{
			var s:AnimClip = e.currentTarget as AnimClip;
			s.goto(s.index + 1);
			_soundManager.playSound("Button");
		}
		
		protected function outText(e:MouseEvent):void
		{
			var s:AnimClip = e.currentTarget as AnimClip;
			s.goto(s.index - 1);
		}
		
		// MOUSE EVENT =======================================================
		
		protected function monitorKeystroke():void
		{
			if (_gameShift.isUsed) return;
			keyStroke(KeyCodes.SPACE, _animRestart, callbackRestart);
			keyStroke(KeyCodes.ENTER, _animNext, callbackNext);
			keyStroke(KeyCodes.ESC, _animMenu, callbackMenu);
			keyStroke(KeyCodes.ENTER, _animContinue, callbackContinue, false);
			keyStroke(KeyCodes.P, _animContinue, callbackContinue, false);
		}
		
		private function keyStroke(key:int, anim:AnimClip, metod:Function, shift:Boolean = true):void
		{
			if (anim == null) return;
			if(_screen.keyboard.isKeyDownTransition(key))
			{
				if (shift)
				{
					if (_gameScreen.countStars == 0 && !_gameMap.perentLevel.isPlay) return;
					if (key == KeyCodes.ENTER && _gameMap.currNumLevel >= LevelManager.TOTAL_LEVEL) return;
					_soundManager.stopAllSound();
					//_soundManager.stopMusic();
					_soundManager.fadeOut(0, .25);
					_screen.gameShift(metod);
				}
				else metod();
			}
		}

	}

}