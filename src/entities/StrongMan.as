package entities
{
	import entities.items.BreakableObject;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author
	 */
	public class StrongMan extends InputActor
	{
		protected var _strikeZone:Entity;
		
		public function StrongMan(x:int, y:int)
		{
			_image = new Spritemap(Assets.GFX_ANI_STRONGMAN, 128, 128);
			Spritemap(_image).add("idle", [0, 1], .0725, true);
			Spritemap(_image).add("jump", [5, 6], 0.1, false);
			Spritemap(_image).add("run", [3, 2, 3, 4], 0.105, true);
			Spritemap(_image).add("attack", [7, 8], 0.11, false);
			this.type = "player";
			
			_image.y = -13;
			_image.x = -14;
			
			super(x, y + 13, _image, new Hitbox(97, 113));
		}
		
		override public function added():void 
		{
			_strikeZone = this.world.add(new Entity(0, 0, null, new Hitbox(32, 64)));
			super.added();
		}
		
		override protected function updateInput():void 
		{
			super.updateInput();
			if (Input.pressed(Key.Z)) attack();
			if (Spritemap(_image).currentAnim != "attack")
			{
				if (Spritemap(_image).currentAnim != "jump")
				{
					if (!OnGround)
					{
						if (_v.y > 0)
						{
							Spritemap(_image).setFrame(2,1)
						}
						else
						{
							Spritemap(_image).setFrame(1,1);
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
		}
		
		protected function attack():void
		{
			Spritemap(_image).play("attack");
			Spritemap(_image).callback = doneAttack;
		}
		
		protected function doneAttack():void
		{
			// Return the user to their default frame.
			Spritemap(_image).callback = null;
			Spritemap(_image).play("idle", true, 0);
			
			var p:Point = new Point;
			if (_image.flipped)
			{
				p.x = this.x - 32;
				p.y = this.y + 24;
			}
			else
			{
				p.x = this.x + this.width;
				p.y = this.y + 24;
			}
			
			_strikeZone.x = p.x;
			_strikeZone.y = p.y;
			
			// Check for breakable objects.
			var hits:Array = [];
			if (_strikeZone == null || _strikeZone.world == null)
			{
				_strikeZone = this.world.add(new Entity(0, 0, null, new Hitbox(32, 64)));
			}
			_strikeZone.collideTypesInto(["breakable"], p.x, p.y, hits);
			for each (var bo:BreakableObject in hits)
			{
				if (bo != null)
				{
					bo.TakeHit();
				}
			}
			
			//trace(hitThing);
			//hitThing.TakeHit();
			/*
			if (Entity(hitThing) != null)
			{
				trace("HIT THING IS REAL");
				//hitThing.TakeHit();
			}
			//*/
		}
		
		/*
		override public function render():void 
		{
			var i:Image = new Image(new BitmapData(16, 128, true, 0x66ff0000));
			var p:Point = new Point;
			if (_image.flipped)
			{
				p.x = this.x - 16;
				p.y = this.y;
			}
			else
			{
				p.x = this.x + this.width;
				p.y = this.y;
			}
			i.render(FP.buffer, p, FP.camera);
			super.render();
			
		}
		*/
	
	}

}