package entities.items 
{
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author 
	 */
	public class BreakableStone extends BreakableObject 
	{
		
		public function BreakableStone(x:Number, y:Number) 
		{
			
			_sprite = new Spritemap(Assets.GFX_BREAKABLE_STONE, 128, 128);
			_sprite.add("break", [1, 2, 3], 0.2, false);
			_sprite.x = -32;
			_sprite.y = -32;
			super(x, y);
			_hasPhysics = false;
		}
		
	}

}