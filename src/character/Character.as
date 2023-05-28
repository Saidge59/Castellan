package character
{
	import physics.PhysicsObject;
	import maths.Vector2D;
	
	/**
	 * ...
	 * @author falcon12
	 */
	public class Character extends PhysicsObject
	{
		//public var isDead:Boolean = false;
		protected var m_hurtTimer:int;
		
		public function Character()
		{
			
		}
		
		public override function update(delta:Number):void
        {
            if ( m_hurtTimer > 0 )
			{
				m_hurtTimer--;
			}
            super.update(delta);
            return;
        }
		
		public function set direction(direction:int):void
		{
			this.scaleX = direction;
		}
		
		public function hurt(p:Vector2D = null):void
        {
            throw ("Error :: Character hurt()");
        }

        public function get isHurt():Boolean
        {
            return this.m_hurtTimer != 0;
        }
		
	}
	
}