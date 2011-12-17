package worlds 
{
	import entities.Actor;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import levels.Level;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author 
	 */
	public class StageWorld extends World 
	{
		protected var _grid:Grid;
		protected var _level:Level;
		
		public function StageWorld() 
		{
			_level = new Level(Assets.LV_DEBUG);
			_grid = _level.getCollision();
		}
		
		override public function begin():void 
		{
			var i:Image = new Image(_grid.data);
			i.scale = 16.0;
			addGraphic(i);
			
			var playerStart:Point = _level.getEntities("player")[0];
			var p:Actor = new Actor(playerStart.x, playerStart.y, new Image(new BitmapData(16, 16, true, 0xffff0000)), new Hitbox(16, 16, 0, 0));
			add(p);
			
			super.begin();
		}
		
	}

}