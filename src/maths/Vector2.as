package maths
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author me
	 */
	public class Vector2
	{
		public var x:Number;
		public var y:Number;
		
		/// <summary>
		/// 
		/// </summary>	
		public function Vector2( x:Number = 0, y:Number = 0)
		{
			Initialise( x, y );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Initialise( x:Number=0, y:Number=0 ):void
		{
			this.x = x;
			this.y = y;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Add( v : Vector2 ) : Vector2
		{
			return new Vector2(x + v.x, y + v.y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddTo( v:Vector2 ):Vector2
		{
			x += v.x;
			y += v.y;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubFrom( v:Vector2 ):Vector2
		{
			x -= v.x;
			y -= v.y;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubScalar( s:Number ):Vector2
		{
			return new Vector2( x-s, y-s );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddScalar( s:Number ):Vector2
		{
			return new Vector2( x+s, y+s );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubScalarFrom( s:Number ):Vector2
		{
			x -= s;
			y -= s;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddScalarTo( s:Number ):Vector2
		{
			x += s;
			y += s;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddX( x : Number ) : Vector2
		{
			return new Vector2(x + x, y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddY( y : Number ) : Vector2
		{
			return new Vector2(x, y+y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubX( x:Number ) : Vector2
		{
			return new Vector2(x-x, y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubY( y:Number ) : Vector2
		{
			return new Vector2(x, y-y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddXTo( x : Number ) : Vector2
		{
			x += x;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddYTo( y : Number ) : Vector2
		{
			y += y;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubXFrom( x:Number ) : Vector2
		{
			x -= x;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubYFrom( y:Number ) : Vector2
		{
			y -= y;
			return this;
		}
		
		
		/// <summary>
		/// 
		/// </summary>	
		public function Sub( v : Vector2 ) : Vector2
		{
			return new Vector2(x - v.x, y - v.y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Mul( v : Vector2 ) : Vector2
		{
			return new Vector2(x * v.x, y * v.y);
		}
		
		/// <summary>
		/// 
		/// </summary>
		public function MulTo( v:Vector2 ):Vector2
		{
			x *= v.x;
			y *= v.y;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Div( v : Vector2 ) : Vector2
		{
			return new Vector2(x / v.x, y / v.y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function MulScalar( s : Number ) : Vector2
		{
			return new Vector2(x * s, y * s);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function MulScalarTo( s : Number ) : Vector2
		{
			x *= s;
			y *= s;
			
			return this;
		}
		
		public function MulAddScalar( v:Vector2, s:Number ):Vector2
		{
			return new Vector2(x + v.x * s, y + v.y * s);
		}
		
		/// <summary>
		/// Multiples v by s and then adds to the current vector
		/// </summary>	
		public function MulAddScalarTo( v:Vector2, s:Number ):Vector2
		{
			x += v.x*s;
			y += v.y*s;
			
			return this;
		}
		
		/// <summary>
		/// Multiples v by s and then subtracts from the current vector
		/// </summary>	
		public function MulSubScalarTo( v:Vector2, s:Number ):Vector2
		{
			x -= v.x*s;
			y -= v.y*s;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Dot( v : Vector2 ) : Number
		{
			return x * v.x + y * v.y;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function get m_LenSqr() : Number
		{
			return Dot(this);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function get m_Len() : Number
		{
			return Math.sqrt( m_LenSqr );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function get m_Abs() : Vector2
		{
			return new Vector2( Math.abs( x ), Math.abs( y ) );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function get m_Unit() : Vector2
		{
			var invLen : Number = 1.0 / m_Len;
			return MulScalar(invLen);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function get m_Floor():Vector2
		{
			return new Vector2(Math.floor(x), Math.floor(y));
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Clamp(min : Vector2, max : Vector2):Vector2
		{
			return new 	Vector2
						(
							Math.max( Math.min(x, max.x), min.x ),
							Math.max( Math.min(y, max.y), min.y )
						);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function ClampInto( min:Vector2, max:Vector2 ):Vector2
		{
			x = Math.max( Math.min( x, max.x ), min.x );
			y = Math.max( Math.min( y, max.y ), min.y );
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function get m_Perp():Vector2
		{
			return new Vector2( -y, x);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function get m_Neg():Vector2
		{
			return new Vector2( -x, -y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function NegTo( ):Vector2
		{
			x = -x;
			y = -y;
			
			return this;
		}
	
		/// <summary>
		/// 
		/// </summary>	
		public function Equal(v:Vector2):Boolean
		{
			return x == v.x && y == v.y;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public static function FromAngle(angle:Number) : Vector2
		{
			return new Vector2(Math.cos(angle), Math.sin(angle));
		}

		
		/// <summary>
		/// 
		/// </summary>	
		public static function RandomRadius(r:Number):Vector2
		{
			return new 	Vector2
						(
							Math.random() * 2 - 1,
							Math.random() * 2 - 1
						).MulScalar( r );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public static function FromPoint( point:Point ):Vector2
		{
			return new Vector2(point.x,point.y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function get m_Point():Point
		{
			return new Point(x, y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Clear( ):void
		{
			x=0;
			y=0;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Clone( ):Vector2
		{
			return new Vector2(x, y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function toString( ):String
		{
			return "x="+x+",y="+y;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function CloneInto( v:Vector2 ):Vector2
		{
			x = v.x;
			y = v.y;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function MaxInto( b:Vector2 ):Vector2
		{
			x = Math.max( x, b.x );
			y = Math.max( y, b.y );
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function MinInto( b:Vector2 ):Vector2
		{
			x = Math.min( x, b.x );
			y = Math.min( y, b.y );
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Min( b:Vector2 ):Vector2
		{
			return new Vector2( x, y ).MinInto( b );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Max( b:Vector2 ):Vector2
		{
			return new Vector2( x, y ).MaxInto( b );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AbsTo():void
		{
			x = Math.abs( x );
			y = Math.abs( y );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function UnitTo() : Vector2
		{
			var invLen : Number = 1.0 / m_Len;
			x *= invLen;
			y *= invLen;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function IsNaN( ):Boolean
		{
			return isNaN(x)||isNaN(y);
		}
		
		/// <summary>
		/// Get the largest coordinate and return a signed, unit vector containing only that coordinate
		/// </summary>	
		public function get m_MajorAxis( ):Vector2
		{
			if ( Math.abs( x )>Math.abs( y ) )
			{
				return new Vector2( Scalar.Sign(x), 0 );
			}
			else 
			{
				return new Vector2( 0, Scalar.Sign(y) );
			}
		}
		
		/// <summary>
		/// 
		/// </summary>
		public function FloorTo( ):Vector2
		{
			x = Math.floor( x );
			y = Math.floor( y );
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>
		public function RoundTo( ):Vector2
		{
			x = Math.floor( x+0.5 );
			y = Math.floor( y+0.5 );
			return this;
		}
		
	}
}