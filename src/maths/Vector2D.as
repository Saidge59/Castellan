package maths
{
	import flash.geom.Point;

	public class Vector2D
	{
		public var _x:Number;
		public var _y:Number;
		
		/// <summary>
		/// 
		/// </summary>	
		public function Vector2D(x:Number = 0, y:Number = 0)
		{
			init(x,y);
		}
		
		public function init(x:Number = 0, y:Number = 0):Vector2D
		{
			_x = x;
			_y = y;
			return this;
		}

		public function clone():Vector2D
		{
			return new Vector2D(_x,_y);
		}
		public function zero():Vector2D
		{
			_x = 0;
			_y = 0;
			return this;
		}
		public function clear():void
		{
			_x = 0;
			_y = 0;
		}
		public function isZero():Boolean
		{
			return _x == 0 && _y == 0;
		}
		
		// ============================ //
		// ************	ADD	*********** //
		// ============================ //

		public function add(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x + v2.x,_y + v2.y);
		}
		public function addTo(v2:Vector2D):Vector2D
		{
			_x += v2.x;
			_y += v2.y;
			return this;
		}
		public function addValue(value:Number):Vector2D
		{
			return new Vector2D(_x + value,_y + value);
		}
		public function addValueTo(value:Number):Vector2D
		{
			_x += value;
			_y += value;
			return this;
		}
		public function addX(value:Number):Vector2D
		{
			return new Vector2D(_x + value,_y);
		}
		public function addToX(value:Number):Vector2D
		{
			_x += value;
			return this;
		}
		public function addY(value:Number):Vector2D
		{
			return new Vector2D(_x,_y + value);
		}
		public function addToY(value:Number):Vector2D
		{
			_y += value;
			return this;
		}
		public function addPiece(arg1:Number, arg2:Number):Vector2D
		{
			return new Vector2D(_x + arg1,_y + arg2);
		}
		public function addToPiece(arg1:Number, arg2:Number):Vector2D
		{
			_x += arg1;
			_y += arg2;
			return this;
		}
		
		// ========================= ADD //
		
		// =========================== //
		// ********	SUBTRACTION	****** //
		// =========================== //
		
		public function sub(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x - v2.x,_y - v2.y);
		}
		public function subFrom(v2:Vector2D):Vector2D
		{
			_x -= v2.x;
			_y -= v2.y;
			return this;
		}
		public function subValue(value:Number):Vector2D
		{
			return new Vector2D(_x - value,_y - value);
		}
		public function subValueFrom(value:Number):Vector2D
		{
			_x -= value;
			_y -= value;
			return this;
		}
		public function subX(value:Number):Vector2D
		{
			return new Vector2D(_x - value,_y);
		}
		public function subFromX(value:Number):Vector2D
		{
			_x -= value;
			return this;
		}
		public function subY(value:Number):Vector2D
		{
			return new Vector2D(_x,_y - value);
		}
		public function subFromY(value:Number):Vector2D
		{
			_y -= value;
			return this;
		}
		// ========================= SUBTRACTION //
		
		// ============================== //
		// ********	MULTIPLICATION ****** //
		// ============================== //
		
		public function mulAdd( v2:Vector2D, value:Number ):Vector2D
		{			
			return new Vector2D(_x + v2.x * value, _y + v2.y * value);
		}
		public function mulAddTo( v2:Vector2D, value:Number ):Vector2D
		{
			_x += v2.x * value;
			_y += v2.y * value;
			return this;
		}
		public function mulSub( v2:Vector2D, value:Number ):Vector2D
		{			
			return new Vector2D(_x - v2.x * value, _y - v2.y * value);
		}
		public function mulSubTo( v2:Vector2D, value:Number ):Vector2D
		{
			_x -= v2.x * value;
			_y -= v2.y * value;
			return this;
		}
		public function mul(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x * v2.x,_y * v2.y);
		}
		public function mulTo(v2:Vector2D):Vector2D
		{
			_x *= v2.x;
			_y *= v2.y;
			return this;
		}
		public function mulValue(value:Number ):Vector2D
		{
			return new Vector2D(_x * value, _y * value);
		}
		public function mulValueX(valueX:Number ):Vector2D
		{
			return new Vector2D(_x * valueX, _y);
		}
		public function mulValueY(valueY:Number ):Vector2D
		{
			return new Vector2D(_x, _y * valueY);
		}
		public function mulValueTo(value:Number):Vector2D
		{
			_x *= value;
			_y *= value;
			return this;
		}
		// ========================= MULTIPLICATION //
		
		// ====================== //
		// ********	DIVIDE ****** //
		// ====================== //
		
		public function div(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x / v2.x, _y / v2.y);
		}
		public function divTo(v2:Vector2D):Vector2D
		{
			_x /= v2.x;
			_y /= v2.y;
			return this;
		}
		public function divValue(value:Number):Vector2D
		{
			return new Vector2D(_x / value, _y / value);
		}
		public function divValueTo(value:Number):Vector2D
		{
			_x /= value;
			_y /= value;
			return this;
		}
		// ========================= DIVIDE //
		
		// ========================= //
		// ********	MIN / MAX ****** //
		// ========================= //
		
		public function min(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x,_y).minTo(v2);
		}
		public function max(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x,_y).maxTo(v2);
		}
		public function maxTo( v2:Vector2D ):Vector2D
		{
			_x = Math.max( _x, v2.x );
			_y = Math.max( _y, v2.y );
			return this;
		}
		public function minTo( v2:Vector2D ):Vector2D
		{
			_x = Math.min( _x, v2.x );
			_y = Math.min( _y, v2.y );
			return this;
		}
		// ========================= MIN / MAX //
		
		public function get reverse():Vector2D
		{
			return new Vector2D(-_x,-_y);
		}
		public function reverseTo():Vector2D
		{
			_x =  - _x;
			_y =  - _y;
			return this;
		}

		public function isNormalized():Boolean
		{
			return dist == 1;
		}
		
		public function lenght(v2:Vector2D):Number
		{
			return Math.sqrt(lenghtSQ(v2));
		}
		
		public function lenghtSQ(v2:Vector2D):Number
		{
			var dx:Number = v2.x - x;
			var dy:Number = v2.y - y;
			return dx * dx + dy * dy;
		}
		
		public function get dist():Number
		{
			return Math.sqrt(distSQ);
		}
		
		public function get distSQ():Number
		{
			return dot(this);
		}

		public function dot(v2:Vector2D):Number
		{
			return _x * v2.x + _y * v2.y;
		}

		public static function angleBetween(v1:Vector2D,v2:Vector2D):Number
		{
			if (! v1.isNormalized())
			{
				v1 = v1.clone().normalize;
			}
			if (! v2.isNormalized())
			{
				v2 = v2.clone().normalize;
			}
			return Math.acos(v1.dot(v2));
		}
		
		public function get perp():Vector2D
		{
			return new Vector2D(- _y,_x);
		}
		
		public function equals(v2:Vector2D):Boolean
		{
			return _x == v2.x && _y == v2.y;
		}
		
		public function sign(v2:Vector2D):int
		{
			return perp.dot(v2) < 0 ? -1:1;
		}
		public function signValue( value:Number ):Number
		{
			return value >= 0 ? 1 : -1;
		}
		
		public function get abs():Vector2D
		{
			return new Vector2D(Math.abs( _x ), Math.abs( _y ));
		}
		
		public function absTo():void
		{
			_x = Math.abs(_x);
			_y = Math.abs(_y);
		}

		public function get axis( ):Vector2D
		{
			if ( Math.abs( _x )>Math.abs( _y ) )
			{
				return new Vector2D( Scalar.Sign(_x), 0 );
			}
			else 
			{
				return new Vector2D( 0, Scalar.Sign(_y) );
			}
		}
		
		public function round( ):Vector2D
		{
			return new Vector2D(int(_x + .5),int(_y + .5));
		}
		public function roundTo( ):Vector2D
		{
			_x = int(_x + 0.5);
			_y = int(_y + 0.5);
			return this;
		}
		
		public function get normalize():Vector2D
		{
			return new Vector2D(_x / dist, _y / dist);
		}
		public function get normalizeTo():Vector2D
		{
			_x /=  dist;
			_y /=  dist;
			return this;
		}
		
		public static function fromPoint( point:Point ):Vector2D
		{
			return new Vector2D(point.x,point.y);
		}

		public function get newPoint():Point
		{
			return new Point(_x, _y);
		}

		// ======================= //
		// ********	X / Y ******** //
		// ======================= //
		
		public function set(ax:Number = 0, ay:Number = 0):void
		{
			_x = ax;
			_y = ay;
		}
		public function set x(value:Number):void
		{
			_x = value;
		}
		public function get x():Number
		{
			return _x;
		}
		public function set y(value:Number):void
		{
			_y = value;
		}
		public function get y():Number
		{
			return _y;
		}
		public function toString():String
		{
			return "[Vector2D (x: " + _x + ", y: " + _y + ")]";
		}
		// ========================= X / Y //
		
		
		
		
	}

}