package gamemenu 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import graphics.Animation;
	import graphics.AnimClip;
	import maths.Vector2D;
	import system.SoundManager;
	/**
	 * ...
	 * @author falcon12
	 */
	public class LevelThumbnail extends Sprite
	{
		public var _screen:Screen;
		public var _gameMap:GameMap;
		public var _levelSelection:LevelSelection;
		public var levelNumb:int;
		public var pos:Vector2D;
		
		private var _soundManager:SoundManager;
		private var _animDoor:AnimClip;
		private var _animSars:Animation;
		private var _textLevel:Animation;
		private var _textEnter:Animation;
		private var _animFlag:Animation;
		private var _usedBtn:Boolean;
		
		public function LevelThumbnail() 
		{
			_screen = Screen.getInstance();
			_gameMap = GameMap.getInstance();
			_levelSelection = LevelSelection.getInstance();
			_soundManager = SoundManager.getInstance();
			
			_animDoor = new AnimClip();
			_animSars = new Animation();
			_textLevel = new Animation();
			_textEnter = new Animation();
			_animFlag = new Animation();
			_animDoor.addAnim("Doors_mc", "door", true);
			_animFlag.addAnim("Flag_orange_mc", "flag_orange", true);
			_animFlag.addAnim("Flag_green_mc", "flag_green", true);
			_animSars.addAnim("Level_stars_mc", "stars", true);
			_textLevel.addAnim("Text_level_mc", "level", true);
			_textEnter.addAnim("Text_Enter_mc", "enter", true);
		}
		
		public function free():void
		{
			_usedBtn = false;
			_animDoor.removeEventListener(MouseEvent.CLICK, mouseClickHandler);
			_animDoor.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			_animDoor.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);

			if (this.contains(_animDoor))
			{
				this.removeChild(_animDoor);
			}
			if (_screen.contains(this))
			{
				_screen.removeChild(this);
			}
		}
		
		public function init(levelNumb:int, stars:int):void
		{
			_usedBtn = true;
			this.levelNumb = levelNumb;

			_animSars.goToFrame(stars - 1);
			_textLevel.goToFrame(levelNumb - 1);
			
			if (_animDoor != null)
			{
				_animDoor.x = pos.x;
				_animDoor.y = pos.y;
				this.addChild(_animDoor);
			}
			switchAnim();
			
			_screen.addChild(this);
		}
		
		private function switchAnim():void
		{
			if (GameSave.levelPassed == levelNumb)
			{
				_animDoor.goto(0);
				_animFlag.switchAnim("flag_orange");
				paramClip();
			}
			else if(levelNumb < GameSave.levelPassed)
			{
				_animDoor.goto(4);
				_animFlag.switchAnim("flag_green");
				paramClip();
			}
			else
			{
				_animDoor.goto(8);
			}
		}
		
		private function paramClip():void 
		{
			_animDoor.buttonMode = true;
			_animDoor.addEventListener(MouseEvent.CLICK, mouseClickHandler, false, 0, true);
			_animDoor.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
			_animDoor.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);
		}
		
		private function mouseClickHandler(event:MouseEvent):void
		{
			if (!_usedBtn) return;
			//_soundManager.stopMusic();
			_soundManager.fadeOut(0, .25);
			_soundManager.stopAllSound();
			_screen.gameShift(callbackPlay);
		}
		
		private function callbackPlay():void
		{
			_levelSelection.free();
			_gameMap.playGame(levelNumb);
			_screen.stageFocus();
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			//if (!_usedBtn) return;
			var anim:AnimClip = e.currentTarget as AnimClip;
				anim.goto(anim.index + 1);
			_soundManager.playSound("Button");
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			//if (!_usedBtn) return;
			var anim:AnimClip = e.currentTarget as AnimClip;
				anim.goto(anim.index - 1);
		}
		
		public function render(bitmapData:BitmapData):void
		{
			if (GameSave.levelPassed >= levelNumb)_animFlag.render(bitmapData, _gameMap.cacheV2D.allocateV2D(pos).addToY( -60));
			if (GameSave.levelPassed == levelNumb)_textEnter.render(bitmapData, _gameMap.cacheV2D.allocateV2D(pos).addToPiece(24,-98), false);
			_animSars.render(bitmapData, _gameMap.cacheV2D.allocateV2D(pos).addToY(-144), false);
			_textLevel.render(bitmapData, _gameMap.cacheV2D.allocateV2D(pos).addToY( -120), false);
		}
		
		public function set usedBtn(value:Boolean):void
		{
			_usedBtn = value;
			
			//if (GameSave.levelPassed == levelNumb)_animDoor.goto(0);
			//else if(levelNumb < GameSave.levelPassed)_animDoor.goto(4);
			//else _animDoor.goto(8);
		}

		//private function getStars(stars:int):int
		//{
			//if(stars)
		//}
		
	}

}