package worlds 
{
	import entities.Actor;
	import entities.InputActor;
	import entities.JumpMan;
	import entities.SmallMan;
	import entities.StrongMan;
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
			// Decide what level to load. 
			_level = new Level(Assets.LV_BASE);
			_grid = new Entity(0,0,_level.getForeground(),_level.getCollision())
		}
		
		override public function begin():void 
		{			
			if (_level.getEntities("jumpman").length > 0) { _player = JumpMan(add(new JumpMan(_level.getEntities("jumpman")[0].x, _level.getEntities("jumpman")[0].y)))};
			if (_level.getEntities("smallman").length > 0) { _player = SmallMan(add(new SmallMan(_level.getEntities("smallman")[0].x, _level.getEntities("smallman")[0].y)))};
			if (_level.getEntities("strongman").length > 0) { _player = StrongMan(add(new StrongMan(_level.getEntities("strongman")[0].x, _level.getEntities("strongman")[0].y)))};
			
			add(_grid);
			
			super.begin();
		}
		
		protected var _grid:Entity;
		protected var _level:Level;
		protected var _player:InputActor;
		
	}

}