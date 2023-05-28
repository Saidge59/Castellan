package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import graphics.AnimClip;
	import graphics.CacheLibrary;
	import system.KeyCodes;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GraphicsPreloader
	{
		public var onCompleteCallback:Function = null;
		
		private static var _instance:GraphicsPreloader;
		private var _stg:Stage;
		private var _play:AnimClip;
		private var _bg:AnimClip;
		private var _sideBar:Sprite;
		private var _lineBar:Sprite;
		private var _percentBar:TextField;
		private var _textBar:TextField;
		private var _width:int = 110;
		
		public function GraphicsPreloader(stage:Stage = null) 
		{
			if (_instance)
			{
				throw("ERROR: GraphicsPreloader.getInstance()");
			}
			_instance = this;
			_stg = stage;
		}
		
		public function free():void
		{
			_stg.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_play.removeEventListener(MouseEvent.CLICK, clickPlay);
			_play.removeEventListener(MouseEvent.ROLL_OVER, overPlay);
			_play.removeEventListener(MouseEvent.ROLL_OUT, outPlay);
			
			if (_stg.contains(_bg))
			{
				_stg.removeChild(_bg);
				_bg = null;
			}
			if (_stg.contains(_sideBar))
			{
				_stg.removeChild(_sideBar);
				_sideBar = null;
			}
			if (_stg.contains(_play))
			{
				_stg.removeChild(_play);
				_play = null;
			}
		}
		
		public function init():void
		{
			var cache:CacheLibrary = CacheLibrary.getInstance();
				cache.addToCache(PreBG_mc);
				
			_play = new AnimClip();
			_bg = new AnimClip();
			_bg.addAnim("PreBG_mc", "bg", true);
			_sideBar = new PreSideBar_mc();
			_sideBar.x = 312;
			_sideBar.y = 312;
			
			_lineBar = _sideBar["lineBar"] as MovieClip;
			_percentBar = _sideBar["percentBar"] as TextField;
			_textBar = _sideBar["textBar"] as TextField;
			
			_bg.mouseChildren = false;
			_bg.mouseEnabled = false;
			_sideBar.mouseChildren = false;
			_sideBar.mouseEnabled = false;
			
			_stg.addChild(_bg);
			_stg.addChild(_sideBar);
		}
		
		public function update(percent:Number):void
		{
			progressAnim(percent);
			trace("Load..." +  percent * 100);
		}
		
		private function progressAnim(percent:Number):void
		{
			_lineBar.width = percent * _width;
			percent = Math.round(percent * 100);
			_percentBar.text = String(percent + "%");
		}
		
		public function createButton():void
		{
			_play.addAnim("Play_btn", "play",true);
			_play.x = 312;
			_play.y = 384;
			_play.goto(0);
			_play.buttonMode = true;
			_play.mouseChildren = false;
			_stg.addChild(_play);
			_play.addEventListener(MouseEvent.CLICK, clickPlay);
			_play.addEventListener(MouseEvent.ROLL_OVER, overPlay);
			_play.addEventListener(MouseEvent.ROLL_OUT, outPlay);
			_stg.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == KeyCodes.ENTER)
			{
				pressPlay();
			}
		}
		
		private function clickPlay(e:MouseEvent):void
		{
			pressPlay();
		}
		private function overPlay(e:MouseEvent):void
		{
			_play.goto(1);
		}
		private function outPlay(e:MouseEvent):void
		{
			_play.goto(0);
		}
		
		private function pressPlay():void
		{
			free();
			if (onCompleteCallback != null)
			{
				(onCompleteCallback as Function).apply(this);
			}
		}
		
		public function set textBar(value:String):void
		{
			_textBar.text = value;
		}
		
		public static function getInstance(stage:Stage = null):GraphicsPreloader
		{
			return (_instance == null) ? new GraphicsPreloader(stage) : _instance;
		}
		
	}

}