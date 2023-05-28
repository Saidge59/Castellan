package graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class AnimClip extends Sprite
	{
		public var index:int;
		public var p_playOnce:Boolean;
		public var p_playOnceRevers:Boolean;
		
		private var _animation:Animation;
		private var _bitmap:Bitmap;
		private var _anim:Array;
		private var _nameAnim:String;
		private var _switchToAnim:Boolean;
		private var _pos:Vector2D;
		
		public function AnimClip() 
		{
			_animation = new Animation();
			_bitmap = new Bitmap();
			this.addChild(_bitmap);
			_anim = new Array();
		}
		
		public function addAnim(nameClass:String, nameAnim:String = null,switchToAnim:Boolean=false):void
		{
			if (_nameAnim == nameAnim)
				return;
				
			_nameAnim = nameAnim;
			_switchToAnim = switchToAnim;
			
			_animation.addAnim(nameClass, nameAnim, switchToAnim);
			goto(0);
		}
		
		public function get getAnimName():String
		{
			return _nameAnim;
		}
		
		public function switchAnim(nameAnim:String):void
		{
			_animation.switchAnim(nameAnim);
			goto(0);
		}
		
		private function toggleParam():void
		{
			_bitmap.x = _animation.offsetX;
			_bitmap.y = _animation.offsetY;
			_bitmap.bitmapData = _animation.bmp;
		}
		
		public function goto(frame:int):void
		{
			if(frame < 0)
			{
				frame = 0;
			}
			_animation.goToFrame(frame);
			toggleParam();
			index = frame;
		}

		public function nextFrame():void
		{
			if (index == _animation.length) index = 0;
			_animation.goToFrame(index);
			toggleParam();
			index++;
		}
		public function reversFrame():void
		{
			if (index == 0) index = _animation.length;
			_animation.goToFrame(index);
			toggleParam();
			index--;
		}
		
		public function playOnce():void
		{
			if (p_playOnce) return;
			nextFrame();
			p_playOnce = index == _animation.length;
		}
		public function playOnceRevers():void
		{
			if (p_playOnceRevers) return;
			reversFrame();
			p_playOnceRevers = index == 0;
		}
		
		public function get length():int
		{
			return _animation.length;
		}
		
		public function set pos(p:Vector2D):void
		{
			_pos = p;
			this.x = p.x;
			this.y = p.y;
		}
		public function get pos():Vector2D
		{
			return _pos;
		}
	}

}