package system
{
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
	public class SoundManager
	{
		public static const MAX_SOUND_CHANNELS:int = 8;
		public static const ELAPSED:Number = 0.02;
		public static var listener:PhysicsObject;
		
		private static var _instance:SoundManager;
		private static var _allowInstance:Boolean;
		private var _sounds:Array;
		private var _musics:Array;
		private var _source:Array;
		private var _soundsSFX:Array;
		private var _soundTransform:SoundTransform;
		private var _timerVolFader:Timer;
		private var _fadeChannel:SoundChannel;
		private var _fadeOutTimer:Number;
		private var _fadeInTimer:Number;
		private var _pauseOnFadeOut:Boolean;
		private var _currMusicName:String;
		private var _radius:int = 312;
		
		public static function getInstance():SoundManager
		{
			if (_instance == null)
			{
				_allowInstance = true;
				_instance = new SoundManager();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public function SoundManager()
		{
			if (!_allowInstance)
			{
				throw new Error("Error: Use SoundManager.getInstance() instead of the new keyword.");
			}
			_sounds = new Array();
			_musics = new Array();
			_source = new Array();
			_soundsSFX = new Array();
			_soundTransform = new SoundTransform();
			_timerVolFader = new Timer(10);
			_fadeOutTimer = 0;
			_fadeInTimer = 0;
		}
		
		public function addLibrarySound(linkageID:*, name:String):void
		{
			for (var i:int = 0; i < _sounds.length; i++)
			{
				if (_sounds[i].name == name) return;
			}
			
			//_sounds.push(embedObject(linkageID, name));
			//_sounds[name] = new linkageID;
			_soundsSFX[name] = new linkageID;
		}
		
		public function addLibraryMusic(linkageID:*, name:String):void
		{
			for (var i:int = 0; i < _musics.length; i++)
			{
				if (_musics[i].name == name) return;
			}
			
			_musics[name] = embedObject(linkageID, name);
		}
		
		private function embedObject(song:*, name:String):Object
		{
			var snd:Sound = new song;
			var sndObj:Object = new Object();
				sndObj.name = name;
				sndObj.sound = snd;
				sndObj.played = false;
				sndObj.channel = null;
				sndObj.position = 0;
				sndObj.paused = true;
				sndObj.volume = 1;
				sndObj.startTime = 0;
				sndObj.loops = 1;
				sndObj.pausedByAll = false;
			return sndObj;
		}
		
		public function playSound(name:String, object:* = null, repeats:int = 1):void
		{
			var snd:Object = new Object();
			if (object == null)
			{
				_soundTransform.volume = 1;
				_soundTransform.pan = 0;
			}
			else
			{
				snd.object = object;
				snd.pos = object.pos;
				_source.push(snd);
			}
			snd.channel = _soundsSFX[name].play(0, repeats, _soundTransform);
			snd.channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
		}
		public function stopSound(name:String, object:*):void
		{
			var snd:Object;
			for (var i:int = 0; i < _source.length; i++)
			{
				snd = _source[i];
				if (snd.object == object)break;
			}
				
				snd.channel.stop();
				snd.position = snd.channel.position;
			var idx:int = _source.indexOf(snd);
			_source.splice(idx, 1);
		}
		
		public function playSFX(name:String, volume:Number = 1):void
		{
			var snd:Object;
			for (var i:int = 0; i < _sounds.length; i++)
			{
				snd = _sounds[i];
				if (snd.name == name)break;
			}

			//if (snd.played) return;
				snd.volume = volume;
				snd.channel = snd.sound.play(snd.position, 1);
				//snd.played = true;
				snd.channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
		}
		
		public function playLooping(name:String, sprite:*, repeats:int = 1):void
		{
			var snd:Object;
			for (var i:int = 0; i < _sounds.length; i++)
			{
				snd = _sounds[i];
				if (snd.name == name)break;
			}
			//if (snd.played) return;
			snd.channel = snd.sound.play(snd.position, repeats);
			snd.sprite = sprite;
			snd.channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			_source.push(snd);
				//snd.played = true;
		}

		private function soundCompleteHandler(e:Event):void
		{
			//var soundIndex:int = sounds.indexOf(e.target);
				//sounds[soundIndex].status = false;
			//_source.slice(0, 1);
  
			var channel:SoundChannel = e.currentTarget as SoundChannel;
				channel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				channel.stop();
				channel = null;
		}
		
		public function stopLooping(name:String, sprite:*):void
		{
			var snd:Object;
			for (var i:int = 0; i < _sounds.length; i++)
			{
				snd = _sounds[i];
				if (snd.name == name)break;
			}
			//if (!snd.played) return;
				snd.channel.stop();
				snd.position = snd.channel.position;
				snd.sprite = null;
			var idx:int = _source.indexOf(snd);
			_source.splice(idx, 1);
		}
		
		public function playMusic(name:String, startTime:Number = 0):void
		{
			var snd:Object = _musics[name];
			if (snd.played) return;
				snd.startTime = startTime;
			var startPlay:Number = (snd.paused) ? snd.position : startTime;
				_soundTransform.volume = 0;
				_fadeChannel = snd.channel = snd.sound.play(startPlay, 999, _soundTransform);
				snd.paused = false;
				snd.played = true;
				_currMusicName = name;
		}
		
		private function timerVolFaderHandler(e:TimerEvent):void
		{
			if (_fadeOutTimer > 0)
			{
				_fadeOutTimer -= ELAPSED;
				if (_fadeOutTimer <= 0)
				{
					_soundTransform.volume = 0;
					removeTimer();
					if (_pauseOnFadeOut) pauseMusic(_currMusicName);
					else stopMusic(_currMusicName);
				}
				_soundTransform.volume = _fadeOutTimer;
			}
			else if(_fadeInTimer < 1)
			{
				_fadeInTimer += ELAPSED;
				
				if (_fadeInTimer >= 1)
				{
					_soundTransform.volume = 1;
					removeTimer();
				}			
				_soundTransform.volume = _fadeInTimer;
			}
			//_fadeChannel.soundTransform = _soundTransform;
		}
		
		public function fadeOut(aOnPause:Boolean = false):void
		{
			_pauseOnFadeOut = aOnPause;
			_fadeInTimer = 1;
			_fadeOutTimer = 1;
			
			addTimer();
		}

		public function fadeIn(name:String):void
		{
			var snd:Object = _musics[name];
			if (snd.played) return;
			playMusic(name);
			
			_fadeOutTimer = 0;
			_fadeInTimer = 0;
			
			addTimer();
		}
		
		private function addTimer():void
		{
			if(!_timerVolFader.running)
			{
				_timerVolFader.addEventListener(TimerEvent.TIMER, timerVolFaderHandler, false, 0, true);
				_timerVolFader.start();
			}
		}
		
		private function removeTimer():void
		{
			_timerVolFader.removeEventListener(TimerEvent.TIMER, timerVolFaderHandler);
			_timerVolFader.stop();
		}
		
		public function pauseMusic(name:String):void
		{
			var snd:Object = _musics[name];
			snd.paused = true;
			snd.played = false;
			snd.position = snd.channel.position;
			snd.channel.stop();
			trace(snd.position, snd.channel.position);
		}
		
		public function stopMusic(name:String):void
		{
			var snd:Object = _musics[name];
			
			if ( snd )
			{
				snd.paused = true;
				snd.played = false;
				snd.channel.stop();
				snd.position = snd.channel.position;
			}
		}
		
		public function updateSoundSource(name:String, source:PhysicsObject):void
		{
			var snd:Object;
			for (var i:int = 0; i < _sounds.length; i++)
			{
				snd = _sounds[i];
				if (snd.name == name)break;
			}
			
			trace(source.pos);
			
			var radial:Number;
			var pan:Number;
			radial = listener.pos.lenght(source.pos) / _radius;
			radial = 1 - Scalar.Clamp(radial, 0, 1);
					
			pan = (source.pos.x - listener.pos.x) / _radius;
			pan = Scalar.Clamp(pan, -.5, .5);
			_soundTransform.volume = radial;
			_soundTransform.pan = pan;
			snd.channel.soundTransform = _soundTransform;
		}
		
		public function updateTransform():void
		{
			if (_source.length < 1) return;
			if (listener == null) return;
			var radial:Number;
			var pan:Number;
			var n:int = _source.length;
			var source:Object;

			for (var i:int = 0; i < n; i++)
			{
				source = _source[i] as Object;
				if (source != null)
				{
					radial = listener.pos.lenght(source.pos) / _radius;
					radial = 1 - Scalar.Clamp(radial, 0, 1);
					
					pan = (source.pos.x - listener.pos.x) / _radius;
					pan = Scalar.Clamp(pan, -1, 1);
					
					_soundTransform.volume = radial;
					_soundTransform.pan = pan;
					source.channel.soundTransform = _soundTransform;
				}
			}
			
		}
		
	}
}