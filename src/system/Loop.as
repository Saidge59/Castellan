package system
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class Loop extends Sprite 
	{
		private const MAX_DELTA:Number = 0.03;
			
		private var _isUsed:Boolean;
		private var _deltaTime:Number = 0;
		private var _lastTick:int = 0;
		
		public function Loop()
		{
			_isUsed = false;
			//start();
		}
		
		//private function enterFrameHandler(e:Event):void
		//{
			//_deltaTime = (getTimer() - _lastTick) * .001;
			//if (_deltaTime > MAX_DELTA)_deltaTime = MAX_DELTA;
			//
			//update(_deltaTime);
			//_lastTick = getTimer();
		//}
		private function enterFrameHandler(e:Event):void
		{
			var currentTime:int = getTimer();
			_deltaTime = currentTime - _lastTick;
			_lastTick = currentTime;
			
			var secondsElapsed:Number = _deltaTime / 1000.0;
			
			update(secondsElapsed);
		}
		
		protected function update(delta:Number):void
		{
			//...
		}
		
		public function start():void
		{
			if (!_isUsed)
			{
				_isUsed = true;
				_lastTick = getTimer();
				this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			}
		}
		
		public function stop():void
		{
			if (_isUsed)
			{
				_isUsed = false;
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		
	}
	
}