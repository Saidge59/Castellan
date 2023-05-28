package graphics 
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author falcon12
	 */
	public class CacheLibrary 
	{
		public var onProgressCallback:Function = null;
		public var onCompleteCallback:Function = null;
		public var clipsPerStep:int = 10;
		
		private static var _instance:CacheLibrary;
		private var _className:Object;
		private var _animList:Array;
		private var _curProcessingItem:int = 0;
		
		public function CacheLibrary()
		{
			if (_instance)
			{
				throw("Error :: CacheLibrary.getInstance()");
			}
			_instance = this;
			_className = [];
			_animList = [];
			_curProcessingItem = 0;
		}
		
		public function getAnim(name:String):AnimLibrary
		{
			return AnimLibrary(_className[name]);
		}
		
		public function cacheListStep(list:Array):void
		{
			_animList = list;
			step();
		}
		
		public function cacheList(list:Array):void
		{
			for (var i:int = 0; i < list.length; i++ )
			{
				addToCache(list[i]);
			}
		}
		
		public function addToCache(clipClass:Class):AnimLibrary
		{
			var name:String = getQualifiedClassName(clipClass);

			var anim:AnimLibrary = new AnimLibrary();
				anim.classFromCache(new clipClass());
			_className[name] = anim;
			
			return anim;
		}
		
		protected function step():void
		{
			// Обрабатываем заданное количество клипов за один шаг.
			var n:int = _curProcessingItem + clipsPerStep;
			n = (n >= _animList.length) ? _animList.length : n;
			for (var i:int = _curProcessingItem; i < n; i++)
			{
				addToCache(_animList[i]);
			}
			
			_curProcessingItem = n - 1;
			
			// Отправляем сообщение о прогрессе.
			if (onProgressCallback != null)
			{
				(onProgressCallback as Function).apply(this, [ (_curProcessingItem + 1) / _animList.length ]);
			}
			// Если процесс завершен, отправляем сообщение о завершении.
			if (_curProcessingItem == _animList.length - 1)
			{
				_animList.length = 0;
				if (onCompleteCallback != null)
				{
					(onCompleteCallback as Function).apply(this);
				}
			}
			else
			{
				//step();
				setTimeout(step, 1);
			}
		}
		
		public static function getInstance():CacheLibrary
		{
			return (_instance == null)? new CacheLibrary():_instance;
		}
		
	}

}