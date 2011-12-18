package entities 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	/**
	 * ...
	 * @author 
	 */
	public class SmallMan extends InputActor 
	{
		
		public function SmallMan(x:int, y:int) 
		{
			_image = new Spritemap(Assets.GFX_ANI_SMALLMAN, 64, 64);;
			//Spritemap(_image).add("idle", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2,  1,  2, 0, 0, 0, 0, 0], .03, true);
			Spritemap(_image).add("idle", [2,0,1], .0725, true);
			_image.y = -4;
			_image.x = -15;
			
			super(x, y + 4, _image, new Hitbox(41, 60));
		}
		
		override protected function updateInput():void 
		{
			super.updateInput();
			if (_ix != 0 || _iy != 0) Spritemap(_image).setFrame(0, 0);
			else Spritemap(_image).play("idle", false);
		}
		
	}

}