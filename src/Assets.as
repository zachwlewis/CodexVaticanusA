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
		
		[Embed(source='../levels/base.oel', mimeType='application/octet-stream')]
		public static const LV_BASE:Class;
		
		[Embed(source = '../gfx/editor/player.png')]
		public static const GFX_ASSHOLE:Class;
	}

}