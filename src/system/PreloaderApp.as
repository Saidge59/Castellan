package system
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class PreloaderApp extends AntPreloader
	{
		private var progressBar:MovieClip;
		private var textBar:TextField;

		public function PreloaderApp()
		{
			entryClass = "com.coloredtowers.App";
		}
		/**
		 * @private
		 */
		override public function update(aPercent:Number):void
		{
			//super.update(aPercent);
			//preloadBar.scaleX = aPercent;
			var action:int = aPercent * 100;
			textBar = getChildByName("load_txt") as TextField;
			textBar.text = String(action + "%");
			progressBar = getChildByName("preload") as MovieClip;
			progressBar.scaleX = aPercent;
			//preloadBar.loadingText.text = int(aPercent * 100) + "%";
			trace("Loading:", int(aPercent * 100));
		}

		/**
		 * @private
		 */
		override public function completed():void
		{
			//stage.removeChild(stage.getChildAt(0));
			//preloadBar.visible = false;
			super.completed();
			//trace("Loading is completed!");
		}

	}

}