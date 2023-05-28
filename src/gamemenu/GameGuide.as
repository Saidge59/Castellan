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
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameGuide extends Sprite
	{
		public static const FIRST_SCENE:int = 0;
		public static const LAST_SCENE:int = 7;
		public static var showGuide:Boolean;
		public var openSceneTo:int = 1;
		
		private static var _instance:GameGuide;
		private var _screen:Screen;
		private var _gameMap:GameMap;
		private var _gameScreen:GameScreen;
		private var _levelSelection:LevelSelection;
		private var _ramkaClose:AnimClip;
		private var _animWindow:AnimClip;
		private var _animScene:AnimClip;
		private var _animClose:AnimClip;
		private var _arrowR:AnimClip;
		private var _arrowL:AnimClip;
		private var _animToggle:AnimClip;
		private var _format:TextFormat;
		private var _embeddedFont:Font;
		private var _textLogo:TextField;
		private var _textScene:TextField;
		private var _textShow:TextField;
		private var _pos:Vector2D;
		private var _openParam:Boolean;
		private var _isUsed:Boolean;
		private var _isPlay:Boolean;
		private var _isToggle:Boolean;
		private var _glow:GlowFilter;
		private var _allScene:Boolean;
		
		public function GameGuide() 
		{
			if (_instance)
			{
				throw("ERROR: GameGuide.getInstance()");	
			}
			_instance = this;
			_isToggle = true;
			
			_screen = Screen.getInstance();
			_gameMap = GameMap.getInstance();
			_gameScreen = GameScreen.getInstance();
			_levelSelection = LevelSelection.getInstance();
			
			_ramkaClose = new AnimClip();
			_animWindow = new AnimClip();
			_animClose = new AnimClip();
			_animScene = new AnimClip();
			_arrowR = new AnimClip();
			_arrowL = new AnimClip();
			_animToggle = new AnimClip();
			_ramkaClose.addAnim("Ramka_close_mc", "ramka", true);
			_animWindow.addAnim("Screen_Pause_mc", "pause", true);
			_animClose.addAnim("Text_lose_mc", "close", true);
			_animScene.addAnim("Scene_mc", "scene");
			_arrowR.addAnim("Arrow_award_btn", "arrowR", true);
			_arrowL.addAnim("Arrow_award_btn", "arrowL", true);
			_animToggle.addAnim("Toggle_mc", "toggle", true);
			
			_format = new TextFormat();
			_embeddedFont = new BerlinSansFBDemi();
			_textLogo = new TextField();
			_textScene = new TextField();
			_textShow = new TextField();
			
			_glow = new GlowFilter(0x333333, 1, 2, 2, 800, 1);
		}
		
		public function free():void
		{
			_levelSelection.usedBtn = true;
			_openParam = _isUsed = _isPlay = false;
			showGuide = false;
			openSceneTo = 1;
			
			if (_gameMap.isUsed)
			{
				_gameScreen.startTicker();
				_gameMap.knight.isUsed = true;
			}
			if (!_gameMap.isUsed)
			{
				if (this.contains(_textShow)) this.removeChild(_textShow);
				removeAnim(_animToggle, clickToggle);
			}
			
			if (this.contains(_textLogo)) this.removeChild(_textLogo);
			if (this.contains(_textScene)) this.removeChild(_textScene);
			removeAnim(_arrowR, clickArrowR);
			removeAnim(_arrowL, clickArrowL);
			removeAnim(_animClose, clickClose);
			removeAnim(_ramkaClose);
			removeAnim(_animWindow);
			_screen.removeChild(this);
		}
		
		public function init():void
		{
			if (_gameMap.isUsed && !_isToggle)return;
			if (!showGuide) return;
			
			_isUsed = true;
			_openParam = false;
			_screen.visibleBG = true;
			_isPlay = _animWindow.p_playOnce = _animWindow.p_playOnceRevers = false;
			_pos = _gameMap.cacheV2D.allocate(Constants.SCREEN_HALF_SIZE.x, Constants.SCREEN_HALF_SIZE.y);

			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos);
			createAnim(_ramkaClose, null, 0, vector.init(_pos.x, _pos.y + 110));
			createAnim(_animWindow, null, 0, vector.init(_pos.x, _pos.y));
			createAnim(_animClose, clickClose, 8, vector.init(_pos.x, _pos.y + 120));
			createAnim(_animScene, null, openSceneTo, vector.init(_pos.x, _pos.y));
			createAnim(_arrowR, clickArrowR, 4, vector.init(_pos.x + 33, _pos.y + 67));
			createAnim(_arrowL, clickArrowL, 6, vector.init(_pos.x - 33, _pos.y + 67));
			textParam(_textLogo, vector.init(_pos.x - 42, _pos.y - 87), 0xFFD700, 30, 84, "Guide");
			textParam(_textScene, vector.init(_pos.x - 17, _pos.y + 52), 0xECECEC, 20, 40, String(openSceneTo + "/" + GameSave.countScene));
			if (!_gameMap.isUsed)
			{
				createAnim(_animToggle, clickToggle, getFrameToggle, vector.init(_pos.x - 38, _pos.y - 155));
				textParam(_textShow, vector.init(_pos.x - 17, _pos.y - 175), 0xECECEC, 30, 85, "Show?");
			}
			
			_screen.addChild(this);
			
			_animWindow.visible = true;
		}
		
		private function textParam(text:TextField, pos:Vector2D, color:uint, size:int, width:int, string:String = ""):void
		{
			_format.size = size;
			_format.color = color;
			_format.font = _embeddedFont.fontName;
			_format.align = "center";
				
			text.defaultTextFormat = _format;
			text.x = pos.x;
			text.y = pos.y;
			text.width = width;
			text.mouseEnabled = false;
			text.embedFonts = true;
			text.text = string;
			text.filters = [_glow];
			text.visible = false;
			this.addChild(text);
		}
		
		private function createAnim(anim:AnimClip, metod:Function, frame:int,  pos:Vector2D):void
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
		
		private function removeAnim(anim:AnimClip, metod:Function = null):void
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
		
		private function openParamFun():void
		{
			_openParam = true;
			objectVisible(true);
		}
		
		private function clickClose(e:MouseEvent):void
		{
			objectVisible(false);
			_screen.visibleBG = false;
			_isPlay = true;
		}
		
		private function objectVisible(value:Boolean):void
		{
			_animClose.visible = _ramkaClose.visible = _openParam = _animScene.visible = _arrowR.visible = _arrowL.visible = _textScene.visible = _textLogo.visible = value;
			if (!_gameMap.isUsed)
			{
				_animToggle.visible = _textShow.visible = value;
			}
		}
		
		private function clickToggle(e:MouseEvent):void
		{
			_isToggle = !_isToggle;
			if (_isToggle)_animToggle.goto(1);
			else _animToggle.goto(3);
		}
		
		private function clickArrowR(e:MouseEvent):void
		{
			pageManagement(1);
		}
		private function clickArrowL(e:MouseEvent):void
		{
			pageManagement(-1);
		}

		private function pageManagement(i:int):void
		{
			openSceneTo += i;
			if (openSceneTo > GameSave.countScene || openSceneTo < GameGuide.FIRST_SCENE)
			{
				openSceneTo -= i;
				return;
			}
			_animScene.goto(openSceneTo);
			_textScene.text = String(openSceneTo + "/" + GameSave.countScene);
			//removeSprite();
			if (openSceneTo == GameGuide.FIRST_SCENE)_arrowL.visible = false;
			else _arrowL.visible = true;
			if (openSceneTo == GameSave.countScene)_arrowR.visible = false;
			else _arrowR.visible = true;
			//createSprite();
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
			if (!_isPlay && !_openParam)
			{
				_animWindow.playOnce();
				if (_animWindow.p_playOnce) openParamFun();
			}
			else if(_isPlay)
			{
				_animWindow.playOnceRevers();
			}
			if (_animWindow.p_playOnceRevers)
			{
				free();
			}
			if (_openParam) monitorKeystroke();
		}
		
		private function monitorKeystroke():void
		{
			if (_screen.keyboard.isKeyDownTransition(KeyCodes.ESC))
			{
				objectVisible(false);
				_screen.visibleBG = false;
				_isPlay = true;
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
		
		public static function getInstance():GameGuide
		{
			return (_instance == null) ? new GameGuide() : _instance;
		}
		
		public function get isToggle():Boolean
		{
			return _isToggle;
		}
		
		public function get isUsed():Boolean
		{
			return _isUsed;
		}
		
		private function get getFrameToggle():int
		{
			if (_isToggle)return 0;
			else return 2;
		}

	}

}