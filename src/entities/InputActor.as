package entities 
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * An Actor that takes in player input.
	 * @author 
	 */
	public class InputActor extends Actor 
	{
		
		public function InputActor(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			
		}
		
		override public function update():void 
		{
			updateInput();
			super.update();
		}
		
		protected function updateInput():void
		{
			_ix = 0;
			_iy = 0;
			if (Input.check(Key.LEFT)) _ix--;
			if (Input.check(Key.RIGHT)) _ix++;
			if (Input.check(Key.DOWN)) _iy++;
			if (Input.check(Key.UP)) _iy--;
			if (Input.pressed(Key.SPACE)) jump();
			
			// Only handle horizontal input now.
			// Some InputActors may use it, though.
		}
		
		protected function jump():void
		{
			if (OnGround)
			{
				_v.y = _vj;
			}
		}
		
		override protected function updateAcceleration(dt:Number):void 
		{
			super.updateAcceleration(dt);
			_a.x = _ix * _ah;
		}
		
		protected var _ix:int, _iy:int;
	}

}