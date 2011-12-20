package worlds 
{
	import entities.Actor;
	import entities.InputActor;
	import entities.items.BreakableObject;
	import entities.items.BreakablePot;
	import entities.items.BreakableStone;
	import entities.items.Door;
	import entities.JumpMan;
	import entities.SmallMan;
	import entities.StrongMan;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import levels.Level;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
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
			var p:Point;
			var o:XML;
			if (_level.getEntities("jumpman").length > 0) { _player = JumpMan(add(new JumpMan(_level.getEntities("jumpman")[0].x, _level.getEntities("jumpman")[0].y)))};
			if (_level.getEntities("smallman").length > 0) { _player = SmallMan(add(new SmallMan(_level.getEntities("smallman")[0].x, _level.getEntities("smallman")[0].y)))};
			if (_level.getEntities("strongman").length > 0) { _player = StrongMan(add(new StrongMan(_level.getEntities("strongman")[0].x, _level.getEntities("strongman")[0].y)))};
			if (_level.getEntities("breakablepot").length > 0)
			{
				for each (p in _level.getEntities("breakablepot"))
				{
					add(new BreakablePot(p.x, p.y));
				}
			}
			if (_level.getEntities("breakablestone").length > 0)
			{
				for each (p in _level.getEntities("breakablestone"))
				{
					add(new BreakableStone(p.x, p.y));
				}
			}
			
			if (_level.getEntities("door").length > 0)
			{
				for each (o in _level.getEntitiesAsXML("door"))
				{
					add(new Door(Number(o.@x), Number(o.@y), o.@targetMap, uint(o.targetID), uint(o.objectID)));
				}
			}
			
			add(_grid);
			
			super.begin();
		}
		
		override public function update():void 
		{
			super.update();
			centerCameraOnPlayer();
		}
		
		protected function centerCameraOnPlayer():void
		{
			FP.camera.x = FP.clamp(_player.x - FP.screen.width / 2, 0, _grid.width - FP.screen.width - 22);
			FP.camera.y = FP.clamp(_player.y - FP.screen.height / 2, 0, _grid.height - FP.screen.height); // FUCK OFF
		}
		
		protected var _grid:Entity;
		protected var _level:Level;
		protected var _player:InputActor;
		
	}

}