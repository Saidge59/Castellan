package gamemenu 
{
	import controller.PropertiesController;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import graphics.AnimClip;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameScreen extends Sprite
	{
		public static const SECONDS:int = 60;
		
		public var countStars:int;
		public var countTime:int;
		public var isWon:Boolean;
		public var isDied:Boolean;
		public var isPause:Boolean;
		public var isMisson:Boolean;
		public var openWindow:Boolean;
		
		public var threeStarsTime:int;
		public var twoStarsTime:int;
		public var oneStarTime:int;
		public var fullStarTime:int;
		//public var noneStarTime:int;
		
		public var maxTorchOrange:int;
		public var maxTorchBlue:int;
		public var maxTorchGreen:int;
		public var maxTorchPurple:int;
		
		public var pikedKeyOrange:Boolean = false;
		public var pikedKeyBlue:Boolean = false;
		public var pikedKeyGreen:Boolean = false;
		public var pikedKeyPurple:Boolean = false;
		
		public var openKeyOrange:Boolean;
		public var openKeyBlue:Boolean;
		public var openKeyGreen:Boolean;
		public var openKeyPurple:Boolean;
		
		public var isOrange:Boolean;
		public var isBlue:Boolean;
		public var isGreen:Boolean;
		public var isPurple:Boolean;
		public var numKindle:int;
		
		public var torchArray:Array;
		
		private static var _instance:GameScreen;
		private var _screen:Screen;
		private var _gameMap:GameMap;
		private var _ticker:Timer;
		private var _startTick:int;
		private var _currentTime:int;
		private var _subTime:int;
		private var _gameTime:GameTime;
		private var _gameKindle:GameKindle;
		private var _gameButton:GameButton;
		
		public function GameScreen() 
		{
			if (_instance)
			{
				throw("ERROR: GameScreen.getInstance()");	
			}
			
			_instance = this;
			_screen = Screen.getInstance();
			_gameMap = GameMap.getInstance();
			_ticker = new Timer(1000);
			_gameTime = new GameTime();
			_gameKindle = new GameKindle();
			_gameButton = new GameButton();

			torchArray = [];
		}
		
		public function free():void
		{
			_ticker.removeEventListener(TimerEvent.TIMER, onTick);
			
			_gameTime.free();
			_gameKindle.free();
			_gameButton.free();
			stopTicker();
			
			torchArray = [];
			countTime = 0;
			torchArray.length = 0;
			
			openWindow = isMisson = isPause = isWon = isDied = pikedKeyOrange = pikedKeyBlue = pikedKeyGreen = pikedKeyPurple = openKeyOrange = openKeyBlue = openKeyGreen = openKeyPurple = false;
			
			//trace("screen " + this.numChildren);
		}
		
		public function init():void
		{
			//_currentTime = getTimer();
			_ticker.addEventListener(TimerEvent.TIMER, onTick, false, 0, true);
			
			_gameTime.init();
			_gameKindle.init();
			_gameButton.init();
			_screen.gameMission();
			_subTime = 0;
			//startTicker();
		}
		
		public function startTicker():void
		{
			_startTick = getTimer();
			_ticker.start();
		}
		
		public function stopTicker():void
		{
			_ticker.stop();
			fullStarTime -= (getTimer() - _startTick) * .001;
			fullStarTime++;
		}
		
		private function onTick(e:TimerEvent):void
		{
			var seconds:int = (getTimer() - _startTick) * .001;
				seconds += _subTime;
			_gameTime.processTick(seconds);
		}
		
		public function cuttingTime(time:int, text:TextField):void 
		{
			var minute:int = time / GameScreen.SECONDS;
			var seconds:int = time - (minute * GameScreen.SECONDS);
			var separator:String = "";
			
			if (seconds < 10) separator = ":0";
			else separator = ":";
			
			text.text = String(minute + separator + seconds);
		}
		
		public function updateCount():void
		{
			_gameKindle.updateCount(torchArray);
		}
		
		public function render(bitmapData:BitmapData):void
		{
			_gameTime.render(bitmapData);
			_gameKindle.render(bitmapData);
			_gameButton.render(bitmapData);
		}
		
		public static function getInstance():GameScreen
		{
			return (_instance == null) ? new GameScreen() : _instance;
		}
		
		public function set subTime(value:int):void
		{
			_subTime += value;
			var seconds:int = (getTimer() - _startTick) * .001;
				seconds += _subTime;
			_gameTime.processTick(seconds);
		}
		
	}

}