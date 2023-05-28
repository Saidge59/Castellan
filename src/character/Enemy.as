package character 
{
	import controller.PropertiesController;
	import gamemenu.GameSave;
	import geometry.AABB;
	import graphics.Animation;
	import maths.Vector2D;
	/**
	 * ...
	 * @author falcon12
	 */
	public class Enemy extends Character
	{
        public static const TIME_SLEEP:int = 150;
		public static const TIME_BEMUSED:int = 72;
		
		protected var _prpCntr:PropertiesController;
		protected var _helmetState:int = Helmet.RUNS;
		protected var _oldHelmetState:int;
		protected var _oldScaleX:int;
		protected var _helmetAnim:Animation;
		protected var _colorHelmet:int;
		protected var _speedMoving:int;
		protected var _speedWalk:int = 75;
		protected var _speedChase:int = 250;
		protected var _currentTime:int = 0;
		
		protected var L_Runs:String = "";
		protected var R_Runs:String = "";
		protected var L_Attaks:String = "";
		protected var R_Attaks:String = "";
		protected var L_Sleeps:String = "";
		protected var R_Sleeps:String = "";
		protected var L_Bemused:String = "";
		protected var R_Bemused:String = "";

       public function Enemy()
        {
			_helmetAnim = new Animation();
			_helmetAnim.addAnim("HlmtOrng_attaksR_mc", "attaksR_Orange");
			_helmetAnim.addAnim("HlmtOrng_attaksL_mc", "attaksL_Orange");
			_helmetAnim.addAnim("HlmtOrng_sleepsR_mc", "sleepsR_Orange");
			_helmetAnim.addAnim("HlmtOrng_sleepsL_mc", "sleepsL_Orange");
			_helmetAnim.addAnim("HlmtOrng_runsR_mc", "runsR_Orange");
			_helmetAnim.addAnim("HlmtOrng_runsL_mc", "runsL_Orange");
			_helmetAnim.addAnim("HlmtOrng_bemusedR_mc", "bemusedR_Orange");
			_helmetAnim.addAnim("HlmtOrng_bemusedL_mc", "bemusedL_Orange");
			
			_helmetAnim.addAnim("HlmtGreen_attaksR_mc", "attaksR_Green");
			_helmetAnim.addAnim("HlmtGreen_attaksL_mc", "attaksL_Green");
			_helmetAnim.addAnim("HlmtGreen_sleepsR_mc", "sleepsR_Green");
			_helmetAnim.addAnim("HlmtGreen_sleepsL_mc", "sleepsL_Green");
			_helmetAnim.addAnim("HlmtGreen_runsR_mc", "runsR_Green");
			_helmetAnim.addAnim("HlmtGreen_runsL_mc", "runsL_Green");
			_helmetAnim.addAnim("HlmtGreen_bemusedR_mc", "bemusedR_Green");
			_helmetAnim.addAnim("HlmtGreen_bemusedL_mc", "bemusedL_Green");
			
			_helmetAnim.addAnim("HlmtBlue_attaksR_mc", "attaksR_Blue");
			_helmetAnim.addAnim("HlmtBlue_attaksL_mc", "attaksL_Blue");
			_helmetAnim.addAnim("HlmtBlue_sleepsR_mc", "sleepsR_Blue");
			_helmetAnim.addAnim("HlmtBlue_sleepsL_mc", "sleepsL_Blue");
			_helmetAnim.addAnim("HlmtBlue_runsR_mc", "runsR_Blue");
			_helmetAnim.addAnim("HlmtBlue_runsL_mc", "runsL_Blue");
			_helmetAnim.addAnim("HlmtBlue_bemusedR_mc", "bemusedR_Blue");
			_helmetAnim.addAnim("HlmtBlue_bemusedL_mc", "bemusedL_Blue");
			
			_helmetAnim.addAnim("HlmtPrpl_attaksR_mc", "attaksR_Purple");
			_helmetAnim.addAnim("HlmtPrpl_attaksL_mc", "attaksL_Purple");
			_helmetAnim.addAnim("HlmtPrpl_sleepsR_mc", "sleepsR_Purple");
			_helmetAnim.addAnim("HlmtPrpl_sleepsL_mc", "sleepsL_Purple");
			_helmetAnim.addAnim("HlmtPrpl_runsR_mc", "runsR_Purple");
			_helmetAnim.addAnim("HlmtPrpl_runsL_mc", "runsL_Purple");
			_helmetAnim.addAnim("HlmtPrpl_bemusedR_mc", "bemusedR_Purple");
			_helmetAnim.addAnim("HlmtPrpl_bemusedL_mc", "bemusedL_Purple");
        }
		
		public override function free():void
		{
			_gameMap.enemies.remove(this);
			super.free();
		}
		
		public override function init(p:Vector2D):void
		{
			assignAnim();
			_gameMap.enemies.add(this);
			super.init(p);
		}
		
        override public function update(delta:Number):void
        {
           if (_gameMap.knight.isUsed)
			{
				var collided:Boolean = AABB.overlap(_gameMap.knight, this);
				if (collided && _helmetState != Helmet.SLEEPS)
				{
					if (_gameShift.isUsed) return;
					_gameMap.knight.hurt(_pos);
					if(GameSave.inRange(GameSave.MEAT))GameSave.setAward(GameSave.MEAT);
				}
			}
			
            super.update(delta);
        }
		
		protected function switchAnimHelmet():void
		{
			switch(_helmetState)
			{
				case Helmet.RUNS:
					if (this.scaleX == -1) _helmetAnim.switchAnim(L_Runs);
					else _helmetAnim.switchAnim(R_Runs);
					_speedMoving = _speedWalk;
					break;
				case Helmet.ATTAKS:
					if (this.scaleX == -1) _helmetAnim.switchAnim(L_Attaks);
					else _helmetAnim.switchAnim(R_Attaks);
					_speedMoving = _speedChase;
					break;	
				case Helmet.SLEEPS:
					if (this.scaleX == -1) _helmetAnim.switchAnim(L_Sleeps);
					else _helmetAnim.switchAnim(R_Sleeps);
					break;
				case Helmet.BEMUSED:
					if (this.scaleX == -1) _helmetAnim.switchAnim(L_Bemused);
					else _helmetAnim.switchAnim(R_Bemused);
					break;
			}
			if (_helmetState == Helmet.SLEEPS || _helmetState == Helmet.BEMUSED)
				_speedMoving = 0;
			
		}
	
		protected function assignAnim():void
		{
			if (_colorHelmet == Constants.ORANGE)
			{
				L_Runs = "runsL_Orange";
				R_Runs = "runsR_Orange";
				L_Attaks = "attaksL_Orange";
				R_Attaks = "attaksR_Orange";
				L_Sleeps = "sleepsL_Orange";
				R_Sleeps = "sleepsR_Orange";
				L_Bemused = "bemusedL_Orange";
				R_Bemused = "bemusedR_Orange";
			}
			else if (_colorHelmet == Constants.BLUE)
			{
				L_Runs = "runsL_Blue";
				R_Runs = "runsR_Blue";
				L_Attaks = "attaksL_Blue";
				R_Attaks = "attaksR_Blue";
				L_Sleeps = "sleepsL_Blue";
				R_Sleeps = "sleepsR_Blue";
				L_Bemused = "bemusedL_Blue";
				R_Bemused = "bemusedR_Blue";
			}
			else if (_colorHelmet == Constants.GREEN)
			{
				L_Runs = "runsL_Green";
				R_Runs = "runsR_Green";
				L_Attaks = "attaksL_Green";
				R_Attaks = "attaksR_Green";
				L_Sleeps = "sleepsL_Green";
				R_Sleeps = "sleepsR_Green";
				L_Bemused = "bemusedL_Green";
				R_Bemused = "bemusedR_Green";
			}
			else 
			{
				L_Runs = "runsL_Purple";
				R_Runs = "runsR_Purple";
				L_Attaks = "attaksL_Purple";
				R_Attaks = "attaksR_Purple";
				L_Sleeps = "sleepsL_Purple";
				R_Sleeps = "sleepsR_Purple";
				L_Bemused = "bemusedL_Purple";
				R_Bemused = "bemusedR_Purple";
			}
		}
		
		public function set colorHelmet(color:int):void
		{
			_colorHelmet = color;
			assignAnim();
		}

        protected function get speedMoving():Number
        {
            throw ("Error :: Enemy speedMoving");
        }

        public function get damageOnTouch():Boolean
        {
            throw ("Error :: Enemy damageOnTouch");
        }

		public function set pc(prpC:PropertiesController):void
		{
			_prpCntr = prpC;
		}
		
	}

}