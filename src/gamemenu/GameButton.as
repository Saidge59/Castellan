package gamemenu 
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import graphics.Animation;
	import graphics.AnimClip;
	import maths.Vector2D;
	import system.KeyCodes;
	import system.SoundManager;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameButton
	{		
		private var _isMusic:Boolean;
		private var _isUsed:Boolean;
		
		private var _screen:Screen;
		private var _gameMap:GameMap;
		private var _gameScreen:GameScreen;
		private var _gameGuide:GameGuide;
		private var _soundManager:SoundManager;
		
		private var _animMusic:AnimClip;
		private var _animSound:AnimClip;
		private var _animPause:AnimClip;
		private var _animPlate:Animation;
		
		public function GameButton() 
		{
			_screen = Screen.getInstance();
			_gameMap = GameMap.getInstance();
			_gameScreen = GameScreen.getInstance();
			_gameGuide = GameGuide.getInstance();
			_soundManager = SoundManager.getInstance();
			
			_animMusic = new AnimClip();
			_animSound = new AnimClip();
			_animPause = new AnimClip();
			_animPlate = new Animation();
			_animPlate.addAnim("Kindle_torch_mc", "kindle", true);
			_animMusic.addAnim("GameButton_btn", "music", true);
			_animSound.addAnim("GameButton_btn", "sound", true);
			_animPause.addAnim("GameButton_btn", "pause", true);
		}
		
		public function free():void
		{
			_isUsed = _isMusic = false;
			removeButton(_animMusic, clickMusic);
			removeButton(_animSound, clickSound);
			removeButton(_animPause, clickPause);
		}
		
		public function init():void
		{
			_isUsed = true;
			createButton(_animMusic, clickMusic, getMusicFrame - 1, 40);
			createButton(_animSound, clickSound, getSoundFrame - 1, 60);
			createButton(_animPause, clickPause, 8, 80);
		}
		
		private function createButton(anim:AnimClip, metod:Function, frame:int,  ax:int):void
		{
			if (anim != null)
			{
				anim.x = ax;
				anim.y = Constants.SCREEN_SIZE.y - 40;
				anim.buttonMode = true;
				anim.goto(frame);
				_gameScreen.addChild(anim);
				
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
				_gameScreen.removeChild(anim);
			}
		}
		
		public function render(bitmapData:BitmapData):void
		{
			if (!_isUsed) return;
			var vector:Vector2D = _gameMap.cacheV2D.allocate(35, Constants.SCREEN_SIZE.y - 40);	
			_animPlate.render(bitmapData, vector, false);
			
			if (_screen.keyboard.isKeyDownTransition(KeyCodes.M))
			{
				_animMusic.goto(getMusicFrame - 1);
			}
			if(_screen.keyboard.isKeyDownTransition(KeyCodes.S))
			{
				_animSound.goto(getSoundFrame - 1);
			}
		}
		
		private function clickMusic(e:MouseEvent):void
		{
			if (_gameScreen.openWindow) return;
			if (_gameGuide.isUsed) return;
			_soundManager.muteMusic();
			_animMusic.goto(getMusicFrame);
			_screen.stageFocus();
		}
		private function clickSound(e:MouseEvent):void
		{
			if (_gameScreen.openWindow) return;
			if (_gameGuide.isUsed) return;
			_soundManager.muteSound();
			_animSound.goto(getSoundFrame);
			_screen.stageFocus();
		}
		private function clickPause(e:MouseEvent):void
		{
			if (_gameScreen.openWindow) return;
			if (!_gameMap.knight.isUsed) return;
			if (_gameGuide.isUsed) return;
			//if (_soundManager.getPauseMusic) return;
			_gameMap.knight.pause();
			_screen.stageFocus();
		}
		
		private function overAnim(e:MouseEvent):void
		{
			var anim:AnimClip = e.currentTarget as AnimClip;
				//anim.scaleX = anim.scaleY = 1.2;
				//if(anim == _animMusic)anim.goto(MUSIC_OVER);
				//else if(anim == _animSound)anim.goto(SOUND_OVER);
				//else anim.goto(PAUSE_OVER);
				anim.goto(anim.index + 1);
		}
		private function outAnim(e:MouseEvent):void
		{
			var anim:AnimClip = e.currentTarget as AnimClip;
				//anim.scaleX = anim.scaleY = 1;
				//if(anim == _animMusic)anim.goto(MUSIC_OUT);
				//else if(anim == _animSound)anim.goto(SOUND_OUT);
				//else anim.goto(PAUSE_OUT);
				anim.goto(anim.index - 1);
		}
		
		private function get getSoundFrame():int
		{
			if (_soundManager.getMuteSound) return 7;
			else return 5;
		}
		
		private function get getMusicFrame():int
		{
			if (_soundManager.getMuteMusic) return 3;
			else  return 1;
		}
		
	}

}