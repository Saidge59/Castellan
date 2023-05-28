package system
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public class Keyboard
	{
		private const KEY_CODE:int = 255;
		
		private var _state:Vector.<Boolean>;
		private var _liveState:Vector.<Boolean>;
		private var _lastState:Vector.<Boolean>;
			
		public function Keyboard( stage:Stage )
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler, false, 0, true );
			stage.addEventListener( KeyboardEvent.KEY_UP, keyUpHandler, false, 0, true );
			
			_state = new Vector.<Boolean>( KEY_CODE );
			_liveState = new Vector.<Boolean>( KEY_CODE );
			_lastState = new Vector.<Boolean>( KEY_CODE );
			
			var i:int = KEY_CODE;
			while(--i>-1)
			{
				_state[i] = false;
				_lastState[i] = false;
				_liveState[i] = false;
			}
		}

		public function update( ):void
		{
			var i:int = KEY_CODE;
			while(--i>-1)
			{
				_lastState[i] = _state[i];
				_state[i] = _liveState[i];
			}
		}

		private function keyDownHandler( e:KeyboardEvent ):void
		{
			_liveState[e.keyCode] = true;
		}
			
		private function keyUpHandler( e:KeyboardEvent ):void
		{
			_liveState[e.keyCode] = false;
		}
	
		public function isKeyDown( key:int ):Boolean
		{
			return _state[key];
		}
		
		// Против залипания клавиши!
		public function isKeyDownTransition( key:int ):Boolean
		{
			return !_lastState[key] && _state[key];
		}
		
		public function resetAllPressedKey():void
		{
			var i:int = KEY_CODE;
			while(--i>-1)
			{
				_liveState[i] = false;
				_lastState[i] = false;
				_state[i] = false;
			}
		}
	}
}
