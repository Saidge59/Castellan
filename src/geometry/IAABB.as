package geometry
{
	import maths.Vector2D;
	
	public interface IAABB
	{
		function get center( ):Vector2D;
		function get halfSize( ):Vector2D;
	}
}
