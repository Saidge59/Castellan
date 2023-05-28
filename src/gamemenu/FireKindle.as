package gamemenu 
{
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import graphics.Animation;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class FireKindle
	{
		public var color:int = Constants.NONE;
		
		private var _gameMap:GameMap;
		private var _gameScreen:GameScreen;
		private var _parant:GameKindle;
		
		private var _animPlate:Animation;
		private var _animTorch:Animation;
		private var _animFire:Animation;
		private var _animKey:Animation;
		
		private var _format:TextFormat;
		private var _text:TextField;
		private var _embeddedFont:Font;
		
		private var _pos:Vector2D;
		private var _glow:GlowFilter;
		
		public function FireKindle(ax:int, ay:int) 
		{
			_gameMap = GameMap.getInstance();
			_gameScreen = GameScreen.getInstance();
			_pos = new Vector2D(ax, ay);
			_animPlate = new Animation();
			_animTorch = new Animation();
			_animFire = new Animation();
			_animKey = new Animation();
			_animPlate.addAnim("Kindle_torch_mc", "kindle", true);
			_animTorch.addAnim("Mission_torch_mc", "torch");
			_animFire.addAnim("Kindle_fire_orange_mc", "fire_orange");
			_animFire.addAnim("Kindle_fire_blue_mc", "fire_blue");
			_animFire.addAnim("Kindle_fire_green_mc", "fire_green");
			_animFire.addAnim("Kindle_fire_purple_mc", "fire_purple");
			_animKey.addAnim("Orange_key_mc", "key_orange");
			_animKey.addAnim("Blue_key_mc", "key_blue");
			_animKey.addAnim("Green_key_mc", "key_green");
			_animKey.addAnim("Purple_key_mc", "key_purple");
			
			
			_format = new TextFormat();
			_text = new TextField();
			_embeddedFont = new BerlinSansFBDemi();
			
			_glow = new GlowFilter(0x302C29, 1, 2, 2, 800, 1);
		}
		
		public function free():void
		{
			color = Constants.NONE;
			if (_gameScreen.contains(_text))
			{
				_gameScreen.removeChild(_text);
			}
		}
		
		public function initial(parant:GameKindle, color:int):void
		{
			_parant = parant;
			this.color = color;
			
			switchTorch();
			switchFire();
			allTextParam();
		}
		
		private function allTextParam():void
		{
			_format.size = 20;
			_format.color = 0xE2E1E9;
			_format.font = _embeddedFont.fontName;
			_format.align = "left";
				
			_text.defaultTextFormat = _format;
			_text.x = _pos.x + 22;
			_text.y = _pos.y - 15;
			_text.mouseEnabled = false;
			_text.embedFonts = true;
			_text.filters = [_glow];
			_gameScreen.addChild(_text);
		}
		
		public function render(bitmapData:BitmapData):void
		{
			if (color == Constants.NONE) return;
			_animPlate.render(bitmapData, _pos, false);
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos).addToPiece(6, 6);	
				_animTorch.render(bitmapData, vector, false);
				_animFire.render(bitmapData, vector.addToPiece(0, -17));
			if (equalColor)
			{
				switchKey();
				_animKey.render(bitmapData, vector.addPiece(55,20));
			}
		}
		
		private function switchTorch():void
		{
			switch(color)
			{
				case Constants.NONE: break;
				case Constants.ORANGE: _animTorch.goToFrame(0);break;
				case Constants.BLUE: _animTorch.goToFrame(1);break;
				case Constants.GREEN: _animTorch.goToFrame(2);break;
				case Constants.PURPLE: _animTorch.goToFrame(3);break;
			}
		}
		private function switchFire():void
		{
			switch(color)
			{
				case Constants.NONE: break;
				case Constants.ORANGE: _animFire.switchAnim("fire_orange");break;
				case Constants.BLUE: _animFire.switchAnim("fire_blue");break;
				case Constants.GREEN: _animFire.switchAnim("fire_green");break;
				case Constants.PURPLE: _animFire.switchAnim("fire_purple");break;
			}
		}
		
		private function switchKey():void
		{
			switch(color)
			{
				case Constants.NONE: break;
				case Constants.ORANGE: _animKey.switchAnim("key_orange");break;
				case Constants.BLUE: _animKey.switchAnim("key_blue");break;
				case Constants.GREEN: _animKey.switchAnim("key_green");break;
				case Constants.PURPLE: _animKey.switchAnim("key_purple");break;
			}
		}
		
		private function get equalColor():Boolean
		{
			if(color == Constants.ORANGE && _gameScreen.pikedKeyOrange)return true;
			else if(color == Constants.BLUE && _gameScreen.pikedKeyBlue)return true;
			else if(color == Constants.GREEN && _gameScreen.pikedKeyGreen)return true;
			else if(color == Constants.PURPLE && _gameScreen.pikedKeyPurple) return true;
			else return false;
		}
		
		public function set text(text:String):void
		{
			_text.text = text;
		}
	}

}