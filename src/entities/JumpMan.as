package entities 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	/**
	 * ...
	 * @author 
	 */
	public class JumpMan extends InputActor 
	{
		public function JumpMan(x:uint, y:uint)
		{
			_image = new Image(Assets.GFX_JMP_ASSHOLE);
			_image.y = -2;
			super(x, y + 2, _image, new Hitbox(12, 30));
			
			_vj = C.V_JUMP * 1.5;
		}
		
	}

}