package entities.items 
{
	import entities.Actor;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	
	/**
	 * ...
	 * @author 
	 */
	public class Door extends Actor 
	{
		
		public function Door(x:Number=0, y:Number=0) 
		{
			var graphic:Image = new Image(Assets.GFX_DOOR);
			super(x, y, graphic, new Hitbox(64, 128));
			layer = 10;			
		}
		
	}

}