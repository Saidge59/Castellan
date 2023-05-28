package system
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getDefinitionByName;
	import graphics.CacheLibrary;
	
	/**
	 * ...
	 * @author
	 */
	public class Preloader extends MovieClip
	{
		private var _graphicsPreloader:GraphicsPreloader;
		private var _bg:MovieClip;
		private var _play:MovieClip;
		private var _sideBar:MovieClip;
		private var _lineBar:MovieClip;
		private var _percentText:TextField;
		private var _text:TextField;
		private var _textFormat:TextFormat;
		
		public function Preloader()
		{
			//stage.showDefaultContextMenu = false;
			var cm:ContextMenu = new ContextMenu();
				cm.hideBuiltInItems();
			this.contextMenu = cm;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			//trace(_example.date, _example.month);
			//if (_example.date != 1 || _example.month != 4) return;
			if (!atHome(["local"])) return;
			_graphicsPreloader = GraphicsPreloader.getInstance(stage);
			_graphicsPreloader.init();
			_graphicsPreloader.textBar = "Loading...";
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
		}
		
		private function ioError(e:IOErrorEvent):void
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void
		{
			update(root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal);
		}
		
		private function update(percent:Number):void
		{
			_graphicsPreloader.update(percent);
		}
		
		private function completed():void
		{
			loadingFinished();
			startup();
		}

		private function checkFrame(e:Event):void
		{
			
			if (currentFrame == totalFrames)
			{
				stop();
				completed();
			}
		}
		
		private function loadingFinished():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
		}
		
		private function startup():void
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
		protected function getHome():String
		{
			var url:String = loaderInfo.loaderURL;
			var urlStart:Number = url.indexOf("://") + 3;
			var urlEnd:Number = url.indexOf("/", urlStart);
			var home:String = url.substring(urlStart, urlEnd);
			var LastDot:Number = home.lastIndexOf(".") - 1;
			var domEnd:Number = home.lastIndexOf(".", LastDot) + 1;
			home = home.substring(domEnd, home.length);
			return (home == "") ? "local" : home;
		}

		protected function atHome(aHomes:Array):Boolean
		{
			return (aHomes.indexOf(getHome()) > -1) ? true : false;
		}
	}
}