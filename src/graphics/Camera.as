package graphics
{
	import geometry.*;
	import maths.*;
	import flash.display.Sprite;
	import flash.geom.*;
	import flash.events.MouseEvent;
	import physics.PhysicsObject;
	
	public class Camera
	{
		static public const kInitialZoom:Number = 1;
		static private const kMinScale:Number = 1;
		static private const kMaxScale:Number = 1;
		
		private var _gameMap:GameMap;
		private var _parent:Sprite;
		private var _character:PhysicsObject;
		private var _scale:Vector2D;
		private var _translate:Vector2D;
		private var _worldToScreen:Matrix;
		private var _screenToWorld:Matrix;
		
		private var _screenSpaceAABB:AABB;		
		private var _cameraPos:Vector2D;

		
		/// <summary>
		/// 
		/// </summary>	
		public function Camera()
		{
			_gameMap = GameMap.getInstance();
			_worldToScreen = new Matrix();
			_screenSpaceAABB = new AABB();
		}
		
		public function init(parent:Sprite, character:PhysicsObject):void
		{
			_parent = parent;
			_character = character;
			_scale = _gameMap.cacheV2D.allocate(kInitialZoom, kInitialZoom);
			
			
			var screenCentre:Vector2D = _gameMap.cacheV2D.allocate( Constants.SCREEN_HALF_SIZE.x, Constants.SCREEN_HALF_SIZE.y );
			_screenSpaceAABB.init(screenCentre, screenCentre);
				
			if (_character == null) return;
			_cameraPos = _character.pos.clone();
			update(0.03);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function update( delta:Number ) : void
		{
			_worldToScreen.identity();
			
			var translate:Vector2D = _character.pos.reverse;

			var screenHalfExtents:Vector2D = _gameMap.cacheV2D.allocate( Constants.SCREEN_HALF_SIZE.x/_scale.x, Constants.SCREEN_HALF_SIZE.y/_scale.y );

			var topLeft:Vector2D = _gameMap.cacheV2D.allocateV2D(_character.pos).subFrom(screenHalfExtents);
			var bottomRight:Vector2D = _gameMap.cacheV2D.allocateV2D(_character.pos).addTo(screenHalfExtents);

			var correctLeft:Number = Math.min(topLeft.x, 0);
			var correctTop:Number = Math.min(topLeft.y, 0);

			var correctRight:Number = Math.min(Constants.WORLD_SIZE.x - bottomRight.x, 0);
			var correctBottom:Number = Math.min(Constants.WORLD_SIZE.y - bottomRight.y, 0);

			translate.x += correctLeft - correctRight;
			translate.y += correctTop - correctBottom;
			
			_cameraPos = translate.reverse;
						
			_worldToScreen.translate( translate.x, translate.y );
			_worldToScreen.scale( _scale.x, _scale.y );
			_worldToScreen.translate( Constants.SCREEN_HALF_SIZE.x, Constants.SCREEN_HALF_SIZE.y );
			
			// this is essential to stop cracks appearing between tiles as we scroll around - because cacheToBitmap means
			// sprites can only be positioned on whole pixel boundaries, sub-pixel camera movements cause gaps to appear.
			_worldToScreen.tx = Math.floor( _worldToScreen.tx+0.5 );
			_worldToScreen.ty = Math.floor( _worldToScreen.ty+0.5 );
			
			_parent.transform.matrix = _worldToScreen;
			
			// for screen->world matrix
			_screenToWorld = _worldToScreen.clone();
			_screenToWorld.invert();
		}
		
		/*
		/// <summary>
		/// 
		/// </summary>	
		public function ScreenToWorldPos( e:MouseEvent ):Vector2D
		{
			return Vector2D.FromPoint( _screenToWorld.transformPoint( new Vector2(e.stageX, e.stageY).m_Point ) );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function ScreenToWorldPosV( v:Vector2D ):Vector2D
		{
			return Vector2D.FromPoint( _screenToWorld.transformPoint( v.m_Point ) );
		}*/
	
		public function worldToScreenPos( worldPos:Vector2D ):Vector2D
		{
			return Vector2D.fromPoint( _worldToScreen.transformPoint( worldPos.newPoint ) );
		}

		public function onScreen( worldPos:Vector2D ):Boolean
		{
			var screenPos:Vector2D = worldToScreenPos(worldPos);
			
			return screenPos.x >= 0 && screenPos.x < Constants.SCREEN_SIZE.x &&
				   screenPos.y >= 0 && screenPos.y < Constants.SCREEN_SIZE.y;
		}
		
		public function onScreenParam( worldPos:Vector2D, min:Vector2D, max:Vector2D ):Boolean
		{
			var screenPos:Vector2D = worldToScreenPos(worldPos);
			//trace(screenPos, min, max, screenPos.x >= min.x);
			return screenPos.x >= min.x && screenPos.x < max.x &&
					screenPos.y>= min.y &&screenPos.y<	max.y;
		}
		
		/*
		public function OnScreenAABB( aabb:IAABB ):Boolean
		{
			var screenSpaceCentre:Vector2D = WorldToScreenPos( aabb.center );
			var screenSpaceAABB:AABB = new AABB( screenSpaceCentre, aabb.m_HalfExtents );
			
			return AABB.Overlap( _screenSpaceAABB, screenSpaceAABB );
		}
		*/
		
		public function getWorldSpaceOnScreenAABB( outAabb:AABB ):void
		{
			outAabb.updateFrom( _cameraPos, _screenSpaceAABB.halfSize.div( _scale ) );
		}
		
		/*
		/// <summary>
		/// 
		/// </summary>
		public function GetWorldSpaceVisibleHalfExtents( ):Vector2D
		{
			return _screenSpaceAABB.m_HalfExtents.Div( _scale );
		}
		
		
		/// <summary>
		/// 
		/// </summary>	
		public function set m_Scale(scale:Number):void
		{
			var oldScale:Number = _scale.m_x;
			
			scale = Scalar.Clamp( scale, kMinScale, kMaxScale );
			
			_scale.m_x = scale;
			_scale.m_y = scale;
		}
		*/
		
		public function get topLeft():Vector2D
		{
			return _cameraPos.sub(_screenSpaceAABB.halfSize);
		}
		

		public function get scale( ):Number
		{
			return _scale.x;
		}
		
		public function get cameraPos( ):Vector2D
		{
			return _cameraPos;
		}
		
		public function set setTarget( target:PhysicsObject ):void
		{
			_character = target;
		}
		
	}
}
