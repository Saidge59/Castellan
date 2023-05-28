package lighting 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import geometry.AABB;
	import geometry.IAABB;
	import graphics.Animation;
	import maths.Vector2D;
	import system.IGameObjects;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Cauldron  extends Lighting
	{		
		public function Cauldron() 
		{
			_animLighting.addAnim("Cauldron_orange_mc", "orange");
			_animLighting.addAnim("Cauldron_blue_mc", "blue");
			_animLighting.addAnim("Cauldron_green_mc", "green");
			_animLighting.addAnim("Cauldron_purple_mc", "purple");
		}
		
		public override function free():void
		{
			_gameMap.cacheCauldron.set(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_halfSize = _gameMap.cacheV2D.allocate(Constants.CAULDRON_SIZE.x * .5, Constants.CAULDRON_SIZE.y * .5);
			_renderMin = _gameMap.cacheV2D.allocate(-Constants.CAULDRON_SIZE.x, -Constants.CAULDRON_SIZE.y);
			_renderMax = _gameMap.cacheV2D.allocate(Constants.SCREEN_SIZE.x + Constants.CAULDRON_SIZE.x, Constants.SCREEN_SIZE.y + Constants.CAULDRON_SIZE.y);
			super.init(p);
			
			if (_gameMap.isRenderShape)
			{
				// render shape
				//drawBox( -_halfSize.x * 2, -_halfSize.y * 2, _halfSize.x * 2 , _halfSize.y * 1.5, 0xFF9900); 
				drawBox( -Constants.CAULDRON_SIZE.x, -Constants.CAULDRON_SIZE.y * 1.4, Constants.CAULDRON_SIZE.x, Constants.CAULDRON_SIZE.y, 0x80FFFF);
			}
			if (_gameMap.isPhysicsObject)
			{
				// touch shape
				drawBox(-_halfSize.x,-_halfSize.y, _halfSize.x ,_halfSize.y,0x559988);
			}
		}
		
		public override function update(delta:Number):void
		{
			if (_gameShift.isUsed) return;
			if (_soundManager.fieldOfHearing(_pos)) 
			{
				if (!_soundManager.soundPlayed(this))
				{
					_soundManager.playSound("BarrelFire", this, 999);
				}
			}
			else
			{
				if (_soundManager.soundPlayed(this))
				{
					_soundManager.stopSound(this);
				}
			}
			var contact:Boolean = AABB.overlap(_gameMap.knight, this);
			if (contact && _gameMap.knight.isDown && _gameMap.knight.colorFire != _colorFire)
			{
				_gameMap.knight.colorFire = _colorFire;
				_soundManager.playSound("Bonfire", this, 1);
			}
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			super.render(bitmapData);
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos).addTo(_gameMap.pos);
			_animLighting.render(bitmapData, vector);
		}
		
		public override function set colorFire(color:int):void
		{
			_colorFire = color;
			switch(color)
			{
				case Constants.ORANGE:_animLighting.switchAnim("orange");
					break;
				case Constants.BLUE:_animLighting.switchAnim("blue");
					break;
				case Constants.GREEN:_animLighting.switchAnim("green");
					break;
				case Constants.PURPLE:_animLighting.switchAnim("purple");
					break;
			}
		}
		
	}

}