package entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author 
	 */
	public class Actor extends Entity 
	{
		public function get Velocity():Point { return _v; }
		public function set Velocity(value:Point):void { Velocity = value.clone(); }
		
		public function get Acceleration():Point { return _a; }
		public function set Acceleration(value:Point):void { Acceleration = value.clone(); }
		
		public function Actor(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
		}
		
		override public function update():void 
		{
			updateAcceleration();
			updateVelocity();
			updatePosition();
			super.update();
		}
		
		protected function updateAcceleration():void
		{
			
		}
		
		protected function updateVelocity():void
		{
			
		}
		
		protected function updatePosition():void
		{
			
		}
		
		protected var _a:Point;
		protected var _v:Point;
		protected var _s:Point;
		
	}

}