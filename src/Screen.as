package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.ContextMenu;
	import gamemenu.GameAward;
	import gamemenu.GameDied;
	import gamemenu.GameGuide;
	import gamemenu.GameMenu;
	import gamemenu.GameMission;
	import gamemenu.GamePause;
	import gamemenu.GameSave;
	import gamemenu.GameScreen;
	import gamemenu.GameSetting;
	import gamemenu.GameShift;
	import gamemenu.GameWon;
	import gamemenu.LevelSelection;
	import graphics.AnimClip;
	import levels.LevelManager;
	import system.Keyboard;
	import system.KeyCodes;
	import system.Loop;
	import system.SoundManager;
	import system.SWFProfiler;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class Screen extends Loop
	{
		//public var levelPassed:int = 1;
		
		private static var _instance:Screen;
		private var _levelManager:LevelManager;
		private var _levelSelection:LevelSelection
		private var _gameAward:GameAward
		private var _keyboard:Keyboard;
		private var _stg:Stage;
		private var _gameMap:GameMap;
		private var _gameScreen:GameScreen;
		private var _gameWon:GameWon;
		private var _gameDied:GameDied;
		private var _gameMenu:GameMenu;
		private var _gameShift:GameShift;
		private var _gamePause:GamePause;
		private var _gameMission:GameMission;
		private var _gameSave:GameSave;
		private var _gameSetting:GameSetting;
		private var _gameGuide:GameGuide;
		private var _soundManager:SoundManager;
		
		private var _bitmapData:BitmapData;
		private var _bitmap:Bitmap;
		private var _rectScreen:Rectangle;
		private var _bgScreen:AnimClip;
		private var _visibleBG:Boolean;
		
		public function Screen(stage:Stage = null)
		{
			if (_instance)
			{
				throw ("Error :: Screen.getInstance()");
			}
			_instance = this;
			_stg = stage;
			//stageFocus();

			_levelManager = new LevelManager();
			_keyboard = new Keyboard( stage );
			_gameMap = GameMap.getInstance(stage);
			_gameScreen = GameScreen.getInstance();
			_gameWon = GameWon.getInstance();
			_gameDied = GameDied.getInstance();
			_gameMenu = GameMenu.getInstance();
			_levelSelection = LevelSelection.getInstance();
			_gameAward = GameAward.getInstance();
			_gameShift = GameShift.getInstance();
			_gamePause = GamePause.getInstance();
			_gameMission = GameMission.getInstance();
			_gameSave = GameSave.getInstance();
			_gameSetting = GameSetting.getInstance();
			_gameGuide = GameGuide.getInstance();
			_soundManager = SoundManager.getInstance();
			
			_soundManager.addLibraryMusic(Skip_fon_mp3, "fon");
			_soundManager.addLibraryMusic(Sample_mp3, "sample");
			_soundManager.addLibraryMusic(Menu_wav, "Menu");
			_soundManager.addLibraryMusic(Gameplay_wav, "Gameplay");
			
			_soundManager.addLibrarySound(Skip_mp3, "skip1");
			_soundManager.addLibrarySound(Fire_mp3, "fire");
			
			_soundManager.addLibrarySound(Cannon_wav, "CannonFire");
			_soundManager.addLibrarySound(KeyUp_wav, "KeyUp");
			_soundManager.addLibrarySound(HeroWin_wav, "HeroWin");
			_soundManager.addLibrarySound(HeroStep_wav, "HeroStep");
			//_soundManager.addLibrarySound(HeroFall_snd, "HeroFall");
			_soundManager.addLibrarySound(HeroGrave_wav, "HeroGrave");
			_soundManager.addLibrarySound(HeroDead_wav, "HeroDead");
			_soundManager.addLibrarySound(HelmetStep_wav, "HelmetRuns");
			_soundManager.addLibrarySound(HelmetRun_snd, "HelmetAttaks");
			_soundManager.addLibrarySound(HelmetSleep_wav, "HelmetSleep");
			_soundManager.addLibrarySound(HelmetSurprise_wav, "HelmetSurprise");
			_soundManager.addLibrarySound(Door_wav, "Door");
			_soundManager.addLibrarySound(Cannon_wav, "Cannon");
			_soundManager.addLibrarySound(CageUp_wav, "CageUp");
			_soundManager.addLibrarySound(Button_wav, "Button");
			_soundManager.addLibrarySound(Bonfire_wav, "Bonfire");
			_soundManager.addLibrarySound(BarrelFire_wav, "BarrelFire");
			
			//_soundManager.playMusic("sample", true, 999);
			
			//var cm:ContextMenu = new ContextMenu();
				//cm.hideBuiltInItems();
				//cm.addEventListener(ContextMenuEvent.MENU_SELECT, contextMenuHandler)
			//this.contextMenu = cm;
			SWFProfiler.init(stage, this);
			
			this.addChild(_gameMap);
			this.addChild(_gameScreen);
			createBitmap();	
			gameMenu();
			//_gameMap.playGame(3);
			createBG();	
			super.start();
		}
		
		private function contextMenuHandler(e:ContextMenuEvent):void
		{
			if (_gameMap.knight.isUsed)
			{
				if (_gameScreen.isDied || _gameScreen.isWon || _gameScreen.isMisson || _gameGuide.isUsed) return;
				_keyboard.resetAllPressedKey();
				_gameMap.knight.pause();
				//stageFocus();
			}
		}
		
		private function createBitmap():void 
        {
            _bitmapData = new BitmapData(Constants.SCREEN_SIZE.x, Constants.SCREEN_SIZE.y, true , 0x00000000);
			_rectScreen = new Rectangle(0,0,Constants.SCREEN_SIZE.x,Constants.SCREEN_SIZE.y);
            _bitmap = new Bitmap(_bitmapData, "never", true );
			addChildAt(_bitmap, 0);
        }
		
		private function createBG():void 
        {
			_bgScreen = new AnimClip();
			_bgScreen.addAnim("Bg_Screen_mc", "bg", true);
			_bgScreen.alpha = 0;
			_bgScreen.mouseChildren = false;
			_bgScreen.mouseEnabled = false;
			_visibleBG = false;
			this.addChild(_bgScreen);
		}
		
		public function gameMenu():void
		{
			stageFocus();
			_gameMenu.init();
		}
		
		//public override function start():void
		//{
			//super.start();
		//}
		//
		//public override function stop():void
		//{
			//super.stop();
		//}
		
		public function levelSelection():void
		{
			stageFocus();
			_levelSelection.init();
		}
		
		public function gameAward():void
		{
			_gameAward.init();
		}
		
		public function gameWon():void
		{
			_gameWon.init();
		}
		
		public function gameDied():void
		{
			_gameDied.init();
		}
		
		public function gamePause():void
		{
			_gamePause.init();
		}
		
		public function gameMission():void
		{
			_gameMission.init();
		}
		public function gameSetting():void
		{
			_gameSetting.init();
		}
		public function gameGuide():void
		{
			_gameGuide.init();
		}
		
		//public function playSFX(name:String):void
		//{
			//_soundManager.playSFX(name);
		//}
		
		public function gameShift(callback:Function = null):void
		{
			_gameShift.onCompleteCallback = callback;
			_gameShift.init();
		}
		
		protected override function update(delta:Number):void
		{
			if ( delta > 0)
			{
				//delta = 1.0 / 30.0;
				
				if (_visibleBG)
				{
					if (_bgScreen.alpha < 1)_bgScreen.alpha += .05;
				}
				else
				{
					if (_bgScreen.alpha > 0)_bgScreen.alpha -= .05;
				}
				
				_keyboard.update();
				monitorKeystroke();
				
				_levelSelection.update(delta);
				_gameMenu.update(delta);
				_gameMap.update(delta);
				_gameAward.update(delta);
				_gameSetting.update(delta);
				_gameGuide.update(delta);
				_soundManager.updateTransform();
				
				_bitmapData.lock();
				_bitmapData.fillRect(_rectScreen, 0x00000000);
				_gameMenu.render(_bitmapData);
				_levelSelection.render(_bitmapData);
				_gameMap.render(_bitmapData);
				_gameWon.render(_bitmapData);
				_gameDied.render(_bitmapData);
				_gameMission.render(_bitmapData);
				_gamePause.render(_bitmapData);
				_gameShift.render(_bitmapData);
				_bitmapData.unlock();
			}
		}
		
		private function monitorKeystroke():void
		{
			if (_gameScreen.openWindow) return;
			if (_gameShift.isUsed) return;
			if (_gameGuide.isUsed) return;
			if (_keyboard.isKeyDownTransition(KeyCodes.M))
			{
				_soundManager.muteMusic();
			}
			if(_keyboard.isKeyDownTransition(KeyCodes.S))
			{
				_soundManager.muteSound();
			}
		}
		
		public function get keyboard():Keyboard
		{
			return _keyboard;
		}
		
		public function stageFocus():void
		{
			_stg.focus = _stg;
		}
		public function set onCallback(callback:Function):void
		{
			_gameShift.onCompleteCallback = callback;
		}
		
		public static function getInstance(stage:Stage = null):Screen
		{
			return (_instance == null) ? new Screen(stage) : _instance;
		}
		
		public function set visibleBG(value:Boolean):void
		{
			if (value) visibleAlpha();
			_visibleBG = value;
		}
		
		public function visibleAlpha():void
		{
			_bgScreen.alpha = 0;
		}
	}
	
}