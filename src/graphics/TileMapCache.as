package graphics 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author falcon12
	 */
	public class TileMapCache 
	{
		private static var _instance:TileMapCache;
		private var _tileClass:Object;
		
		public function TileMapCache()
		{
			if (_instance)
			{
				throw("Error :: TileMapCache.getInstance()");
			}
			_instance = this;
			_tileClass = [];
		}
		
		public function getMap(name:String):TileMap
		{
			return TileMap(_tileClass[name]);
		}
		
		public function cacheList(list:Array):void
		{
			for (var i:int = 0; i < list.length; i++ )
			{
				addToCache(list[i]);
			}
		}
		
		public function addToCache(clipClass:Class):TileMap
		{
			var name:String = getQualifiedClassName(clipClass);

			var map:TileMap = new TileMap();
				map.classFromCache(new clipClass());
			_tileClass[name] = map;
			
			return map;
		}
		
		public static function getInstance():TileMapCache
		{
			return (_instance == null)? new TileMapCache():_instance;
		}
		
	}

}