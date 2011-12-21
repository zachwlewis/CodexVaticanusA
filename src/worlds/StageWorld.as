package worlds 
{
	import entities.Actor;
	import entities.InputActor;
	import entities.items.BreakableObject;
	import entities.items.BreakablePot;
	import entities.items.BreakableStone;
	import entities.items.Door;
	import entities.items.SlidingDoor;
	import entities.items.WallSwitch;
	import entities.JumpMan;
	import entities.SmallMan;
	import entities.StrongMan;
	import flash.display.BitmapData;
	import flash.display.InterpolationMethod;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import levels.Level;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.CircularMotion;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.tweens.misc.NumTween
	import tools.DebugToolbar;
	
	/**
	 * ...
	 * @author 
	 */
	public class StageWorld extends World 
	{
		public function get CollisionGrid():Entity { return _grid; }
		
		public var MapName:String;
		public function get InternalMapName():String { return _level.Name; }
		
		
		public function StageWorld() 
		{
			// Decide what level to load. 
			MapName = C.ENTRY_MAP;
			_level = new Level(Assets[C.ENTRY_MAP]);
			_bgm = new Sfx(Assets.BG_INTRO,switchSong);
			_bgm.play();
			_tutorialState = 0;
		}
		
		override public function begin():void 
		{			
			var glow:Image = new Image(Assets.GFX_GLOW);
			glow.centerOO();
			_glowTween = new CircularMotion(null,Tween.LOOPING)
			_glowTween.setMotion(.3, 0, .1, 0, false, 400);			
			_playerGlow = addGraphic(glow, -1);
			addTween(_glowTween, true);
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
				if (e != _player && e != _playerGlow)
				{
					remove(e);
				}
			}
		}
		
		protected function loadLevel(loadTarget:Level, targetID:int = -1):void
		{
			var p:Point;
			var o:XML;
			_grid = new Entity(0, 0, loadTarget.ForegroundTiles, loadTarget.Collision);
			_playerGlow.visible = !_level.WellLit;
			addGraphic(_level.Background, 20);
			
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
					var d:Door = new Door(Number(o.@x), Number(o.@y), o.@targetMap, uint(o.@targetID), uint(o.@objectID))
					if (d.ObjectID == targetID)
					{
						_player.Position.x = d.x + d.halfWidth - _player.halfWidth;
						_player.Position.y = d.y + d.height - _player.height;
					}
					add(d);					
				}
			}
			
			for each (o in loadTarget.getEntitiesAsXML("switch"))
			{
				var s:WallSwitch = new WallSwitch(o);
				add(s);
			}
			
			for each (o in loadTarget.getEntitiesAsXML("slidingdoor"))
			{
				var sd:SlidingDoor = new SlidingDoor(o);
				add(sd);
			}
			
			add(_grid);
		}
		
		override public function update():void 
		{
			super.update();
			centerCameraOnPlayer();
			Image(_playerGlow.graphic).alpha = _glowTween.x;
			debugInput();
		}
		
		protected function debugInput():void
		{
			if (Input.pressed(Key.T) && Input.check(Key.CONTROL) && Input.check(Key.SHIFT))
			{
				if (_debug == null)
				{
					_debug = new DebugToolbar(this);
					FP.stage.addChild(_debug);				
				}
				else
				{
					FP.stage.removeChild(_debug);
					_debug = null;
				}
			}
		}
		
		protected function centerCameraOnPlayer():void
		{
			FP.camera.x = FP.clamp(_player.centerX - FP.screen.width / 2, 0, _grid.width - FP.screen.width - 22);
			FP.camera.y = FP.clamp(_player.centerY - FP.screen.height / 2, 0, _grid.height - FP.screen.height); // FUCK OFF
			_playerGlow.x = _player.centerX;
			_playerGlow.y = _player.centerY;
		}
		
		public function changeLevel(levelName:String, spawnTarget:int = -1):void
		{
			if (Assets[levelName] != null)
			{
				MapName = levelName;
				_player.Velocity.x = 0;
				_player.Velocity.y = 0;
				if (levelName == "LV_BASE")
				{
					switch(_tutorialState)
					{
						case 0:
							//Small man
							levelName = "LV_SMALL1";
							spawnTarget = -1;
							remove(_player);
							_player = null;
							break;
						case 1:
							// Strong man
							remove(_player);
							_player = null;
							spawnTarget = -1;
							levelName = "LV_STRONG1";
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
		
		public function forceLevelLoad(mapData:Object):void
		{
			removeAll();
			_player = null;
			
			_level = new Level(mapData);
			loadLevel(_level);
		}
		
		protected var _tutorialState:uint;
		protected var _grid:Entity;
		protected var _level:Level;
		protected var _player:InputActor;
		protected var _playerGlow:Entity;
		protected var _glowTween:CircularMotion;
		protected var _bgm:Sfx;
		protected var _debug:DebugToolbar;
	}

}