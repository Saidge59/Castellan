package gamemenu 
{
	import flash.display.BitmapData;
	import graphics.Animation;
	import graphics.AnimClip;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GamePause extends GameWindows
	{
		private static var _instance:GamePause;
		
		public function GamePause() 
		{
			if (_instance)
			{
				throw("ERROR: GameDied.getInstance()");	
			}
			_instance = this;
			
			_animWindow = new Animation();
			_animWindow.addAnim("Screen_Pause_mc", "screenPause", true);
			
			_animContinue = new AnimClip();
			_animRestart = new AnimClip();
			_animMenu = new AnimClip();
			_animContinue.addAnim("Text_lose_mc", "continueLose", true);
			_animRestart.addAnim("Text_lose_mc", "restart", true);
			_animMenu.addAnim("Text_lose_mc", "menu", true);
		}
		
		public override function free():void
		{
			super.free();
		}
		
		public override function init():void
		{
			_gameScreen.isPause = true;
			
			super.init();
			if (_animContinue != null)
			{
				_animContinue.goto(4);
				_animContinue.x = _pos.x;
				_animContinue.y = _pos.y - 40;
			}
			if (_animRestart != null)
			{
				_animRestart.x = _pos.x;
				_animRestart.y = _pos.y;
			}
			if (_animMenu != null)
			{
				_animMenu.x = _pos.x;
				_animMenu.y = _pos.y + 40;
			}
		}

		
		public override function render(bitmapData:BitmapData):void
		{
			super.render(bitmapData);
			if (_animWindow.p_reversOnce)
			{
				_gameMap.knight.isUsed = true;
			}
		}
		
		public static function getInstance():GamePause
		{
			return (_instance == null) ? new GamePause() : _instance;
		}
		
	}

}