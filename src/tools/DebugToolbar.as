package tools 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.*;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import levels.Level;
	import worlds.StageWorld;
	
	/**
	 * ...
	 * @author 
	 */
	public class DebugToolbar extends Sprite 
	{
		private var _file:FileReference;
		private var _world:StageWorld;
		private var _xml:XML;
		private var _toolbar:Sprite;
		
		public function DebugToolbar(world:StageWorld) 
		{
			_world = world;
			_toolbar = Sprite(addChild(new Assets.DBG_TOOLBAR()));
			_file = new FileReference();
			TextField(_toolbar["loadMap"]).addEventListener(MouseEvent.CLICK, load);
		}
		
		// LEVEL LOADING FUNCTIONALITY
		//----------------------------
		private function load(e:MouseEvent):void
		{
			trace("Load");
			_file.addEventListener(Event.SELECT, onSelect);
			_file.browse([new FileFilter("Ogmo Editor Maps", "*.oel", "*.oel")]);
		}
		
		private function onSelect(e:Event):void
		{
			_file.addEventListener(Event.COMPLETE, onComplete);
			_file.load();
			
		}
		
		private function onComplete(e:Event):void
		{
			_xml = new XML(e.target.data);
			_world.forceLevelLoad(_xml);
		}
		
	}

}