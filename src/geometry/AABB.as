package geometry
{
	import maths.*;
	import system.*;
	
	public class AABB implements IAABB
	{
		private var _center:Vector2D;
		private var _halfSize:Vector2D;

		public function AABB(center:Vector2D=null, halfSize:Vector2D=null)
		{
			init( center, halfSize );	
		}

		public function init(center:Vector2D, halfSize:Vector2D):void
		{
			_center = center;
			_halfSize = halfSize;
		}

		public function get center( ):Vector2D
		{
			return _center;
		}

		public function set center( cnt:Vector2D ):void
		{
			_center = cnt;
		}
		
		public function get halfSize():Vector2D
		{
			return _halfSize;
		}
	
		public function get bottomLeft():Vector2D
		{
			return _center.add( new Vector2D(-_halfSize.x, _halfSize.y) );
		}

		public function get bottomRight():Vector2D
		{
			return _center.add( new Vector2D(_halfSize.x, _halfSize.y) );
		}

		public function get topLeft():Vector2D
		{
			return _center.add( new Vector2D(-_halfSize.x, -_halfSize.y) );
		}
		
		public function get topRight():Vector2D
		{
			return _center.add( new Vector2D(_halfSize.x, -_halfSize.y) );
		}
		
		public function get min():Vector2D
		{
			return topLeft;
		}
		
		public function get max():Vector2D
		{
			return bottomRight;
		}
		
		public static function overlap(a:IAABB, b:IAABB):Boolean
		{
			var dist:Vector2D = a.center.sub(b.center).abs.sub(a.halfSize.add(b.halfSize));
			return dist.x < 0 && dist.y < 0;
		}

		public function addSides( param:Number ):void
		{
			_halfSize.x += param;
			_halfSize.y += param;
		}
		
		 public function updateFrom(center:Vector2D, halfSize:Vector2D) : void
        {
            _center = center;
            _halfSize = halfSize;
        }


	}
}
