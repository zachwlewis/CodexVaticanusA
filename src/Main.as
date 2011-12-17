package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.StageWorld;

	/**
	 * ...
	 * @author 
	 */
	[SWF(width="640", height="480")]
	public class Main extends Engine 
	{

		public function Main():void 
		{
			super(640, 480);
		}

		override public function init():void 
		{
			trace("FP Started.");
			FP.world = new StageWorld();
			super.init();
		}

	}

}