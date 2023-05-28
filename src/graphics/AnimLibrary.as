package graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import geometry.AABB;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class AnimLibrary extends Object
	{
		public var name:String;
		public var frames:Vector.<BitmapData>;
		public var frameXs:Vector.<int>;
		public var frameYs:Vector.<int>;
		public var frameRs:Vector.<Rectangle>;
		
		public function AnimLibrary() 
		{
			name = "";
			frames = new Vector.<BitmapData>();
			frameXs = new Vector.<int>();
			frameYs = new Vector.<int>();
			frameRs = new Vector.<Rectangle>();
		}
		
		public function classFromCache(clipName:MovieClip):void
		{
			var clip:MovieClip = clipName;
			var totalFrames:int = clip.totalFrames;
			var r:Rectangle = new Rectangle();
			var m:Matrix = new Matrix();
			var bmp:BitmapData = null;
			var i:int;
			for (i = 1; i <= totalFrames; i++)
			{
				clip.gotoAndStop(i);
				switchChild(clip, i);
				
				if (clip["rectSize"])
				{
					var s:Sprite = clip["rectSize"] as Sprite;
					r = new Rectangle(s.x, s.y, s.width, s.height);
					s.visible = false;
				}
				else r = clip.getBounds(clip);
				
				r.x = Math.ceil(r.x);
				r.y = Math.ceil(r.y);
				r.width = Math.ceil(r.width);
				r.height = Math.ceil(r.height);
				
				bmp = new BitmapData(r.width,r.height,true,0x00000000);
				m.identity();
				m.translate(-r.x, -r.y);
				m.scale(clip.scaleX, clip.scaleY);
				bmp.draw(clip, m);
				frames[frames.length] = bmp;
				frameXs[frameXs.length] = r.x;
				frameYs[frameYs.length] = r.y;
				r.x = r.y = 0;
				frameRs[frameRs.length] = r;
			}
			
		}
		
		private function switchChild(mc:MovieClip, frame:int):void
		{
			var clip:Object;
			var n:int = mc.numChildren;
			for (var i:int = 0; i < n; i++)
			{
				clip = mc.getChildAt(i);
				if (clip is MovieClip)
				{
					switchChild(clip as MovieClip, frame);
					clip.gotoAndStop(frame);
				}
			}
		}
		
	}

}