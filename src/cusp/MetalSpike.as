package cusp
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import gamemenu.GameSave;
	import geometry.AABB;
	import graphics.Animation;
	import maths.Vector2D;
	import physics.PhysicsObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class MetalSpike extends PhysicsObject
	{
		public var frame:int = 0;
		private var _animSpike:Animation;
		
		public function MetalSpike()
		{
			//_halfSize = new Vector2D(Constants.TILE_HALF_SIZE * .5, Constants.TILE_HALF_SIZE * .8);
			_halfSize = new Vector2D(Constants.TILE_HALF_SIZE * .5, Constants.TILE_HALF_SIZE * .8);
			
			_animSpike = new Animation();
			_animSpike.addAnim("Spike_mc", "spike");
		}

		public override function free():void
		{
			_gameMap.cacheMetalSpike.set(this);
			_gameMap.spikes.remove(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_animSpike.index = frame;
			if (_gameMap.isPhysicsObject)
			{
				drawBox(-_halfSize.x, -_halfSize.y, _halfSize.x, _halfSize.y,0xFF0000);
			}
			_gameMap.spikes.add(this);
			super.init(p);
		}
		
		public override function update(delta:Number):void
		{
			if (!_gameMap.knight.isHurt && !_gameMap.knight.isDead)
			{
				var collided:Boolean = AABB.overlap(_gameMap.knight, this);
				if (collided)
				{
					_gameMap.knight.hurt(this.pos);
					if(GameSave.ifFilled(GameSave.SPIKES) && GameSave.inRange(GameSave.PILLOW))GameSave.setAward(GameSave.PILLOW);
					if(GameSave.inRange(GameSave.SPIKES))GameSave.setAward(GameSave.SPIKES);
				}
			}
			//super.update( delta );
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			var vector:Vector2D = _pos.add(_gameMap.pos);
			_animSpike.render(bitmapData, _gameMap.cacheV2D.allocateV2D(vector));
		}
	
	}

}