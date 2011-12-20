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
		protected var _targetMap:String;
		protected var _targetID:uint;
		public function Door(x:Number, y:Number, targetMap:String, targetID:uint, objectID:uint) 
		{
			var graphic:Image = new Image(Assets.GFX_DOOR);
			super(x, y, graphic, new Hitbox(64, 128));
			layer = 10;
			_targetMap = targetMap;
			_targetID = targetID;
			_objectID = objectID;
			_hasPhysics = false;
			type = "door";
		}
		
		public function useDoor():void
		{
			
		}
		
	}

}