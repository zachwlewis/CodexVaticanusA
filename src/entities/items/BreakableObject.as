package entities.items 
{
	import entities.Actor;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	
	/**
	 * ...
	 * @author 
	 */
	public class BreakableObject extends Actor 
	{
		
		protected var _sprite:Spritemap;
		
		public function BreakableObject(x:int, y:int, graphic:Class, hitbox:Hitbox) 
		{
			_sprite = new Spritemap(graphic, 64, 64)
			_sprite.add("break", [1, 2], 0.05, false);
			super(x, y, _sprite, new Hitbox(hitbox.width,hitbox.height,hitbox.x, hitbox.y));
			type = "breakable";
			_hasPhysics = false;
		}
		
		override public function TakeHit():void 
		{
			this.collidable = false;
			_sprite.play("break");
			super.TakeHit();
		}
		
	}

}