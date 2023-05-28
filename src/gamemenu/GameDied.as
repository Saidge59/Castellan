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
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameDied extends GameWindows
	{
		private static var _instance:GameDied;
		//private var _overRestart:Boolean;
		//private var _overMenu:Boolean;
		
		//private var _frameText:int;
		
		//private var _textFormat:TextFormat;
		//private var _textRestart:TextField;
		
		public function GameDied() 
		{
			if (_instance)
			{
				throw("ERROR: GameDied.getInstance()");	
			}
			_instance = this;
			//_textRestart = new TextField();
			
			_animWindow = new Animation();
			_animWindow.addAnim("Screen_died_mc", "screenDied", true);
			
			_animRestart = new AnimClip();
			_animMenu = new AnimClip();
			_animRestart.addAnim("Text_lose_mc", "restart", true);
			_animMenu.addAnim("Text_lose_mc", "menu", true);
			
			_textFormat = new TextFormat();
			_textPlayerTime = new TextField();
			_embeddedFont = new BerlinSansFBDemi();
		}
		
		public override function free():void
		{
			_gameScreen.isDied = false;
			super.free();
		}
		
		public override function init():void
		{				
			_soundManager.playSound("HeroDead");
			super.init();
			if (_textPlayerTime != null)
			{
				_textPlayerTime.x = _pos.x - _textPlayerTime.width * .5;
				_textPlayerTime.y = _pos.y - 70;
			}
			if (_animRestart != null)
			{
				_animRestart.x = _pos.x;
				_animRestart.y = _pos.y;
			}
			if (_animMenu != null)
			{
				_animMenu.x = _pos.x;
				_animMenu.y = _pos.y + 40;
			}
		}

		
		public override function render(bitmapData:BitmapData):void
		{
			super.render(bitmapData);
		}
		
		public static function getInstance():GameDied
		{
			return (_instance == null) ? new GameDied() : _instance;
		}
		
	}

}