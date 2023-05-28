package gamemenu 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import graphics.AnimClip;
	import maths.Vector2D;
	import system.KeyCodes;
	import system.SoundManager;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameSetting extends Sprite
	{
		private static var _instance:GameSetting;
		private var _isMusic:Boolean;
		private var _isUsed:Boolean;
		private var _pos:Vector2D;
		private var _isPlay:Boolean;
		private var _openParam:Boolean;
		
		private var _screen:Screen;
		private var _gameMap:GameMap;
		private var _gameMenu:GameMenu;
		private var _soundManager:SoundManager;
		private var _animWindow:AnimClip;
		private var _animClose:AnimClip;
		private var _animMusic:AnimClip;
		private var _animSound:AnimClip;
		private var _yesBtn:AnimClip;
		private var _noBtn:AnimClip;
		
		private var _format:TextFormat;
		private var _embeddedFont:Font;
		private var _textQuestion:TextField;
		private var _glow:GlowFilter;
		
		public function GameSetting() 
		{
			if (_instance)
			{
				throw("ERROR: GameSetting.getInstance()");	
			}
			_instance = this;
			
			_screen = Screen.getInstance();
			_gameMap = GameMap.getInstance();
			_gameMenu = GameMenu.getInstance();
			_soundManager = SoundManager.getInstance();
			
			_animWindow = new AnimClip();
			_animWindow.addAnim("Screen_Pause_mc", "window", true);
			
			_animMusic = new AnimClip();
			_animSound = new AnimClip();
			_animClose = new AnimClip();
			_yesBtn = new AnimClip();
			_noBtn = new AnimClip();
			_animMusic.addAnim("GameSetiing_btn", "music", true);
			_animSound.addAnim("GameSetiing_btn", "sound", true);
			_animClose.addAnim("Text_lose_mc", "close", true);
			_yesBtn.addAnim("Delete_btn", "delete_yes", true);
			_noBtn.addAnim("Delete_btn", "delete_no", true);
			
			_format = new TextFormat();
			_embeddedFont = new BerlinSansFBDemi();
			_textQuestion = new TextField();
			
			_glow = new GlowFilter(0x333333, 1, 2, 2, 800, 1);
		}
		
		public function free():void
		{
			_screen.stageFocus();
			_gameMenu.usedBtn = true;
			_openParam = _isUsed = _isMusic = false;
			if (this.contains(_textQuestion))
			{
				this.removeChild(_textQuestion);
			}
			removeButton(_animClose, clickClose);
			removeButton(_animMusic, clickMusic);
			removeButton(_animSound, clickSound);
			removeButton(_yesBtn, clickYes);
			removeButton(_noBtn, clickNo);
			removeButton(_animWindow);
			_screen.removeChild(this);
		}
		
		public function init():void
		{
			_isUsed = true;
			_openParam = false;
			_isPlay = _animWindow.p_playOnce = _animWindow.p_playOnceRevers = false;
			_pos = _gameMap.cacheV2D.allocate(Constants.SCREEN_HALF_SIZE.x, Constants.SCREEN_HALF_SIZE.y);
			_screen.visibleBG = true;
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos);
			createButton(_animWindow, null, 0, vector);
			createButton(_animClose, clickClose, 8, vector.addToPiece(0, 60));
			createButton(_animMusic, clickMusic, getMusicFrame - 1, vector.addToPiece(-20, -130));
			createButton(_animSound, clickSound, getSoundFrame - 1, vector.addToPiece(40, 0));
			createButton(_yesBtn, clickYes, 0, vector.init(_pos.x - 30, _pos.y + 20));
			createButton(_noBtn, clickNo, 2, vector.init(_pos.x + 30, _pos.y + 20));
			allTextParam();
			_animWindow.visible = true;
			_animWindow.mouseEnabled = false;
			
			_screen.addChild(this);
		}
		
		private function allTextParam():void
		{
			_format.size = 26;
			_format.color = 0xECECEC;
			_format.font = _embeddedFont.fontName;
			_format.align = "center";
				
			_textQuestion.defaultTextFormat = _format;
			_textQuestion.x = _pos.x - 76;
			_textQuestion.y = _pos.y - 55;
			_textQuestion.width = 152;
			_textQuestion.mouseEnabled = false;
			_textQuestion.embedFonts = true;
			_textQuestion.text = "Do you want \n delete save? \n /";
			_textQuestion.filters = [_glow];
			_textQuestion.visible = false;
			this.addChild(_textQuestion);
		}
		
		private function createButton(anim:AnimClip, metod:Function, frame:int,  pos:Vector2D):void
		{
			if (anim != null)
			{
				anim.x = pos.x;
				anim.y = pos.y;
				anim.goto(frame);
				anim.mouseChildren = false;
				anim.visible = false;
				this.addChild(anim);
				if (metod != null)
				{
					anim.buttonMode = true;
					anim.addEventListener(MouseEvent.CLICK, metod, false, 0, true);
					anim.addEventListener(MouseEvent.ROLL_OVER, overAnim, false, 0, true);
					anim.addEventListener(MouseEvent.ROLL_OUT, outAnim, false, 0, true);
				}
			}
		}
		
		private function removeButton(anim:AnimClip, metod:Function = null):void
		{
			if (anim != null)
			{
				if (metod != null)
				{
					anim.removeEventListener(MouseEvent.CLICK, metod);
					anim.removeEventListener(MouseEvent.ROLL_OVER, overAnim);
					anim.removeEventListener(MouseEvent.ROLL_OUT, outAnim);
				}
				this.removeChild(anim);
			}
		}
		
		private function clickMusic(e:MouseEvent):void
		{
			_soundManager.muteMusic();
			_animMusic.goto(getMusicFrame);
		}
		private function clickSound(e:MouseEvent):void
		{
			_soundManager.muteSound();
			_animSound.goto(getSoundFrame);
		}
		private function clickClose(e:MouseEvent):void
		{
			_isPlay = true;
		}
		private function clickYes(e:MouseEvent):void
		{
			_isPlay = true;
			GameSave.clearGame();
		}
		private function clickNo(e:MouseEvent):void
		{
			_isPlay = true;
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
		
		public function update(delta:Number):void
		{
			if (!_isUsed) return;
			if (!_isPlay)
			{
				_animWindow.playOnce();
			}
			else 
			{
				_animWindow.playOnceRevers();
				_screen.visibleBG = _animClose.visible = _animMusic.visible = _animSound.visible = false;
				_yesBtn.visible = _noBtn.visible =_textQuestion.visible = false;
			}
			
			if (!_openParam && _animWindow.p_playOnce) openParamFun();
			if (_screen.keyboard.isKeyDownTransition(KeyCodes.ESC) && _animWindow.p_playOnce)
			{
				_isPlay = true;
			}
			if (_screen.keyboard.isKeyDownTransition(KeyCodes.M))
			{
				_animMusic.goto(getMusicFrame - 1);
			}
			if(_screen.keyboard.isKeyDownTransition(KeyCodes.S))
			{
				_animSound.goto(getSoundFrame - 1);
			}
			if (_animWindow.p_playOnce && _animWindow.p_playOnceRevers)
			{
				free();
			}
		}
		
		private function openParamFun():void
		{
			_openParam = true;
			_animClose.visible = _animMusic.visible = _animSound.visible = true;
			_yesBtn.visible = _noBtn.visible =_textQuestion.visible = true;
		}
		
		public static function getInstance():GameSetting
		{
			return (_instance == null) ? new GameSetting() : _instance;
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