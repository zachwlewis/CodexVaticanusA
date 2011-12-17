package entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Grid;
	import worlds.StageWorld;
	
	/**
	 * ...
	 * @author 
	 */
	public class Actor extends Entity 
	{
		public function get Velocity():Point { return _v; }
		public function set Velocity(value:Point):void { Velocity = value.clone(); }
		
		public function get Acceleration():Point { return _a; }
		public function set Acceleration(value:Point):void { Acceleration = value.clone(); }
		
		public function get Position():Point { return _s; }
		public function set Position(value:Point):void { Position = value.clone(); }
		
		public function Actor(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			_a = new Point(0, C.G);
			_v = new Point();
			_s = new Point(x, y);			
		}
		
		override public function added():void 
		{
			if (StageWorld(world) != null)
			{
				_collision = StageWorld(world).CollisionGrid;
			}
			else
			{
				_collision = null;
			}
			super.added();
		}
		
		override public function update():void 
		{
			var elapsedTime:Number = 1 / FP.elapsed;
			updateAcceleration(elapsedTime);
			updateVelocity(elapsedTime);
			updatePosition(elapsedTime);
			snapToGrid();
			super.update();
		}
		
		protected function updateAcceleration(dt:Number):void
		{
			// Acceleration is a constant. We don't really do much here, really.
		}
		
		protected function updateVelocity(dt:Number):void
		{
			// Velocity is the integral of acceleration. ∫a*dt = t*a + c
			_v.y += _a.y * dt;
			
			// Make sure we don't exceed our terminal velocity.
			_v.y = Math.min(_v.y, C.V_TERMINAL);
			
			// We can only speed up or slow down on the ground.
			// Apply our friction to slow us down.
			_v.x += _a.x * dt;
			if (OnGround)
			{
				
				if (_a.x == 0 || FP.sign(_a.x) != FP.sign(_v.x)) _v.x *= 1 - C.F_DEFAULT;
			}
			else
			{
				
			}
			// Also, put a stop to high-speed funny business.
			_v.x = FP.clamp(_v.x, -_vMax, _vMax);
		}
		
		protected function updatePosition(dt:Number):void
		{
			// Position is the integral of velocity. ∫v*dt = t*v + c
			// We also want to check for collisions here.
			if (_collision != null)
			{
				// Handle x-collisions.
				_s.x += _v.x;
				if (collideWith(_collision, _s.x, _s.y))
				{
					// Okay, that didn't work. Let's back up to the nearest grid position.
					if (FP.sign(_v.x) > 0)
					{
						_s.x = Math.floor((_s.x + width) / C.GS) * C.GS  - width;
					}
					else
					{
						_s.x = (Math.floor(_s.x  / C.GS) + 1) * C.GS;
					}
					
					// Also, we need to stop moving.
					_v.x = 0;
				}
				
				// Handle y-collisions.
				_s.y += _v.y;
				if (collideWith(_collision, _s.x, _s.y))
				{
					// Backup again.
					if (FP.sign(_v.y) > 0)
					{
						_s.y = Math.floor((_s.y+height) / C.GS) * C.GS - height;
					}
					else
					{
						_s.y = (Math.floor(_s.y / C.GS) + 1) * C.GS;
					}
					
					// Please, stop moving.
					_v.y = 0;
				}
			}
			else
			{
				_s.x += _v.x * dt;
				_s.y += _v.y * dt;
			}
		}
		
		public function get OnGround():Boolean { return (collideWith(_collision, _s.x, _s.y + 1) != null); }
		
		protected function snapToGrid():void
		{
			// Update our entity's x and y so we're aligned to the grid.
			// This prevents sprite jitter and render weirdness.
			x = Math.floor(_s.x);
			y = Math.floor(_s.y);
		}
		
		protected var _a:Point;
		protected var _v:Point;
		protected var _s:Point;
		protected var _collision:Entity;
		
		/** Horizontal acceleration of input. */
		protected var _ah:Number = C.A_HORIZONTAL;
		
		/** Maximum horizontal speed. */
		protected var _vMax:Number = C.V_MAX_HORIZONTAL;
		
		/** Default jump velocity. */
		protected var _vj:Number = C.V_JUMP;
		
	}

}