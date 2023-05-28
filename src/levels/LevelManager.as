package levels
{
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class LevelManager 
	{		
		public static const TOTAL_LEVEL:int = 15;
		public static var levelList:Array;
		
		public function LevelManager()
		{
			levelList = new Array(new Level1(), new Level2(), new Level3(), new Level4(), new Level5(), new Level6(), new Level7(), new Level8(), new Level9(), new Level10(), new Level11(), new Level12(), new Level13(), new Level14(), new Level15());
		}
		
		public static function getLevel(lvl:int):LevelBase
		{
			if ( lvl < 0 || lvl > LevelManager.TOTAL_LEVEL)
			{
				throw ("ERROR: LevelManager.getLevel() not faund level!");
			}
			return levelList[lvl-1];
		}
	}
	
}