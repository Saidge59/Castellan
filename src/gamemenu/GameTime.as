package gamemenu 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import graphics.Animation;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameTime
	{
		private var _gameMap:GameMap;
		private var _gameScreen:GameScreen;
		private var _anim:Animation;
		private var _format:TextFormat;
		private var _textField:TextField;
		private var _embeddedFont:Font;
		private var _separator:String;
		private var _minute:int;
		private var _second:int;
		private var _point:Point;
		private var _pos:Vector2D;
		private var _glow:GlowFilter;
		
		public function GameTime() 
		{
			_gameMap = GameMap.getInstance();
			_gameScreen = GameScreen.getInstance();
			_format = new TextFormat();
			_textField = new TextField();
			_embeddedFont = new BerlinSansFBDemi();
			_point = new Point(0,0);
			//_pos = new Vector2D();
			
			_anim = new Animation();
			_anim.addAnim("GameTimeFon_mc", "fon", true);
			_glow = new GlowFilter(0x333333, 1, 2, 2, 800, 1);
		}
		
		public function free():void
		{
			_minute = _second = 0;
			if (_gameScreen.contains(_textField))
			{
				_gameScreen.removeChild(_textField);
			}
		}
		
		public function init():void
		{		
			_pos = _gameMap.cacheV2D.allocate(0,0);
			if (_anim != null)
			{
				processTick(0);
				_pos.init(490, 410);
				_point.x = _pos.x;
				_point.y = _pos.y;
			}
			if (_textField != null)
			{
				_format.size = 24;
				_format.color = 0xE2E1E9;
				_format.font = _embeddedFont.fontName;
				_format.align = "center";
				//_format.font = "Berlin Sans FB Demi";
				
				_textField.defaultTextFormat = _format;
				//_textField.autoSize = "center";
				//_textField.width = 40;
				_textField.x = 500;
				_textField.y = 426;
				_textField.mouseEnabled = false;
				_textField.embedFonts = true;
				_textField.filters = [_glow];
				_gameScreen.cuttingTime(_gameScreen.fullStarTime, _textField);
				_gameScreen.addChild(_textField);
			}
		}
		
		public function render(bitmapData:BitmapData):void
		{
			//switchBitmape();
			bitmapData.copyPixels(_anim.bmp, _anim.rect, _point, null, null, true);
		}
		
		public function processTick(scnd:int):void 
		{
			_second = _gameScreen.fullStarTime - scnd;
			//trace(scnd, _second);
			
			if (_second <= 0)
			{
				_second = 0;
				_gameMap.knight.hurt();
			}
			else if (_second < _gameScreen.oneStarTime)_anim.goToFrame(0);
			else if (_second < _gameScreen.twoStarsTime)_anim.goToFrame(1);
			else if (_second < _gameScreen.threeStarsTime)_anim.goToFrame(2);
			else if (_second <= _gameScreen.fullStarTime)_anim.goToFrame(3);
			
			_gameScreen.countStars = _anim.index;
			_gameScreen.countTime = _second;
			_gameScreen.cuttingTime(_second, _textField);
			//_textField.text = String(_minute + _separator + _second);
		}
		

		//public function processTick(scnd:int):void 
		//{
			//_second = scnd - (_minute * GameScreen.SECONDS);
			//if (_second > 59) {_minute++;_second = 0;}
			//if (_second < 10) _separator = ":0";
			//else _separator = ":";
			//_textField.text = String(_minute + _separator + _second);
		//}
		//
		//private function switchBitmape():void
		//{
			//var allTime:int = _minute * GameScreen.SECONDS + _second;
			//if (allTime < _gameScreen.threeStarsTime)_anim.goToFrame(3);
			//else if (allTime < _gameScreen.twoStarsTime)_anim.goToFrame(2);
			//else if (allTime < _gameScreen.oneStarTime)_anim.goToFrame(1);
			//else _anim.goToFrame(0);
			//if (allTime >= _gameScreen.noneStarTime) trace("you lost");
			//_gameScreen.countStars = _anim.index;
			//_gameScreen.countTime = allTime;
		//}
		
	}

}