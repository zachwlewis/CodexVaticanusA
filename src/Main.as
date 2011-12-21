package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.SharedObject;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.StageWorld;

	/**
	 * ...
	 * @author 
	 */
	[SWF(width="1706", height="960")]
	public class Main extends Engine 
	{

		public function Main():void 
		{
			super(1706, 960, 60, true);
			FP.screen.color = 0x12120E;
			V.Shared = SharedObject.getLocal("saves", null, false);
			V.LevelData = V.Shared.data["LevelData"];
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