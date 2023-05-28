package system
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundManager
	{
		private static const MAX_SOUND_CHANNELS:int = 8;
		private static var _instance:SoundManager;
		private static var _allowSounds:Boolean;
		private static var _allowSFX:Boolean;
		private static var _sound:Object;
		private static var _music:Sound;
		private static var _mSoundChannels:Array;
		private static var _mMusicChannel:SoundChannel;
		private static var _soundTransform:SoundTransform;
		private static var _startPlay:int = 0;

		public function SoundManager()
		{
			if (_instance)
			{
				throw new Error("Error: Use SoundManager.getInstance() instead of the new keyword.");
			}
			initSounds();
		}

		public static function getInstance():SoundManager
		{
			if (_instance == null)_instance = new SoundManager();
			return _instance;
		}

		private static function initSounds():void
		{
			_allowSounds = true;
			_allowSFX = true;

			_mSoundChannels = [];
			_sound = new Object();
			_soundTransform = new SoundTransform();

			//Додаємо всі необхідні звукові ефекти попередньо імпортовані в бібліотеку fla-файла
			_sound['skip'] = new Skip_mp3();
			//_sound['click'] = new Highlight_sound();
			//_sound['bg'] = new BossOfMe_sound();
			//_sound['sound3'] = new sound3();

			//Додаємо фонову музику
			_music = new Skip_fon_mp3();
		}
		
		public static function muteSound():void
		{
			if (_mSoundChannels.length <= 0)return;
			
			var i:int = _mSoundChannels.length;
			var sound:SoundChannel;
			
			while(--i>-1)
			{
				sound = _mSoundChannels[i];
				sound.stop();
				sound.removeEventListener(Event.SOUND_COMPLETE, OnSFXComplete);
				var idx:int = _mSoundChannels.indexOf(sound);
				_mSoundChannels.splice(idx, 1);
			}
		}
		
		public static function muteMusic():void
		{
			if (!_mMusicChannel)return;
			
			_startPlay = _mMusicChannel.position;
			_mMusicChannel.stop();
			_mMusicChannel = null;
		}

		//Функція, яка викликає програвання звукового ефекту
		public static function playSFX(sound_name:String):void
		{
			if (! _allowSFX)
			{
				return;
			}//Якщо _allowSFX == false – припиняємо виконання функції – не програємо звук
			var thisSound:Sound = _sound[sound_name];
			if (! _sound)
			{
				return;
			}//припиняємо виконання функції, якщо вказаного звуку не існує

			//Якщо кількість звуків в масиві перевищує максимально допустиму (в нашому випадку 8 каналів) – то "вбиваємо" зайвий звук
			if (_mSoundChannels.length >= MAX_SOUND_CHANNELS)
			{
				var unluckySound:SoundChannel = _mSoundChannels.shift();
				unluckySound.stop();
			}

			var sndChannel:SoundChannel = thisSound.play();//Вмикаємо звук у каналі
			_mSoundChannels.push(sndChannel);
			//Додаємо цей канал до масиву;
			sndChannel.addEventListener(Event.SOUND_COMPLETE, OnSFXComplete);
		//Додаємо слухач події, який перевіряє, чи не закінчилося програвання звуку, якщо так – викликається функція OnSFXComplete;
		}

		//Дана функція "вичищає" звук з масиву після закінчення програвання
		private static function OnSFXComplete(e:Event):void
		{
			var thisSoundChannel:SoundChannel = e.currentTarget as SoundChannel;
			thisSoundChannel.removeEventListener(Event.SOUND_COMPLETE, OnSFXComplete);
			thisSoundChannel.stop();
			var idx:int = _mSoundChannels.indexOf(thisSoundChannel);
			_mSoundChannels.splice(idx, 1);
		}

		//А ця функція відповідає за програвання фонової музики. Оскільки під неї виділений тільки один звуковий канал – ніякі масиви нам тут не потрібні.
		public static function playMusic():void
		{
			//var soundTransform:SoundTransform = new SoundTransform(.3);//Встановлює гучність на максимум 1
			_soundTransform.volume = .3;

			if (! _allowSounds)
			{
				_soundTransform.volume = 0;
			}//Змінює гучність на "0", коли вимкнено звуки

			if (! _mMusicChannel)
			{
				_mMusicChannel = _music.play(_startPlay,999,_soundTransform);//Для того, щоб добитися безперервного повторення звуків, кількість повторів встановлена на 999. Приміром, якщо ваш звуковий фон має тривалість одну хвилину, то музика гратиме безперервно протягом 999 хвилин, тобто близько 17 годин. А можна поставити ще більшу кількість повторів.
			}
			else
			{
				_mMusicChannel.soundTransform = _soundTransform;
			}
		}
		
		public static function stopMusic():void
		{
			_soundTransform.volume = 0;
			_mMusicChannel.soundTransform = _soundTransform;
		}
		
		public static function get allowSounds():Boolean
		{
			return _allowSounds;
		}
		public static function set allowSounds(value:Boolean):void
		{
			_allowSounds = value;
		}
		public static function get allowSFX():Boolean
		{
			return _allowSFX;
		}
		public static function set allowSFX(value:Boolean):void
		{
			_allowSFX = value;
		}
	}
}