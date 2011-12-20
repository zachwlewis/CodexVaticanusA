package entities.items 
{
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author 
	 */
	public class BreakablePot extends BreakableObject 
	{
		
		public function BreakablePot(x:Number, y:Number) 
		{
			_sprite = new Spritemap(Assets.GFX_POT, 64, 64)
			_sprite.add("break", [1, 2], 0.05, false);
			super(x, y);
		}
		
	}

}