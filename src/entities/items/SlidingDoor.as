package entities.items 
{
	import entities.Actor;
	import flash.geom.Point;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import worlds.StageWorld;
	
	/**
	 * ...
	 * @author 
	 */
	public class SlidingDoor extends Actor 
	{
		public function get Open():Boolean { return _open; }
		public function set Open(value:Boolean):void
		{
			_open = value;
			collidable = !_open;
			if (_open)
			{
				x = _openPosition.x;
				y = _openPosition.y;
			}
			else
			{
				x = _closedPosition.x;
				y = _closedPosition.y;
			}
		}
		
		public function SlidingDoor(loaderData:XML) 
		{
			var x:Number = loaderData.@x;
			var y:Number = loaderData.@y;
			_image = new Image(Assets.GFX_SLIDINGDOOR);
			_closedPosition = new Point(x, y);
			_openPosition = new Point(Number(loaderData.node[0].@x), Number(loaderData.node[0].@y));
			_open = false;
			_objectID = uint(loaderData.@objectID);
			_triggerType = loaderData.@triggerType;
			_triggerID = loaderData.@triggerID;
			super(x, y, _image, new Hitbox(32, 64));
			_hasPhysics = false;
			_props = ["Open"];
			_openTween = new LinearMotion(tweenFinished, Tween.PERSIST);
			addTween(_openTween);
			type = "slidingdoor";
		}
		
		override protected function loadData():void 
		{
			
			super.loadData();
			Open = V.GetLevelData(StageWorld(world).InternalMapName, _triggerType, _triggerID)["Enabled"];
			
		}
		
		protected function tweenFinished():void
		{
			Open = _open;
		}
		
		protected function SlideOpen(state:Boolean):void
		{
			_open = state;
			collidable = true;
			if (_open)
			{
				_openTween.setMotionSpeed(x, y, _openPosition.x, _openPosition.y, C.V_DOOR_OPENING);
			}
			else
			{
				_openTween.setMotionSpeed(x, y, _closedPosition.x, _closedPosition.y, C.V_DOOR_OPENING);
			}
			_openTween.start();
			saveData();
		}
		
		override public function update():void 
		{
			var en:Boolean = V.GetLevelData(StageWorld(world).InternalMapName, _triggerType, _triggerID)["Enabled"];
			if (en != _open) { SlideOpen(en); }
			
			if (_openTween.active)
			{
				x = _openTween.x;
				y = _openTween.y;
			}
			super.update();
		}
		
		protected var _closedPosition:Point;
		protected var _openPosition:Point;
		protected var _open:Boolean;
		protected var _triggerType:String;
		protected var _triggerID:uint;
		protected var _openTween:LinearMotion;
		
	}

}