package doors 
{
	import clue.Key;
	import flash.display.BitmapData;
	import gamemenu.GameSave;
	import levels.LevelBase;
	import maths.Vector2D;
	import geometry.*;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Door extends DoorBase
	{		
		public function Door() 
		{
			_animDoor.addAnim("Doors_mc", "doors");
			_animFlag.addAnim("Flag_orange_mc", "flag_orange", true);
		}
		
		public override function free():void
		{
			_gameMap.cacheDoor.set(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			_renderMin = _gameMap.cacheV2D.allocate(-Constants.DOOR_SIZE.x, -Constants.DOOR_SIZE.y);
			_renderMax = _gameMap.cacheV2D.allocate(Constants.SCREEN_SIZE.x + Constants.DOOR_SIZE.x, Constants.SCREEN_SIZE.y + Constants.DOOR_SIZE.y * 2);
			_halfSize = _gameMap.cacheV2D.allocate(Constants.DOOR_SIZE.x * .5, Constants.DOOR_SIZE.y * .5);
			//trace(_colorDoor, movePos);
			if (_gameMap.isRenderShape)
			{
				// render shape
				drawBox(-_halfSize.x * 2,-_halfSize.y * 3.5, _halfSize.x *2 ,_halfSize.y * 2,0x008080);
			}
			if (_gameMap.isPhysicsObject)
			{
				// touch shape
				drawBox( -_halfSize.x, -_halfSize.y, _halfSize.x, _halfSize.y, 0x0099FF);
			}
			_openDoor = _gameScreen.isMisson;
			
			super.init(p);
		}

		private function onCallback():void
		{
			var m_Pos:Vector2D = _gameMap.cacheV2D.allocateV2D(movePos);// т.к. класс возвращяется в кеш!!!
			_gameScreen.startTicker();
			_gameMap.isUsed = false;
			_gameMap.clear();
			_gameMap.currLevel = toClass as LevelBase;
			toClass.paramLevel();
			_gameMap.playerPos = m_Pos;
			_gameMap.CreateTileMap(toClass.map, false);
			_gameMap.knight.isUsed = true;
			_gameMap.isUsed = true;
		}
		
		public override function update(delta:Number):void
		{
			if (_gameMap.knight.isDead || _gameMap.knight.isWon) return;
			if (_gameShift.isUsed) return;
			if (!_openDoor)
			{
				_openDoor = true;
				_soundManager.resume();
				_soundManager.fadeIn(.5, 1);
				_soundManager.playSound("Door", this, 1);
			}
			
			var contact:Boolean = AABB.overlap(_gameMap.knight, this);
			if (contact && _gameMap.knight.isDown)
			{
				if (_colorDoor == Constants.ORANGE && _gameScreen.pikedKeyOrange)
				{
					_soundManager.playSound("Door", this, 1);
					trace("LEVEL COMPLETE!");
					_gameMap.knight.win();
				}
				else if (openDoor)
				{
					_screen.keyboard.resetAllPressedKey();
					_soundManager.fadeOut(0, .25, true);
					_soundManager.stopAllSound();
					_soundManager.playSound("Door", this, 1);
					if(GameSave.ifFilled(GameSave.SILVER_DOOR) && GameSave.inRange(GameSave.GOLDEN_DOOR))GameSave.setAward(GameSave.GOLDEN_DOOR);
					if(GameSave.ifFilled(GameSave.IRON_DOOR) && GameSave.inRange(GameSave.SILVER_DOOR))GameSave.setAward(GameSave.SILVER_DOOR);
					if(GameSave.inRange(GameSave.IRON_DOOR))GameSave.setAward(GameSave.IRON_DOOR);
					_gameScreen.stopTicker();
					_screen.gameShift(onCallback);
				}
			}
			super.update(delta);
		}
		
		public override function render(bitmapData:BitmapData):void
		{
			if (!_gameMap.camera.onScreenParam(_pos, _renderMin, _renderMax)) return;
			var vector:Vector2D = _gameMap.cacheV2D.allocateV2D(_pos).addTo(_gameMap.pos);
			if (_colorDoor == Constants.ORANGE)
			{
				_animFlag.render(bitmapData, _gameMap.cacheV2D.allocateV2D(vector).subFromY(60));
			}
			_animDoor.render(bitmapData, vector, false);
		}
		
		public override function switchAnimDoor():void
		{
			graphics.clear();
			graphics.lineStyle(2,0xE5FF80,.5);
			graphics.beginFill(0xCCFF00,.5);
			graphics.drawRect( -Constants.DOOR_SIZE.x * .5, -Constants.DOOR_SIZE.y * .5,
								Constants.DOOR_SIZE.x, Constants.DOOR_SIZE.y);
			graphics.endFill();
		}
		
		private function get openDoor():Boolean
		{
			var open:Boolean;
			switch(_colorDoor)
			{
				case Constants.BLUE: open = _gameScreen.pikedKeyBlue;
					break;
				case Constants.GREEN: open = _gameScreen.pikedKeyGreen;
					break;
				case Constants.PURPLE: open = _gameScreen.pikedKeyPurple;
					break;
				case Constants.NONE: open = true;
					break;
			}
			return open;
		}
		
	}

}