package system 
{
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class VectorCache extends SimpleCache
	{
		
		public function VectorCache(maxObjects:int = 0) 
		{
			super( Vector2D, maxObjects );
		}
		
		public function allocateV2D(v:Vector2D):Vector2D
		{
			return get.init(v.x,v.y);
		}
		public function allocate(arg1:Number, arg2:Number):Vector2D
		{
			return get.init(arg1,arg2);
		}
		
	}

}