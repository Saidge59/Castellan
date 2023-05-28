package geometry
{
	import maths.Vector2D;

	public class Contact
	{
		public var normal:Vector2D;
		public var dist:Number;
		public var impulse:Number;
		public var p:Vector2D;
		
		public function Initialise( n:Vector2D, dist:Number, p:Vector2D ):void
		{
			this.normal = n;
			this.dist = dist;
			this.impulse = 0;
			this.p = p;
		}
		
	}
}
