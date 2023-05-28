package gamemenu 
{
	import flash.net.SharedObject;
	import levels.LevelManager;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameSave 
	{
		public static const SPIKES:int = 0;
		public static const PILLOW:int = 1;
		public static const IGNITION_50:int = 2;
		public static const IGNITION_75:int = 3;
		public static const IGNITION_100:int = 4;
		public static const IRON_DOOR:int = 5;
		public static const SILVER_DOOR:int = 6;
		public static const GOLDEN_DOOR:int = 7;
		public static const IMMORTAL:int = 8;
		public static const FIRST_BLOOD:int = 9;
		public static const LORD_KEYS:int = 10;
		public static const TAMER:int = 11;
		public static const MEAT:int = 12;
		public static const CANNON_FODDER:int = 13;
		public static const KING_LEVEL:int = 14;
		
		private static var _MySo:SharedObject;
		private static var _instance:GameSave;
		private static var _awardList:Array;
		private static var _maxIndex:Array;
		private static var _levelStar:Array;
		private static var _levelPlaying:Array;
		private static var _levelPassed:int;
		public static var _countScene:int;
		
		public function GameSave()
		{
			if (_instance)
			{
				throw ("Error :: LevelSelection.getInstance()");
			}
			_instance = this;
			
			_MySo = SharedObject.getLocal("Castellan");
			if (_MySo.data.isPlay) getGame();
			else setNewGame();
			//_awardList = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			//_MySo.data.awardList = _awardList;
			
			//_MySo.clear();
			//_awardList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			//_levelStar = [4, 4, 4, 4, 4, 4, 4];
			//_levelPassed = 1;
			
			//_awardList = [3, 5, 50, 75, 100, 20, 30, 50, 20, 1, 1, 20, 20, 20];
			_maxIndex = [15, 30, 75, 135, 300, 50, 65, 90, 45, 1, 1, 50, 50, 25, 45];
			//_levelPassed = LevelManager.TOTAL_LEVEL - 1;
		}
		
		private static function getGame():void
		{
			_awardList = _MySo.data.awardList;
			_levelPlaying = _MySo.data.levelPlaying;
			_levelStar = _MySo.data.levelStar;
			_levelPassed = _MySo.data.levelPassed;
			_countScene = _MySo.data.countScene;
			
			//openSceneTo = _MySo.data.openSceneTo;
		}
		private static function setNewGame():void
		{
			_awardList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			_levelPlaying = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
			_levelStar = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4];
			_levelPassed = 1;
			_countScene = 3;
			_MySo.data.isPlay = true;
			_MySo.data.awardList = _awardList;
			_MySo.data.levelStar = _levelStar;
			_MySo.data.levelPlaying = _levelPlaying;
			_MySo.data.levelPassed = _levelPassed;
			_MySo.data.countScene = _countScene;
			
			//openSceneTo = 1;
		}
		
		public static function clearGame():void
		{
			setNewGame();
		}
		
		public static function set levelPassed(value:int):void
		{
			_levelPassed = value;
			_MySo.data.levelPassed = _levelPassed;
		}
		public static function get levelPassed():int
		{
			return _levelPassed;
		}
		
		public static function set countScene(value:int):void
		{
			_countScene = value;
			_MySo.data.countScene = _countScene;
		}
		public static function get countScene():int
		{
			return _countScene;
		}
		
		public static function setLevelStar(level:int, star:int):void
		{
			_levelStar[level - 1] = star;
			_MySo.data.levelStar = _levelStar;
		}
		
		public static function getLevelStar(level:int):int
		{
			return _levelStar[level - 1];
		}

		public static function setAward(index:int, value:int = 1):void
		{
			_awardList[index] = _awardList[index] + value;
			_MySo.data.awardList = _awardList;
		}
		
		public static function getAward(index:int):int
		{
			return _awardList[index];
		}
		
		public static function setLevelPlaying(level:int, value:Boolean):void
		{
			_levelPlaying[level - 1] = value;
			_MySo.data.levelPlaying = _levelPlaying;
		}
		
		public static function getLevelPlaying(level:int):Boolean
		{
			return _levelPlaying[level - 1];
		}
		
		public static function getMaxIndex(index:int):int
		{
			return _maxIndex[index];
		}
		
		public static function inRange(index:int):Boolean
		{
			return _awardList[index] < _maxIndex[index];
		}
		
		public static function ifFilled(index:int):Boolean
		{
			return _awardList[index] == _maxIndex[index];
		}
		
		public static function getInstance():GameSave
		{
			return (_instance == null) ? new GameSave() : _instance;
		}
		
	}

}