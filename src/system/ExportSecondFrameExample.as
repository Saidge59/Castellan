/**
 * @author Denis Kolyako
 * @url http://dev.etcs.ru/
 * @email etc [at] mail.ru
 */
package com.framework
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;

	public class ExportSecondFrameExample extends MovieClip
	{
		public static const ENTRY_FRAME:Number = 3;
		public static const DOCUMENT_CLASS:String = 'com.coloredtowers.App';

		private var progressBar:MovieClip;

		public function ExportSecondFrameExample()
		{
			super();
			stop();
			progressBar = getChildByName("preloadBar") as MovieClip;
			//progressBar.scaleX = 0;
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
		}

		private function progressHandler(event:ProgressEvent):void
		{
			var loaded:uint = event.bytesLoaded;
			var total:uint = event.bytesTotal;
			trace(int(loaded / total * 100) + "%");
			preloadBar.loadingText.text = int(loaded / total * 100) + "%";
			//progressBar.scaleX = loaded / total;
		}

		private function completeHandler(event:Event):void
		{
			play();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function enterFrameHandler(event:Event):void
		{
			if (currentFrame >= ExportSecondFrameExample.ENTRY_FRAME)
			{
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				stop();
				main();
			}
		}

		private function main():void
		{
			var programClass:Class = loaderInfo.applicationDomain.getDefinition(ExportSecondFrameExample.DOCUMENT_CLASS) as Class;
			var program:Sprite = new programClass() as Sprite;
			addChild(program);
			/* // Logic, but not working code:
			var program:Program = new Program();
			addChild(program);
			*/
		}
	}
}