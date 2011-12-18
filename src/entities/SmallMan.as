package entities 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author 
	 */
	public class SmallMan extends InputActor 
	{
		
		public function SmallMan(x:int, y:int) 
		{
			_image = new Spritemap(Assets.GFX_ANI_SMALLMAN, 64, 64);;
			Spritemap(_image).add("idle-wait", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2,  1,  2, 0, 0, 0, 0, 0], .03, false);
			Spritemap(_image).add("idle", [2, 0, 1], .0725  , true);
			Spritemap(_image).add("jump", [6, 7], 0.1, false);
			Spritemap(_image).add("run", [3, 4, 5, 4], 0.105, true);
			
			_image.y = -4;
			_image.x = -15;
			
			super(x, y + 6, _image, new Hitbox(41, 59));
		}
		
		override protected function updateInput():void 
		{
			super.updateInput();
			if (Spritemap(_image).currentAnim != "jump")
			{
				if (!OnGround)
				{
					if (_v.y > 0)
					{
						Spritemap(_image).setFrame(0,2)
					}
					else
					{
						Spritemap(_image).setFrame(3,1);
					}
				}
				else
				{
		
					if (_ix != 0)
					{
						Spritemap(_image).play("run", false);
					}
					else
					{
						Spritemap(_image).play("idle");
					}
				}
			}
		}
		
		
		private function startIdleCycle():void
		{
			trace("done");
			Spritemap(_image).play("idle", false, 0);
			Spritemap(_image).callback = null;
			
		}		
	}
}