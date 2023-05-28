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
		public static const TIMER_DALAY:int = 10;
		public static const ELAPSED:Number = 0.05;
		public static var listener:PhysicsObject;
		
		private static var _instance:SoundManager;
		private static var _allowInstance:Boolean;
		private var _cacheMySound:SimpleCache;
		private var _source:Array;
		private var _musicsList:Array;
		private var _soundsList:Array;
		private var _soundTransform:SoundTransform;
		private var _timerVolFader:Timer;
		private var _fadeChannel:SoundChannel;
		private var _numberOfPasses:Number;
		private var _timeElapsed:Number;
		private var _currentVolume:Number;
		
		private var _fadeOutTimer:Number;
		private var _fadeInTimer:Number;
		private var _fadeOutTotalTimer:Number;
		private var _fadeInTotalTimer:Number;
		private var _pauseOnFadeOut:Boolean;
		private var _afterCount:Boolean;
		private var _muteSound:Boolean;
		private var _muteMusic:Boolean;
		private var _currentMusic:MySound;
		private var _radius:int = 360;
		
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
			_cacheMySound = new SimpleCache(MySound, 15);
			_musicsList = new Array();
			_source = new Array();
			_soundsList = new Array();
			_soundTransform = new SoundTransform();
			_timerVolFader = new Timer(SoundManager.TIMER_DALAY);
			_numberOfPasses = 0;
			_timeElapsed = 0;
			_currentVolume = 0;
			_fadeOutTimer = 0;
			_fadeInTimer = 0;
			_fadeInTotalTimer = 0;
			_fadeOutTotalTimer = 0;
			_muteSound = false;
			_muteMusic = false;
			_afterCount = false;
		}
		
		public function addLibrarySound(linkageID:*, name:String):void
		{
			_soundsList[name] = new linkageID;
		}
		
		public function addLibraryMusic(linkageID:*, name:String):void
		{
			_musicsList[name] = new linkageID;
		}
		
		// Sound metod BEGIN ==================== ***
		public function playSound(name:String, object:PhysicsObject = null, repeats:int = 1, volume:Number = 1):void
		{
			if (_source.length >= MAX_SOUND_CHANNELS)
			{
				overflowChannels();
			}
			
			var mySnd:MySound = _cacheMySound.get as MySound;
				mySnd.init();
				mySnd.object = object;
				mySnd.volume = volume;
				mySnd.play(name, _soundsList[name], repeats, _muteSound);
			_source.push(mySnd);
		}
		public function stopSound(object:PhysicsObject):void
		{
			var mySnd:MySound;
			var idx:int = 0;
			var n:int = _source.length;
			for (var i:int = 0; i < n; i++)
			{
				mySnd = _source[i];
				if (mySnd == null) return;
				if (mySnd.object == object)
				{
					mySnd.stop();
					_cacheMySound.set(mySnd);
					idx = _source.indexOf(mySnd);
					_source.splice(idx, 1);
					break;
				}
			}
		}		
		public function stopAllSound():void
		{
			var mySnd:MySound;
			var idx:int = 0;
			while (_source.length > 0)
			{
				mySnd = _source[0];
				mySnd.stop();
				_cacheMySound.set(mySnd);
				idx = _source.indexOf(mySnd);
				_source.splice(idx, 1);
			}
		}		
		public function overflowChannels():void
		{
			var mySnd:MySound;
			var n:int = _source.length;
			for (var i:int = 0; i < n; i++)
			{
				mySnd = _source[i];
				//if (mySnd.name == "fireCauldron" || mySnd.name == "playerRun" || mySnd.name == "helmetRun") continue;
				if (mySnd != null)
				{
					if (mySnd.nameSound != "BarrelFire" || mySnd.nameSound != "CageUp" || mySnd.nameSound != "HelmetSleep" || mySnd.nameSound != "HeroWin" || mySnd.nameSound != "HeroDead")
					{
						stopSound(mySnd.object);
					}
				}
			}
		}		
		public function fieldOfHearing(pos:Vector2D):Boolean
		{
			var dist:Number = listener.pos.lenght(pos) / _radius;
			return dist <= 1;
		}		
		public function soundPlayed(object:PhysicsObject):Boolean
		{
			var mySnd:MySound;
			var played:Boolean = false;
			var n:int = _source.length;
			for (var i:int = 0; i < n; i++)
			{
				mySnd = _source[i];
				if (mySnd.object == object) 
				{
					played = mySnd.isPlayed;
					break;
				}
			}
			return played;
		}		
		public function stopAndNewSoundPlay(newSound:String, object:PhysicsObject, repeats:int = 1):void
		{
			var mySnd:MySound;
			var n:int = _source.length;
			for (var i:int = 0; i < n; i++)
			{
				mySnd = _source[i];
				if (mySnd.object == object) 
				{
					stopSound(mySnd.object);
					playSound(newSound, object, repeats);
					break;
				}
			}
		}		
		public function muteSound():void
		{
			_muteSound = !_muteSound;
			if (_muteSound) muteAllSounds();
			//else unmuteAllSounds();
		}		
		public function muteAllSounds():void
		{
			var mySnd:MySound;
			var n:int = _source.length;
			for (var i:int = 0; i < n; i++)
			{
				mySnd = _source[i];
				mySnd.volumeTransform = 0;
			}
		}		
		public function unmuteAllSounds():void
		{
			var mySnd:MySound;
			var n:int = _source.length;
			for (var i:int = 0; i < n; i++)
			{
				mySnd = _source[i];
				mySnd.volumeTransform = mySnd.volume;
			}
		}		
		public function get getMuteSound():Boolean
		{
			return _muteSound;
		}
		// Sound metod END ====================== ***
		
		// Music metod BEGIN ==================== ***
		public function playMusic(name:String, fade:Boolean = false, repeats:int = 999, volume:Number = 1):void
		{
			if (_currentMusic != null)
			{
				if (_currentMusic.isPlayed || _currentMusic.isPaused) return;
			}
			var mySnd:MySound = _cacheMySound.get as MySound;
				_currentMusic = mySnd;
				mySnd.init();
				mySnd.volume = volume;
				mySnd.play(name, _musicsList[name], repeats, _muteMusic);
		}
		
		public function stopMusic():void
		{
			if (_currentMusic == null) return;
			if (_currentMusic.isPlayed)
			{
				_currentMusic.stop();
				_currentMusic = null;
			}
		}
		
		public function muteMusic():void
		{
			_muteMusic = !_muteMusic;
			if (_muteMusic) _currentMusic.volumeTransform = 0;
			else _currentMusic.volumeTransform = _currentMusic.volume;
		}
		
		public function pause():void
		{
			if (_muteMusic) return;
			if (_currentMusic == null) return;
			_currentMusic.paused();
		}
		
		public function resume():void
		{
			if (_muteMusic) return;
			if (_currentMusic == null) return;
			_currentMusic.resume();
		}

		//public function pauseMusic():void
		//{
			//_currentMusic.position = _currentMusic.channel.position;
			//_currentMusic.channel.stop();
			//_currentMusic.played = false;
		//}
		
		//public function set musicName(name:String):void
		//{
			//_currentMusic.nameSound = name;
		//}
		
		public function get getMuteMusic():Boolean
		{
			return _muteMusic;
		}
		
		public function get getPauseMusic():Boolean
		{
			return _currentMusic.isPaused;
		}
		
		private function timerVolFaderHandler(e:TimerEvent):void
		{
			//if (!_currentMusic.played)
			if (_currentMusic == null) return;
			if (_muteMusic)
			{
				_numberOfPasses = 0;
				removeTimer();
				//_currentMusic.volumeTransform = 0;
				return;
			}
			if (_numberOfPasses > 0)
			{
				_numberOfPasses--;
				_currentVolume += _timeElapsed;
				_currentMusic.volumeTransform = _currentVolume;
				if (_numberOfPasses == 0)
				{
					removeTimer();
					if (_timeElapsed < 0)
					{
						if (_pauseOnFadeOut) pause();
						else stopMusic();
					}
				}
			}
		}
		//private function timerVolFaderHandler(e:TimerEvent):void
		//{
			//if(!_currentMusic.played)
			//if (_fadeOutTimer > 0)
			//{
				//_fadeOutTimer -= ELAPSED;
				//if (_fadeOutTimer <= _fadeOutTotalTimer)
				//{
					//_fadeOutTimer = _fadeOutTotalTimer;
					//removeTimer();
					//if (_afterCount)
					//{
						//if (_pauseOnFadeOut) pauseMusic();
						//else stopMusic();
					//}
				//}
				//_currentMusic.transform(_fadeOutTimer, 0);
			//}
			//else if(_fadeInTimer < 1)
			//{
				//_fadeInTimer += ELAPSED;
				//if (_fadeInTimer >= _fadeInTotalTimer)
				//{
					//_fadeInTimer = _fadeInTotalTimer;
					//removeTimer();
				//}	
				//_currentMusic.transform(_fadeInTimer, 0);
			//}
		//}
		//
		
		public function fadeOut(volume:Number = 0, time:Number = 1, aOnPause:Boolean = false):void
		{
			if (_muteMusic)
			{
				if (aOnPause) pause();
				else stopMusic();
				return;
			}
			_numberOfPasses = time * 1000 / SoundManager.TIMER_DALAY;
			_timeElapsed = _currentMusic.volume / _numberOfPasses;
			_timeElapsed *= -1;
			_currentVolume = _currentMusic.volume;
			_pauseOnFadeOut = aOnPause;
			addTimer();
		}

		public function fadeIn(volume:Number = 1, time:Number = 1):void
		{
			if (_muteMusic) return;
			_numberOfPasses = time * 1000 / SoundManager.TIMER_DALAY;
			_timeElapsed = _currentMusic.volume / _numberOfPasses;
			_currentVolume = 0;
			_currentMusic.volumeTransform = 0;
			_pauseOnFadeOut = false;
			addTimer();
		}
		
		private function addTimer():void
		{
			_timerVolFader.addEventListener(TimerEvent.TIMER, timerVolFaderHandler, false, 0, true);
			_timerVolFader.start();
		}
		
		private function removeTimer():void
		{
			_timerVolFader.removeEventListener(TimerEvent.TIMER, timerVolFaderHandler);
			_timerVolFader.stop();
		}
		
		// Music metod BEGIN ==================== ***
		
		public function updateTransform():void
		{
			if (_source.length < 1 || listener == null || _muteSound) return;
			
			var radial:Number;
			var pan:Number;
			var n:int = _source.length;
			var mySnd:MySound;
			
			for (var i:int = 0; i < n; i++)
			{
				mySnd = _source[i] as MySound;
				if (mySnd.object != null)
				{
					radial = listener.pos.lenght(mySnd.object.pos) / _radius;
					radial = 1 - Scalar.Clamp(radial, 0, 1);
					
					pan = (mySnd.object.pos.x - listener.pos.x) / _radius;
					pan = Scalar.Clamp(pan, -1, 1);
					
					mySnd.transform(radial, pan);
				}
			}
			
		}
		
	}
}