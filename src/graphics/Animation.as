package graphics 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Animation extends Sprite
	{
		public var frames:Vector.<BitmapData>;
		public var index:int;
		public var bmp:BitmapData;
		public var rect:Rectangle;
		public var offsetX:Number;
		public var offsetY:Number;
		public var p_playOnce:Boolean;
		public var p_reversOnce:Boolean;
		
		private var _animLib:AnimLibrary;
		private var _anim:Array;
		private var _nameAnim:String;
		private var _point:Point;
		
		public function Animation() 
		{
			//frames = new Vector.<BitmapData>();
			_anim = [];
			index = 0;
			_point = new Point();
		}
		
		public function get getAnim():String
		{
			return _nameAnim;
		}
		
		public function addAnim(nameClass:String, nameAnim:String = null, switchToAnim:Boolean = false):void
		{
			_animLib = _anim[nameAnim] = CacheLibrary.getInstance().getAnim(nameClass);
			
			if (switchToAnim)
			{
				switchAnim(nameAnim);
			}
		}
		
		public function switchAnim(nameAnim:String):void
		{
			if (_nameAnim == nameAnim || _anim[nameAnim] == null)
				return;

			_animLib = _anim[nameAnim];
			_nameAnim = nameAnim;
			goToFrame(0);
		}
		
		private function toggleParam():void
		{
			bmp = _animLib.frames[index];
			rect = _animLib.frameRs[index];
			offsetX = _animLib.frameXs[index];
			offsetY = _animLib.frameYs[index];
		}
		
		public function playOnce():void
		{
			if (_animLib == null || p_playOnce) return;
			p_playOnce = index == _animLib.frames.length - 1;
			nextFrame();
			if (index == _animLib.frames.length) index = _animLib.frames.length - 1;
		}
		
		public function playOnceRevers():void
		{
			if (_animLib == null || p_reversOnce) return;
			p_reversOnce = index <= 0;
			reversFrame();
			if (index == -1) index = 0;
		}
		
		public function playOnceTo(to:int):void
		{
			if (_animLib == null || p_playOnce) return;
			nextFrame();
			p_playOnce = index >= to;
		}
		
		public function nextFrame():void
		{
			if (_animLib == null) return;
			if (index == _animLib.frames.length) index = 0;
			toggleParam();
			index++;
		}
		
		public function reversFrame():void
		{
			if (_animLib == null) return;
			if (index == -1) index = _animLib.frames.length - 1;
			toggleParam();
			index--;
		}
		
		public function goToFrame(value:int):void
		{
			if (_animLib == null) return;
			if (value > _animLib.frames.length - 1) 
			{
				value = _animLib.frames.length - 1;
				trace("goToFrame(): value > frames.length");
			}
			else if(value < 0)
			{
				value = 0;
			}
			index = value;
			toggleParam();
		}
		
		public function goToLastFrame():void
		{
			index = _animLib.frames.length - 1;
			toggleParam();
		}
		
		public function playFragment(from:int, to:int):void
		{
			if (index == from)goToFrame(to);
			else
			{
				toggleParam();
				index++;
			}
		}
		
		public function render(bitmapData:BitmapData, p:Vector2D, switchFrame:Boolean = true):void
		{
			if(switchFrame)nextFrame();
			_point.x = p.x + offsetX;
			_point.y = p.y + offsetY;
			bitmapData.copyPixels(bmp, rect, _point, null, null, true);
		}
		
		public function get length():int
		{
			return _animLib.frames.length - 1;
		}
		
	}

}