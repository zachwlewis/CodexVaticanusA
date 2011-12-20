package levels 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	/**
	 * ...
	 * @author 
	 */
	public class Level 
	{
		private var xmlData:XML;
		
		public function Level(map:Class)
		{
			xmlData = FP.getXML(map);
		}
		
		/**
		 * Parses the map file for collision data and generates a grid.
		 * @return collision data for the map
		 */
		public function getCollision():Grid
		{
			var g:Grid = new Grid(uint(xmlData.@width), uint(xmlData.@height), 16, 16, 0, 0);
			g.usePositions = true;
			var o:XML;
			
			for each (o in xmlData.collision.rect)
			{
				g.setRect(uint(o.@x), uint(o.@y), uint(o.@w), uint(o.@h), true);
			}
			
			return g;
		}
		
		public function getForeground():Image
		{
			var fg:Image;
			if (String(xmlData.@foregroundArt) != "none")
			{
				fg = new Image(Assets[String(xmlData.@foregroundArt)]);
			}
			else
			{
				fg = new Image(getCollision().data);
				fg.scale = 16;
				fg.color = 0x4D4D3A;
			}
			
			return fg;
		}
		
		public function getEntities(type:String):Vector.<Point>
		{
			var v:Vector.<Point> = new Vector.<Point>();
			var o:XML;
			for each (o in xmlData.entities[type])
			{
				v.push(new Point(Number(o.@x), Number(o.@y)));
			}
			return v;
		}
		
		public function getEntitiesAsXML(type:String):XMLList
		{
			return xmlData.entities[type];
		}
		
	}

}