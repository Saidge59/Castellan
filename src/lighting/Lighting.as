package lighting 
{
	import controller.PropertiesController;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import gamemenu.GameScreen;
	import geometry.*;
	import maths.Vector2D;
	import physics.PhysicsObject;
	import system.IGameObjects;
	import flash.geom.Point;
	import graphics.Animation;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Lighting extends PhysicsObject
	{		
		protected var _isIncluded:Boolean;
		protected var _isDisparity:Boolean;
		protected var _animation:Animation;
		protected var _animLighting:Animation;
		protected var _animFire:Animation;
		protected var _disparity:Animation;
		protected var _colorTorch:int;
		protected var _colorFire:int;
		protected var _renderMin:Vector2D;
		protected var _renderMax:Vector2D;
		protected var _prpCntr:PropertiesController;
		
		public function Lighting() 
		{
			_animLighting = new Animation();
			_animFire = new Animation();
			_disparity = new Animation();
		}
		
		public override function free():void
		{
			_gameMap.lightings.remove(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_gameMap.lightings.add(this);
			super.init(p);
		}
		
		public override function update(delta:Number):void
		{
			//...
		}

		public override function render(bitmapData:BitmapData):void
		{
			if (!_gameMap.camera.onScreenParam(_pos, _renderMin, _renderMax)) return;
		}

	// ===========
	//  GET / SET
	// ===========

		public function get isIncluded():Boolean
		{
			return _isIncluded;
		}
		
		public function set isIncluded(value:Boolean):void
		{
			_isIncluded = value;
		}
		
		public function set colorTorch(color:int):void
		{
			_colorTorch = color;
		}
		
		public function set colorFire(color:int):void
		{
			//...
		}
		
		public function set pc(prpC:PropertiesController):void
		{
			_prpCntr = prpC;
		}
		
	}

}