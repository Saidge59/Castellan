package gamemenu 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import graphics.AnimClip;
	import system.SoundManager;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameShift extends Sprite
	{
		public static const DELAY:int = 20;
		public var onCompleteCallback:Function = null;
		
		private var _screen:Screen;
		private var _soundManager:SoundManager;
		private static var _instance:GameShift;
		private var _main:Main;
		private var _animBG:AnimClip;
		private var _isUsed:Boolean;
		private var _isDark:Boolean;
		private var _alpha:Number = .2;
		private var _delay:int;
		
		public function GameShift() 
		{
			if (_instance)
			{
				throw("ERROR: GameShift.getInstance()");
			}
			_instance = this;
			
			_main = Main.getInstance();
			_screen = Screen.getInstance();
			_soundManager = SoundManager.getInstance();
			
			_animBG = new AnimClip();
			_animBG.addAnim("PreBG_mc", "bg", true);
		}
		
		public function free():void
		{
			_isUsed = false;
			//onCompleteCallback = null;
			//_soundManager.playMusic(_screen.musicName, true);
			
			if (_main.contains(_animBG))
			{
				_main.removeChild(_animBG);
			}
		}
		
		public function init():void
		{
			_isUsed = true;
			_isDark = true;
			_delay = GameShift.DELAY;
			
			//_soundManager.fadeOut(0, true, true);
			
			if (_animBG != null)
			{
				_animBG.alpha = 0;
				_animBG.mouseChildren = false;
				//_animBG.mouseEnabled = false;
				_main.addChild(_animBG);
			}
		}
		
		public function render(bitmapData:BitmapData):void
		{
			if (!_isUsed) return;
			//_animBG.render(bitmapData, _gameMap.cacheV2D.allocate(0, 0), false);
			if (_isDark)
			{
				_animBG.alpha += _alpha;
				if (_animBG.alpha >= 1)
				{
					_isDark = false;
					//if (onCompleteCallback != null)
					//{
						//(onCompleteCallback as Function).apply(this);
					//}
				}
			}
			else if(_delay > 0)
			{
				_delay--;
				if (onCompleteCallback != null && _delay <= 0)
				{
					(onCompleteCallback as Function).apply(this);
				}
			}
			else 
			{
				_animBG.alpha -= _alpha;
				if (_animBG.alpha <= 0)free();
			}
		}
		
		public static function getInstance():GameShift
		{
			return (_instance == null) ? new GameShift() : _instance;
		}
		
		public function get isUsed():Boolean
		{
			return _isUsed;
		}
		
	}

}