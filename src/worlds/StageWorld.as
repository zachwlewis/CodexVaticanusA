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
	import flash.display.InterpolationMethod;
	import flash.geom.Point;
	import levels.Level;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.Sfx;
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
			_level = new Level(Assets.LV_DEBUG);
			_bgm = new Sfx(Assets.BG_INTRO,switchSong);
			_bgm.play();
			_tutorialState = 0;
		}
		
		override public function begin():void 
		{			
			loadLevel(_level);
			
			super.begin();
		}
		
		protected function switchSong():void
		{
			_bgm = new Sfx(Assets.BG_WORLD1);
			_bgm.loop();
		}
		
		protected function unloadLevel(loadTarget:Level):void
		{
			//unload current shit.
			var a:Array = [];
			getAll(a);
			for each(var e:Entity in a)
			{
				if (e != _player)
				{
					remove(e);
				}
			}
		}
		
		protected function loadLevel(loadTarget:Level, targetID:int = -1):void
		{
			var p:Point;
			var o:XML;

			_grid = new Entity(0, 0, loadTarget.getForeground(), loadTarget.getCollision());
			if (_player == null || _player.world != this)
			{
				if (loadTarget.getEntities("jumpman").length > 0) { _player = JumpMan(add(new JumpMan(loadTarget.getEntities("jumpman")[0].x, loadTarget.getEntities("jumpman")[0].y)))};
				if (loadTarget.getEntities("smallman").length > 0) { _player = SmallMan(add(new SmallMan(loadTarget.getEntities("smallman")[0].x, loadTarget.getEntities("smallman")[0].y)))};
				if (loadTarget.getEntities("strongman").length > 0) { _player = StrongMan(add(new StrongMan(loadTarget.getEntities("strongman")[0].x, loadTarget.getEntities("strongman")[0].y))) };
			}
			if (loadTarget.getEntities("breakablepot").length > 0)
			{
				for each (p in loadTarget.getEntities("breakablepot"))
				{
					add(new BreakablePot(p.x, p.y));
				}
			}
			if (loadTarget.getEntities("breakablestone").length > 0)
			{
				for each (p in loadTarget.getEntities("breakablestone"))
				{
					add(new BreakableStone(p.x, p.y));
				}
			}
			
			if (loadTarget.getEntities("door").length > 0)
			{
				for each (o in loadTarget.getEntitiesAsXML("door"))
				{
					trace(o.@objectID);
					trace("Door target: " + targetID);
					var d:Door = new Door(Number(o.@x), Number(o.@y), o.@targetMap, uint(o.targetID), uint(o.objectID))
					if (d.ObjectID == targetID)
					{
						_player.Position.x = d.x + d.halfWidth - _player.halfWidth;
						_player.Position.y = d.y + d.height - _player.height;
						trace("Placed player." + _player.x, _player.y);
					}
					add(d);					
				}
			}
			
			add(_grid);
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
		
		public function changeLevel(levelName:String, spawnTarget:int = -1):void
		{
			if (Assets[levelName] != null)
			{
				if (levelName == "LV_BASE")
				{
					switch(_tutorialState)
					{
						case 0:
							//Small man
							levelName = "LV_STRONG1";
							spawnTarget = -1;
							remove(_player);
							_player = null;
							break;
						case 1:
							// Strong man
							remove(_player);
							_player = null;
							spawnTarget = -1;
							levelName = "LV_JUMP1";
							break;
						case 2:
							// Jump Man
							break;
						default:
							// no man
							break;
					}
					_tutorialState++
				}
				
				// Load the level!
				var tempLevel:Level = new Level(Assets[levelName]);
				unloadLevel(_level);
				_level = tempLevel;
				loadLevel(_level,spawnTarget);
			}
		}
		protected var _tutorialState:uint;
		protected var _grid:Entity;
		protected var _level:Level;
		protected var _player:InputActor;
		protected var _bgm:Sfx;
		
	}

}