package entities 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	/**
	 * ...
	 * @author 
	 */
	public class SmallMan extends InputActor 
	{
		
		public function SmallMan(x:int, y:int) 
		{
			_image = new Image(Assets.GFX_ASSHOLE);
			_image.y = -4;
			_image.x = -5;
			
			super(x, y + 4, _image, new Hitbox(51, 60));
		}
		
	}

}