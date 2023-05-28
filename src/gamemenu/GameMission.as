package gamemenu 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import graphics.Animation;
	import graphics.AnimClip;
	import maths.Vector2D;
	import system.KeyCodes;
	import system.SimpleCache;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameMission extends GameWindows
	{		
		private static var _instance:GameMission;
		private var _cachTorchAnim:SimpleCache;
		private var _cachCountText:SimpleCache;
		private var _posList:Array;
		private var _torchList:Array;
		private var _textList:Array;
		private var _text:TextField;
		
		//private var _textTimeFor1Star:TextField;
		//private var _textTimeFor2Star:TextField;
		//private var _textTimeFor3Star:TextField;
		
		public function GameMission() 
		{
			if (_instance)
			{
				throw("ERROR: GameMission.getInstance()");	
			}
			_instance = this;

			_animWindow = new Animation();
			_animWindow.addAnim("ScreenMission_mc", "screenMission", true);
			
			_animStaticStars = new Animation();
			_animStaticStars.addAnim("Won_stars_mc", "StatStars", true);
			
			_cachTorchAnim = new SimpleCache(AnimClip, 4);
			_cachCountText = new SimpleCache(TextField, 4);

			_textTimeFor1Star = new TextField();
			_textTimeFor2Star = new TextField();
			_textTimeFor3Star = new TextField();

			_animContinue = new AnimClip();
			_animContinue.addAnim("Text_lose_mc", "play", true);
			
			_posList = [[ -10], [ -40, 20], [ -65, -10, 45], [ -85, -35, 15, 65]];
			_torchList = [];
			_textList = [];

			_textFormat = new TextFormat();
			_embeddedFont = new BerlinSansFBDemi();
		}
		
		public override function free():void
		{
			super.free();
			
			freeClip(_torchAnim, _torchList);
			freeClip(_text, _textList);
		}
		
		private function freeClip(clip:*, list:Array):void
		{
			var i:int = list.length;
			while (--i>-1)
			{
				clip = list[i];
				_gameScreen.removeChild(clip);
			}
			list.length = 0;
		}
		
		private function addClip(clip:*, list:Array):void
		{
			var i:int = list.length;
			while (--i>-1)
			{
				clip = list[i];
				_gameScreen.addChild(clip);
			}
		}
		
		public override function init():void
		{
			//_pos.init(Constants.SCREEN_HALF_SIZE.x, Constants.SCREEN_HALF_SIZE.y);
			_gameScreen.isMisson = true;
			_animStaticStars.index = 0;

			super.init();
			createKindle();
			
			if (_animContinue != null)
			{
				_animContinue.goto(6);
				_animContinue.x = _pos.x;
				_animContinue.y = _pos.y + 67;
			}
		}
		
		private function createKindle():void
		{
			var i:int = _gameScreen.numKindle;
			var isPurple:Boolean = _gameScreen.isPurple;
			var isGreen:Boolean = _gameScreen.isGreen;
			var isBlue:Boolean = _gameScreen.isBlue;
			var isOrange:Boolean = _gameScreen.isOrange;
			
			while (--i>-1)
			{				
				if (isPurple)
				{
					selectPos(Constants.PURPLE, i, _gameScreen.maxTorchPurple);
					isPurple = false;
				}
				else if (isGreen)
				{
					selectPos(Constants.GREEN, i, _gameScreen.maxTorchGreen);
					isGreen = false;
				}
				else if (isBlue)
				{
					selectPos(Constants.BLUE, i, _gameScreen.maxTorchBlue);
					isBlue = false;
				}
				else if (isOrange)
				{
					selectPos(Constants.ORANGE, i, _gameScreen.maxTorchOrange);
					isOrange = false;
				}
			}
		}
		
		private function selectPos(color:int, i:int, numTorch:int):void
		{
			torchAnimation(color, getPos(i));
			createText(getPos(i), numTorch);
		}
		
		private function torchAnimation(frame:int, pos:int):void
		{
			_torchAnim = _cachTorchAnim.get as AnimClip;
			_torchAnim.addAnim("Mission_torch_mc", "torch", true);
			_torchAnim.goto(frame);
			_torchAnim.x = _pos.x + pos;
			_torchAnim.y = _pos.y - 50;
			_torchList[_torchList.length] = _torchAnim;
		}
		
		private function createText(pos:int, countTorch:int):void
		{
			_textFormat.font = _embeddedFont.fontName;
			_textFormat.size = 24;
			_textFormat.color = 0xECECEC;
			_textFormat.align = "left";
				
			_text = _cachCountText.get as TextField;
			_text.defaultTextFormat = _textFormat;
			//_text.width = 24;
			_text.embedFonts = true;
			_text.mouseEnabled = false;
			_text.x = pos + _pos.x + 10;
			_text.y = _pos.y - 70;
			_text.filters = [_glow];
			_text.text = String("x" + countTorch);
			_textList[_textList.length] = _text;
		}

		protected override function openParamFun():void
		{
			addClip(_torchAnim, _torchList);
			addClip(_text, _textList);
			super.openParamFun();
		}
		
		protected override function callbackContinue():void
		{
			free();
			_openParam = _screen.visibleBG = _isUsed = false;
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			super.render(bitmapData);
			if (_isWindow)
			{
				var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos);
				if (_openParam)
				{
					_animStaticStars.render(bitmapData, vector, false);
				}
				if (_animWindow.p_reversOnce)
				{
					if (GameGuide.showGuide && !_gameMap.perentLevel.isPlay && _gameGuide.isToggle)
					{
						_gameGuide.init();
					}
					else
					{
						_gameScreen.startTicker();
						_gameMap.knight.isUsed = true;
					}
				}
			}
		}
		
		private function getPos(i:int):int
		{
			return _posList[_gameScreen.numKindle - 1][i];
		}
		
		public static function getInstance():GameMission
		{
			return (_instance == null) ? new GameMission() : _instance;
		}
		
	}

}