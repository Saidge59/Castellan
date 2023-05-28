package gamemenu 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import graphics.Animation;
	import graphics.AnimClip;
	import levels.LevelManager;
	import maths.Vector2D;
	import system.KeyCodes;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameWon extends GameWindows
	{		
		private static const NONE_STAR:int = 1;
		private static const ONE_STAR:int = 13;
		private static const TWO_STARS:int = 31;
		private static const THREE_STARS:int = 49;
		
		private static var _instance:GameWon;
		private var _animWon:Animation;
		private var _animStars:Animation;
		private var _ramkaText:Animation;
		private var _animFlag:Animation;
		private var _animOver:Animation;
		private var _overBTN:Boolean;
		
		//private var _textTimeFor1Star:TextField;
		//private var _textTimeFor2Star:TextField;
		//private var _textTimeFor3Star:TextField;
		//
		public function GameWon() 
		{
			if (_instance)
			{
				throw("ERROR: GameWon.getInstance()");	
			}
			_instance = this;

			_animWindow = new Animation();
			_animWindow.addAnim("ScreenWon_mc", "screenWon", true);
			
			_animStars = new Animation();
			_animStaticStars = new Animation();
			_animFlag = new Animation();
			_ramkaText = new Animation();
			_animOver = new Animation();
			_animStars.addAnim("GameWon_stars_mc", "stars", true);
			_animStaticStars.addAnim("Won_stars_mc", "StatStars", true);
			_animFlag.addAnim("Won_flag_mc", "flag", true);
			_ramkaText.addAnim("Ramka_close_mc", "ramka", true);
			_animOver.addAnim("Text_lose_mc", "over", true);
			
			_textTimeFor1Star = new TextField();
			_textTimeFor2Star = new TextField();
			_textTimeFor3Star = new TextField();

			_animRestart = new AnimClip();
			_animMenu = new AnimClip();
			_animNext = new AnimClip();
			_animRestart.addAnim("Won_btn_mc", "restart", true);
			_animMenu.addAnim("Won_btn_mc", "menu", true);
			_animNext.addAnim("Won_btn_mc", "next", true);
			
			_textFormat = new TextFormat();
			_textPlayerTime = new TextField();
			_embeddedFont = new BerlinSansFBDemi();
		}
		
		public override function free():void
		{
			_gameScreen.isWon = false;
			//if (_gameScreen.contains(_textTimeFor1Star))
			//{
				//_gameScreen.removeChild(_textTimeFor1Star);
			//}
			//if (_gameScreen.contains(_textTimeFor2Star))
			//{
				//_gameScreen.removeChild(_textTimeFor2Star);
			//}
			if (_gameScreen.contains(_animOver))
			{
				_gameScreen.removeChild(_animOver);
			}
			super.free();
		}
		
		public override function init():void
		{			
			_soundManager.playSound("HeroWin");
			//_pos.init(Constants.SCREEN_HALF_SIZE.x, Constants.SCREEN_HALF_SIZE.y);
			_animFlag.index = _animStars.index = _animStaticStars.index = 0;
			_overBTN = _animStars.p_playOnce = false;
			
			if (_gameScreen.countStars > 0 && !_gameMap.perentLevel.isPlay && _gameMap.currNumLevel <= LevelManager.TOTAL_LEVEL)
			{
				_gameMap.perentLevel.isPlay = true;
				_gameMap.perentLevel.countStars = _gameScreen.countStars;
				GameSave.setAward(GameSave.KING_LEVEL, _gameScreen.countStars);
				GameSave.setLevelStar(_gameMap.currNumLevel, _gameScreen.countStars);
				GameSave.setLevelPlaying(_gameMap.currNumLevel, true);
				GameSave.levelPassed += 1;
			}
			else if (_gameScreen.countStars > _gameMap.perentLevel.countStars)
			{
				var star:int = _gameScreen.countStars - _gameMap.perentLevel.countStars;
					GameSave.setAward(GameSave.KING_LEVEL, star);
					GameSave.setLevelStar(_gameMap.currNumLevel, _gameScreen.countStars);
				_gameMap.perentLevel.countStars = _gameScreen.countStars;
			}
			
			super.init();
			if (_textPlayerTime != null)
			{
				_textPlayerTime.x = Constants.SCREEN_HALF_SIZE.x - _textPlayerTime.width * .5;
				_textPlayerTime.y = Constants.SCREEN_HALF_SIZE.y - 80;
			}
			if (_animRestart != null)
			{
				_animRestart.x = _pos.x - 42;
				_animRestart.y = _pos.y + 65;
			}
			if (_animMenu != null)
			{
				_animMenu.x = _pos.x;
				_animMenu.y = _pos.y + 65;
			}
			if (_animNext != null)
			{
				_animNext.x = _pos.x + 42;
				_animNext.y = _pos.y + 65;
			}
		}
		
		//protected override function openParamFun():void
		//{
			//_gameMap.perentLevel.countStars = _gameScreen.countStars;
			//_gameScreen.addChild(_textTimeFor1Star);
			//_gameScreen.addChild(_textTimeFor2Star);
			//_gameScreen.addChild(_textTimeFor3Star);
			//
			//super.openParamFun();
		//}
		
		private function get getStars():int
		{
			if (_gameScreen.countStars == 3)return GameWon.THREE_STARS;
			else if (_gameScreen.countStars == 2)return GameWon.TWO_STARS;
			else if (_gameScreen.countStars == 1)return GameWon.ONE_STAR;
			else return GameWon.NONE_STAR;
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			if (_isWindow)
			{
				var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos);
				_animFlag.playFragment(33,19);
				_animFlag.render(bitmapData, vector.init(_pos.x,_pos.y - 130), false);
				if (_overBTN)
				{
					_ramkaText.render(bitmapData, vector.init(_pos.x, _pos.y + 110), false);
					_animOver.render(bitmapData, vector.init(_pos.x, _pos.y + 120), false);
				}
				super.render(bitmapData);
				if (_openParam)
				{
					_animStaticStars.render(bitmapData, vector.init(_pos.x, _pos.y), false);
					_animStars.playOnceTo(getStars);
					_animStars.render(bitmapData, vector.init(_pos.x,_pos.y - 160),false);
				}
			}
		}
		
		public static function getInstance():GameWon
		{
			return (_instance == null) ? new GameWon() : _instance;
		}
		
		protected override function overText(e:MouseEvent):void
		{
			_animOver.visible = _overBTN = true;
			var anim:AnimClip = e.currentTarget as AnimClip;
			if (anim.getAnimName == "restart")_animOver.goToFrame(10);
			else if(anim.getAnimName == "menu")_animOver.goToFrame(11);
			else _animOver.goToFrame(12);
			super.overText(e);
		}
		
		protected override function outText(e:MouseEvent):void
		{
			_animOver.visible = _overBTN = false;
			super.outText(e);
		}
		
	}

}