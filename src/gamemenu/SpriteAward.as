package gamemenu 
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import graphics.AnimClip;
	import maths.Scalar;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class SpriteAward extends Sprite
	{
		public var logoT:String;
		public var maxIndex:int;
		public var curentIndex:int;
		
		private var _screen:Screen;
		private var _spriteAward:AnimClip;
		private var _sideBar:AnimClip;
		private var _textFormat:TextFormat;
		private var _embeddedFont:Font;
		private var _text:TextField;
		private var _textLogo:TextField;
		private var _glow:GlowFilter;
		
		public function SpriteAward() 
		{
			_screen = Screen.getInstance();
			_spriteAward = new AnimClip();
			_sideBar = new AnimClip();
			_spriteAward.addAnim("SpriteAward_mc", "sprite");
			_sideBar.addAnim("SideBar_mc", "bar");
			_textFormat = new TextFormat();
			_text = new TextField();
			_textLogo = new TextField();
			_embeddedFont = new BerlinSansFBDemi();
			
			_glow = new GlowFilter(0x433E2D, 1, 2, 2, 10, 1);
		}
		
		public function free():void
		{
			if (this.contains(_spriteAward))
			{
				this.removeChild(_spriteAward);
			}
			if (this.contains(_sideBar))
			{
				this.removeChild(_sideBar);
			}
			if (this.contains(_text))
			{
				this.removeChild(_text);
			}
			if (this.contains(_textLogo))
			{
				this.removeChild(_textLogo);
			}
		}
		
		public function init(pos:Vector2D, index:int):void
		{
			this.x = pos.x;
			this.y = pos.y;
				
			if (_spriteAward != null)
			{
				if(curentIndex == maxIndex)_spriteAward.goto(index * 2);
				else _spriteAward.goto((index * 2) + 1);
				_spriteAward.mouseChildren = false;
				_spriteAward.mouseEnabled = false;
				this.addChild(_spriteAward);
			}
			if (_sideBar != null)
			{
				_sideBar.goto(getFrame);
				_sideBar.x = 94;
				_sideBar.y = 7;
				_sideBar.mouseChildren = false;
				_sideBar.mouseEnabled = false;
				this.addChild(_sideBar);
			}
			if (_textLogo != null)
			{
				allTextTime(_textLogo, 16, 0xEDF7F9, pos.init(25,-26), logoT);
			}
			if (_text != null)
			{
				allTextTime(_text, 16, 0xFFFFFF, pos.init(25,-5), String(curentIndex + "/" + maxIndex));
			}
		}
		
		private function allTextTime(text:TextField, size:int, color:uint, pos:Vector2D, str:String):void
		{
			_textFormat.font = _embeddedFont.fontName;
			_textFormat.size = size;
			_textFormat.align = "center";
			_textFormat.color = color;
			
			text.defaultTextFormat = _textFormat;
			text.width = 140;
			text.x = pos.x;
			text.y = pos.y;
			text.embedFonts = true;
			text.mouseEnabled = false;
			text.filters = [_glow];
			text.text = str;
			this.addChild(text);
		}
		
		private function get getFrame():int
		{
			var percent:int = Scalar.toPercent(curentIndex, maxIndex);
			var frame:int = Scalar.fromPercent(percent, 42);
			return frame;
		}
		
	}

}