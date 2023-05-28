package system
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import maths.Scalar;
	import maths.Vector2D;
	import physics.PhysicsObject;
	
	/**
	 * ...
	 * @author falcon24
	 */
	public class MySound
	{
		public var object:PhysicsObject;
		public var completeCallBack:Function;
		
		private var _soundManager:SoundManager;
		private var _name:String;
		private var _sound:Sound;
		private var _repeats:int;
		private var _position:Number;
		private var _soundTransform:SoundTransform;
		private var _played:Boolean;
		private var _musicRepeats:Boolean;
		private var _channel:SoundChannel;
		private var _paused:Boolean;
		private var _volume:Number;
		private var _startTime:Number;
		private var _pan:Number;
		
		public function MySound()
		{
			_soundTransform = new SoundTransform();
		}
		
		public function init():void
		{
			_soundManager = SoundManager.getInstance();
			_played = false;
			_channel = null;
			_position = 0;
			_paused = false;
			_volume = 1;
			_startTime = 0;
			_pan = 0;
			_musicRepeats = false;
		}
		
		public function play(name:String, sound:Sound, repeats:int, mute:Boolean = false):void
		{
			if (mute)_soundTransform.volume = 0
			else _soundTransform.volume = _volume;
			//trace(name, _volume);
			_name = name;
			_sound = sound;
			_repeats = repeats;
			_channel = _sound.play(_position, _repeats, _soundTransform);
			_channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			_played = true;
		}
		
		public function stop():void
		{
			if (_channel != null)
			{
				_channel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				_channel.stop();
			}
			_position = 0;
			_channel = null;
			_played = false;
			_paused = false;
		}
		
		public function paused():void
		{
			if (_paused) return;
			_paused = true;
			_channel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			_position = _channel.position;
			_channel.stop();
		}
		public function resume():void
		{
			if (!_paused) return;
			_paused = false;
			_musicRepeats = true;
			play(_name, _sound, 1);
		}
		
		private function soundCompleteHandler(e:Event):void
		{
			_soundManager.stopSound(object);
			if (_musicRepeats)
			{
				_position = 0;
				_musicRepeats = false;
				play(_name, _sound, 999);
			}
		}
		
		public function transform(vol:Number, pan:Number):void
		{
			_soundTransform.volume = vol;
			_soundTransform.pan = pan;
			if (_channel != null)
			{
				_channel.soundTransform = _soundTransform;
			}
		}
		
		public function get volumeTransform():Number
		{
			return _soundTransform.volume;
		}
		
		public function set volumeTransform(value:Number):void
		{
			_soundTransform.volume = value;
			if (_channel != null)
			{
				_channel.soundTransform = _soundTransform;
			}
		}
		
		//public function fadeIn(volume:Number = 1, timeFade:Number = 1):void
		//{
			//if (_played) return;
			//_fadeOutTimer = 0;
			//_fadeInTimer = 0;
			//_fadeInTotalTimer = volume;
			//
			//addTimer();
		//}
		
		public function get nameSound():String
		{
			return _name;
		}
		
		public function get isPlayed():Boolean
		{
			return _played;
		}
		public function get volume():Number
		{
			return _volume;
		}
		public function set volume(value:Number):void
		{
			_volume = value;
		}
		public function get isPaused():Boolean
		{
			return _paused;
		}
		public function set isPaused(value:Boolean):void
		{
			_paused = value;
		}
	}
}