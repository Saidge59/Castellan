package maths
{
	import flash.geom.ColorTransform;
	import flash.utils.Endian;
	public class Scalar
	{
		static public const kMaxRandValue:uint = 65535;
		
		/// <summary>
		/// Return only the fractional component of n - always positive
		/// </summary>
		/// <param name="n"></param>
		/// <returns></returns>
		static public function Frac( n:Number ):Number
		{
			var abs:Number=Math.abs( n );
			return abs-Math.floor( abs );
		}
		
		/// <summary>
		/// x = 1.5, range = 1
		/// t = 1.5 / 1 = 1.5
		/// ft = 0.5
		/// return = 1*0.5 = 0.5 
		/// </summary>
		/// <param name="x"></param>
		/// <param name="range"></param>
		/// <returns></returns>
		static public function Wrap(x:Number, range:Number):Number
		{
			var t:Number = x / range;
			var ft:Number = Frac(t);
			return range * ft;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		static public function EaseOut( x:Number ):Number
		{
			var a:Number=x-1;
			return a*a*a + 1;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		static public function EaseOutVel( x:Number ):Number
		{
			var a:Number=x-1;
			return a*a*3;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		static public function RandBetween( a:Number, b:Number ):Number
		{
			return Math.random( )*( b-a )+a;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		static public function RandBetweenInt( a:int, b:int ):int
		{
			return int(RandBetween( a, b ));
		}
		
		/// <summary>
		/// 
		/// </summary>	
		static public function RandUint( ):int
		{
			return uint(Math.random( )*kMaxRandValue);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		static public function RandInt( ):int
		{
			return int(Math.random( )*kMaxRandValue);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		//static public function FromVector2( v:Vector2):Number
		//{
			//return Math.atan2( v.m_y, v.m_x );
		//}
		
		/// <summary>
		/// 0xrrggbb
		/// </summary>	
		static public function MakeColour(r:uint,g:uint,b:uint):uint
		{
			return r|( g<<8 )|( b<<16 );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		static public function RedFromColour( c:uint ):uint
		{
			return c&0xff;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		static public function GreenFromColour( c:uint ):uint
		{
			return (c>>8)&0xff;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		static public function BlueFromColour( c:uint ):uint
		{
			return (c>>16)&0xff;
		}
		
		/// <summary>
		/// maps 0-infinity to 0-1
		/// </summary>	
		static public function InfinityCurve(x:Number):Number
		{
			return -1/(x+1) + 1;
		}

		static public function ColorTransformFromBGR( bgr:uint ):ColorTransform
		{
			return new ColorTransform( Scalar.BlueFromColour( bgr )/255.0, Scalar.GreenFromColour( bgr )/255.0, Scalar.RedFromColour( bgr )/255.0 );
		}

		static public function ColorTransformFromRGB( rgb:uint ):ColorTransform
		{
			return new ColorTransform( Scalar.RedFromColour( rgb )/255.0, Scalar.GreenFromColour( rgb )/255.0, Scalar.BlueFromColour( rgb )/255.0 );
		}

		static public function RadToDeg( radians:Number ):Number
		{
			return ( radians/Math.PI )*180;
		}

		static public function Clamp( a:Number, min:Number, max:Number ):Number
		{
			a = Math.max( min, a );
			a = Math.min( max, a );
			return a;
		}

		static public function Sign( a:Number ):Number
		{
			return a>=0 ? 1 : -1;
		}
		
		public static function toPercent(current:Number, total:Number):Number
		{
			return (current / total) * 100;
		}

		public static function fromPercent(percent:Number, total:Number):Number
		{
			return (percent * total) / 100;
		}
	}
}
