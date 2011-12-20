package  
{
	/**
	 * ...
	 * @author 
	 */
	public class Assets 
	{
		[Embed(source='../levels/debug.oel', mimeType='application/octet-stream')]
		public static const LV_DEBUG:Class;
		
		[Embed(source='../levels/small_tutorial_1.oel', mimeType='application/octet-stream')]
		public static const LV_SMALL1:Class;
		
		[Embed(source='../levels/small_tutorial_2.oel', mimeType='application/octet-stream')]
		public static const LV_SMALL2:Class;
		
		[Embed(source='../levels/jump_tutorial_1.oel', mimeType='application/octet-stream')]
		public static const LV_JUMP1:Class;
		
		[Embed(source='../levels/jump_tutorial_2.oel', mimeType='application/octet-stream')]
		public static const LV_JUMP2:Class;
		
		[Embed(source='../levels/strong_tutorial_1.oel', mimeType='application/octet-stream')]
		public static const LV_STRONG1:Class;
		
		[Embed(source = '../levels/map_debug.png')]
		public static const MAP_DEBUG:Class;
		
		[Embed(source='../levels/base.oel', mimeType='application/octet-stream')]
		public static const LV_BASE:Class;
		
		[Embed(source = '../levels/map_base.png')]
		public static const MAP_BASE:Class;
				
		[Embed(source = '../gfx/characters/smallman_animated.png')]
		public static const GFX_ANI_SMALLMAN:Class;
		
		[Embed(source = '../gfx/characters/strongman_animated.png')]
		public static const GFX_ANI_STRONGMAN:Class;
		
		[Embed(source = '../gfx/editor/jumpman.png')]
		public static const GFX_JMP_ASSHOLE:Class;
		
		[Embed(source = '../gfx/items/breakable_pot.png')]
		public static const GFX_POT:Class;
		
		[Embed(source = '../gfx/items/breakable_stone.png')]
		public static const GFX_BREAKABLE_STONE:Class;
		
		[Embed(source = '../gfx/items/door.png')]
		public static const GFX_DOOR:Class;
	}

}