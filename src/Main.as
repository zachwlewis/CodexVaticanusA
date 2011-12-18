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
	[SWF(width="1024", height="768")]
	public class Main extends Engine 
	{

		public function Main():void 
		{
			super(1024, 768, 60, true);
		}

		override public function init():void 
		{
			trace("FP Started.");
			//FP.console.enable();
			FP.world = new StageWorld();
			super.init();
		}

	}

}