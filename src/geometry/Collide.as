package geometry
{
	import system.*;
	import maths.*;
	import geometry.*;
	import levels.*;
	
	public class Collide
	{
		/// <summary>
		/// Helper function which checks for internal edges
		/// </summary>	
		static private function IsInternalCollision( tileI:int, tileJ:int, normal:Vector2D, map:LevelBase ):Boolean
		{
			var nextTileI:int = tileI+normal.x;
			var nextTileJ:int = tileJ+normal.y;
			
			var currentTile:uint = map.GetTile( tileI, tileJ );
			var nextTile:uint = map.GetTile( nextTileI, nextTileJ );
			
			var internalEdge:Boolean = LevelBase.IsTileObstacle(nextTile);
						
			return internalEdge;
		}
		
		/// <summary>
		/// 
		/// </summary>
		static public function AabbVsAabb( a:IAABB, b:IAABB, outContact:Contact, tileI:int, tileJ:int, map:LevelBase, checkInternal:Boolean=true ):Boolean
		{
			
			var combinedExtentsB:Vector2D = b.halfSize.add(a.halfSize);
			var combinedPosB:Vector2D = b.center;
			
			var delta:Vector2D = combinedPosB.sub(a.center);
				//trace(combinedExtentsB, delta);
			
			//AabbVsAabbInternal( delta, combinedPosB, combinedExtentsB, a.m_Centre, outContact );
			
			var planeN:Vector2D = delta.axis.reverseTo();	
			//trace(planeN);
			var planeCentre:Vector2D = planeN.mul( combinedExtentsB ).addTo(combinedPosB);
			
			var planeDelta:Vector2D = a.center.sub( planeCentre );
			var dist:Number = planeDelta.dot( planeN );

			outContact.Initialise( planeN, dist, a.center );
			//trace(planeN,dist,a.center);
			
			//
			// check for internal edges
			//
			
			if ( checkInternal )
			{
				return !IsInternalCollision( tileI, tileJ, planeN, map );
			}
			else 
			{
				return true;
			}
		}
	
	}
}
