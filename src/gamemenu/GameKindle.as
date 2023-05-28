package gamemenu 
{
	import controller.PropertiesController;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import graphics.Animation;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class GameKindle 
	{
		private var _gameMap:GameMap;
		private var _gameScreen:GameScreen;
		private var _pos:Vector2D;
		private var _kindleList:Array;

		private var _torchCountOrange:int;
		private var _torchCountBlue:int;
		private var _torchCountGreen:int;
		private var _torchCountPurple:int;
		
		private var _fireCountOrange:int;
		private var _fireCountBlue:int;
		private var _fireCountGreen:int;
		private var _fireCountPurple:int;
		
		private var _numTorchOrange:int;
		private var _numTorchBlue:int;
		private var _numTorchGreen:int;
		private var _numTorchPurple:int;
		
		public function GameKindle() 
		{
			_gameMap = GameMap.getInstance();
			_gameScreen = GameScreen.getInstance();
			
			_kindleList = [new FireKindle(40,40), new FireKindle(130,40), new FireKindle(220,40),new FireKindle(310,40)];
			
			_torchCountOrange = _torchCountBlue = _torchCountGreen = _torchCountPurple = 0;
			_fireCountOrange = _fireCountBlue = _fireCountGreen = _fireCountPurple = 0;
			_numTorchOrange = _numTorchBlue = _numTorchGreen = _numTorchPurple = 0;
		}
		
		public function free():void
		{
			_gameScreen.isOrange = false;
			_gameScreen.isBlue = false;
			_gameScreen.isGreen = false;
			_gameScreen.isPurple = false;
			
			_torchCountOrange = _torchCountBlue = _torchCountGreen = _torchCountPurple = 0;
			_fireCountOrange = _fireCountBlue = _fireCountGreen = _fireCountPurple = 0;
			_numTorchOrange = _numTorchBlue = _numTorchGreen = _numTorchPurple = 0;
			
			var i:int = _gameScreen.numKindle;
			var kindle:FireKindle;
			while (--i>-1)
			{
				kindle = _kindleList[i];
				kindle.free();
			}
				//_gameScreen.removeChild(_textPurple);
			//}
		}
		
		public function init():void
		{		
			_pos = _gameMap.cacheV2D.allocate(0, 0);
			
			createKindle();
			updateCount(_gameScreen.torchArray);
		}
		
		private function createKindle():void
		{
			var i:int = _gameScreen.numKindle;
			var kindle:FireKindle;
			var isPurple:Boolean = _gameScreen.isPurple;
			var isGreen:Boolean = _gameScreen.isGreen;
			var isBlue:Boolean = _gameScreen.isBlue;
			var isOrange:Boolean = _gameScreen.isOrange;
			
			while (--i>-1)
			{
				kindle = _kindleList[i];
				
				if (isPurple)
				{
					kindle.initial(this, Constants.PURPLE);
					isPurple = false;
				}
				else if (isGreen)
				{
					kindle.initial(this, Constants.GREEN);
					isGreen = false;
				}
				else if (isBlue)
				{
					kindle.initial(this, Constants.BLUE);
					isBlue = false;
				}
				else if (isOrange)
				{
					kindle.initial(this, Constants.ORANGE);
					isOrange = false;
				}
			}

		}
		public function render(bitmapData:BitmapData):void
		{
			var i:int = _gameScreen.numKindle;
			var kindle:FireKindle;
			while (--i>-1)
			{
				kindle = _kindleList[i];
				kindle.render(bitmapData);
			}
		}
		
		public function updateCount(torchArray:Array):void
		{
			_torchCountOrange = _torchCountBlue = _torchCountGreen = _torchCountPurple = 0;
			_fireCountOrange = _fireCountBlue = _fireCountGreen = _fireCountPurple = 0;
			_numTorchOrange = _numTorchBlue = _numTorchGreen = _numTorchPurple = 0;
			_gameScreen.maxTorchOrange = _gameScreen.maxTorchBlue = _gameScreen.maxTorchGreen = _gameScreen.maxTorchPurple = 0;
			
			var pc:PropertiesController = null;
			var i:int = torchArray.length;
			while (--i > -1)
			{
				pc = torchArray[i];
				
				countFire(pc.colorFire);
				countTorch(pc.colorTorch);
				numTorch(pc.colorTorch, pc.colorFire);
			}
			
			_gameScreen.maxTorchOrange = _torchCountOrange;
			_gameScreen.maxTorchBlue = _torchCountBlue;
			_gameScreen.maxTorchGreen = _torchCountGreen;
			_gameScreen.maxTorchPurple = _torchCountPurple;
			
			i = _gameScreen.numKindle;
			var kindle:FireKindle;
			while (--i>-1)
			{
				kindle = _kindleList[i];
				//kindle.setText();
				switch(kindle.color)
				{
					case Constants.NONE: break;
					case Constants.ORANGE: kindle.text = _fireCountOrange + "/" + _torchCountOrange;break;
					case Constants.BLUE: kindle.text = _fireCountBlue + "/" + _torchCountBlue;break;
					case Constants.GREEN: kindle.text = _fireCountGreen + "/" + _torchCountGreen;break;
					case Constants.PURPLE: kindle.text = _fireCountPurple + "/" + _torchCountPurple;break;
				}
			}
			
			pikedKey();
		}
		
		private function pikedKey():void
		{
			_gameScreen.openKeyOrange = _numTorchOrange == _torchCountOrange || _gameScreen.openKeyOrange;
			_gameScreen.openKeyBlue = _numTorchBlue == _torchCountBlue || _gameScreen.openKeyBlue;
			_gameScreen.openKeyGreen = _numTorchGreen == _torchCountGreen || _gameScreen.openKeyGreen;
			_gameScreen.openKeyPurple = _numTorchPurple == _torchCountPurple || _gameScreen.openKeyPurple;

			//trace("orange " + _fireCountOrange + "/" + __torchCountOrange,
				  //"blue " + __fireCountBlue + "/" + __torchCountBlue,
				  //"green " + __fireCountGreen + "/" + __torchCountGreen,
				  //"purple " + __fireCountPurple + "/" + __torchCountPurple)
				  
				  //if (_numTorchOrange == __torchCountOrange && !_openKeyOrange)
			//{
				//_openKeyOrange = true;
			//}
		}
		
		private function numTorch(colorTrch:int, colorFr:int):void
		{
			if (colorTrch != colorFr) return;
			switch(colorTrch)
			{
				case Constants.NONE: break;
				case Constants.ORANGE: _numTorchOrange++;break;
				case Constants.BLUE: _numTorchBlue++;break;
				case Constants.GREEN: _numTorchGreen++;break;
				case Constants.PURPLE: _numTorchPurple++;break;
			}
		}
		
		private function countFire(color:int):void
		{
			switch(color)
			{
				case Constants.NONE: break;
				case Constants.ORANGE: _fireCountOrange++;break;
				case Constants.BLUE: _fireCountBlue++;break;
				case Constants.GREEN: _fireCountGreen++;break;
				case Constants.PURPLE: _fireCountPurple++;break;
			}
		}
		
		private function countTorch(color:int):void
		{
			switch(color)
			{
				case Constants.NONE: break;
				case Constants.ORANGE: _torchCountOrange++;break;
				case Constants.BLUE: _torchCountBlue++;break;
				case Constants.GREEN: _torchCountGreen++;break;
				case Constants.PURPLE: _torchCountPurple++;break;
			}
		}
		
	}

}