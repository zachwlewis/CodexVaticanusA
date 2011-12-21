package entities.items 
{
	import entities.Actor;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	import worlds.StageWorld;
	
	/**
	 * ...
	 * @author 
	 */
	public class WallSwitch extends Actor 
	{
		protected var _enabled:Boolean;
		public function get Enabled():Boolean { return _enabled; }
		public function set Enabled(value:Boolean):void
		{
			_enabled = value;
			if (_enabled) Spritemap(_image).setFrame(0,3);
			else Spritemap(_image).setFrame(0, 0);
		}
		
		public function WallSwitch(loaderData:XML) 
		{
			var x:Number = loaderData.@x;
			var y:Number = loaderData.@y;
			_objectID = uint(loaderData.@objectID);
			_enabled = Boolean(loaderData.@enabled == "True");
			_image = new Spritemap(Assets.GFX_ANI_SWITCH, 32, 32, switchFinished);
			layer = 8;
			type = "switch";
			Spritemap(_image).add("enable", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 1, false);
			Spritemap(_image).add("disable", [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0], 1, false);
			Spritemap(_image).setFrame(0, 0);
			super(x, y, _image, new Hitbox(32,32));
			_hasPhysics = false;
			_props = ["Enabled"];
		}
		
		public function useSwitch():void
		{
			if (_enabled)
			{
				// Disable the switch.
				Spritemap(_image).play("disable");
			}
			else
			{
				Spritemap(_image).play("enable");
			}
		}
		
		public function switchFinished():void
		{
			_enabled = !_enabled;
			trace("Switch flipped.", _enabled);
			saveData();
		}
		
	}

}