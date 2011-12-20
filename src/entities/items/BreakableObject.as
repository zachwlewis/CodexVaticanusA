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
		
		public function BreakableObject(x:Number, y:Number) 
		{
			var hitbox:Hitbox = new Hitbox(64, 64);
			type = "breakable";
			super(x, y, _sprite, hitbox);
		}
		
		override public function TakeHit():void 
		{
			this.collidable = false;
			layer = 10;
			_sprite.play("break");
			super.TakeHit();
		}
		
	}

}