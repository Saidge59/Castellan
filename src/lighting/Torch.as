package lighting 
{
	import controller.PropertiesController;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gamemenu.GameSave;
	import geometry.AABB;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Torch extends Lighting
	{
		public function Torch() 
		{
			//_halfSize = new Vector2D(Constants.TORCH_SIZE.x * .5, Constants.TORCH_SIZE.y * .5);
			//_renderMin = new Vector2D(-Constants.TORCH_SIZE.x, -Constants.TORCH_SIZE.y);
			//_renderMax = new Vector2D(Constants.SCREEN_SIZE.x + Constants.TORCH_SIZE.x, Constants.SCREEN_SIZE.y + Constants.TORCH_SIZE.y);
			
			_animLighting.addAnim("WTorch_deactive_mc", "torch_Deactive");
			_animFire.addAnim("WTorch_orange_mc", "torch_Orange");
			_animFire.addAnim("WTorch_blue_mc", "torch_Blue");
			_animFire.addAnim("WTorch_green_mc", "torch_Green");
			_animFire.addAnim("WTorch_purple_mc", "torch_Purple");
			_disparity.addAnim("Disparity_orange_mc", "orange");
			_disparity.addAnim("Disparity_blue_mc", "blue");
			_disparity.addAnim("Disparity_green_mc", "green");
			_disparity.addAnim("Disparity_purple_mc", "purple");
		}
		
		public override function free():void
		{
			_gameMap.cacheTorch.set(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{		
			_played = false;
			_halfSize = _gameMap.cacheV2D.allocate(Constants.TORCH_SIZE.x * .5, Constants.TORCH_SIZE.x * .5);
			_renderMin = _gameMap.cacheV2D.allocate(-Constants.TORCH_SIZE.x, -Constants.TORCH_SIZE.y);
			_renderMax = _gameMap.cacheV2D.allocate(Constants.SCREEN_SIZE.x + Constants.TORCH_SIZE.x, Constants.SCREEN_SIZE.y + Constants.TORCH_SIZE.y);
			
			_disparity.goToFrame(0);
			_animLighting.switchAnim("torch_Deactive");
			_animLighting.goToFrame(_colorTorch);
			_isDisparity = false;
			chengeFire();
			
			if (_gameMap.isRenderShape)
			{
				// render shape
				drawBox( -_halfSize.x * 2, -_halfSize.y * 2, _halfSize.x * 2 , _halfSize.y * 2, 0x80FFFF); 
			}
			if (_gameMap.isPhysicsObject)
			{
				// touch shape
				drawBox(-_halfSize.x,-_halfSize.y, _halfSize.x ,_halfSize.y,0xFFFF00);
			}

			super.init(p);
		}
		
		public override function update(delta:Number):void
		{
			if (_gameMap.knight.colorFire == Constants.NONE) return;
			if (_gameMap.knight.isDead) return;
			if (!_isIncluded)
			{
				_isIncluded = AABB.overlap(_gameMap.knight.torchAABB, this);
				if (_isIncluded)
				{
					ignationTorch();
				}
			}
			
			if (AABB.overlap(_gameMap.knight.torchAABB, this) && _colorFire != _gameMap.knight.colorFire) 
			{
				ignationTorch();
			}
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			super.render(bitmapData);
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos).addTo(_gameMap.pos);
			_animLighting.render(bitmapData, vector, false);
			
			if (_isIncluded)
			{
				_animFire.render(bitmapData, vector);
			}
			
			if (_isDisparity)
			{
				_disparity.render(bitmapData, vector);
			}
			
		}
		
		private function ignationTorch():void
		{
			if(GameSave.ifFilled(GameSave.IGNITION_75) && GameSave.inRange(GameSave.IGNITION_100))GameSave.setAward(GameSave.IGNITION_100);
			if(GameSave.ifFilled(GameSave.IGNITION_50) && GameSave.inRange(GameSave.IGNITION_75))GameSave.setAward(GameSave.IGNITION_75);
			if(GameSave.inRange(GameSave.IGNITION_50))GameSave.setAward(GameSave.IGNITION_50);
			_soundManager.playSound("Bonfire", this, 1);
			colorFire = _gameMap.knight.colorFire;
			chengeFire();
		}
		
		private function chengeFire():void
		{
			if (!_isIncluded) return;
			_prpCntr.isIncluded = true;
			_prpCntr.colorFire = _colorFire;
			_prpCntr.isDisparity = _colorTorch != _colorFire;
			_gameScreen.updateCount(); // update GameScreen
			switchColorDisparity();
			_isDisparity = _colorTorch != _colorFire;
			if (_isDisparity && !_gameShift.isUsed) _gameScreen.subTime = Constants.SUB_TIME;
			_disparity.goToFrame(0);
		}
		
		private function switchColorDisparity():void
		{
			if (_isDisparity) return;
			switch(_colorTorch)
			{
				case Constants.ORANGE:_disparity.switchAnim("orange");
					break;
				case Constants.BLUE:_disparity.switchAnim("blue");
					break;
				case Constants.GREEN:_disparity.switchAnim("green");
					break;
				case Constants.PURPLE:_disparity.switchAnim("purple");
					break;
			}
		}
		
		public override function set colorFire(color:int):void
		{
			_colorFire = color;
			switch(color)
			{
				case Constants.ORANGE:_animFire.switchAnim("torch_Orange");
					break;
				case Constants.BLUE:_animFire.switchAnim("torch_Blue");
					break;
				case Constants.GREEN:_animFire.switchAnim("torch_Green");
					break;
				case Constants.PURPLE:_animFire.switchAnim("torch_Purple");
					break;
				case Constants.NONE://trace("none_fire");
					break;
			}
		}
		
	}

}