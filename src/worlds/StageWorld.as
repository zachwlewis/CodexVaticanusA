package worlds 
{
	import entities.Actor;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import levels.Level;
	import net.flashpunk.Entity;
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
		public function get CollisionGrid():Entity { return _grid; }
		
		public function StageWorld() 
		{
			_level = new Level(Assets.LV_DEBUG);
			var i:Image = new Image(_level.getCollision().data);
			i.scale = 16.0;
			_grid = new Entity(0,0,i,_level.getCollision())
		}
		
		override public function begin():void 
		{
			
			
			
			var playerStart:Point = _level.getEntities("player")[0];
			var p:Actor = new Actor(playerStart.x, playerStart.y, new Image(new BitmapData(16, 16, true, 0xffff0000)), new Hitbox(16, 16, 0, 0));
			add(p);
			add(_grid);
			
			super.begin();
		}
		
		protected var _grid:Entity;
		protected var _level:Level;
		
	}

}