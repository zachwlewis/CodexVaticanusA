package  
{
	/**
	 * Game Variables
	 * @author 
	 */
	public class V 
	{
		public static var LevelData:Object;
		
		public static function SetLevelData(mapName:String, className:String, objectID:uint, values:Object):void
		{
			if (LevelData == null) LevelData = { };
			if (LevelData[mapName] == null) LevelData[mapName] = { };
			if (LevelData[mapName][className + objectID] == null) LevelData[mapName][className + objectID] = { };
			LevelData[mapName][className + objectID] = values;
		}
		
		public static function GetLevelData(mapName:String, className:String, objectID:uint):Object
		{
			if (LevelData == null) LevelData = { };
			if (LevelData[mapName] == null) LevelData[mapName] = { };
			if (LevelData[mapName][className + objectID] == null) LevelData[mapName][className + objectID] = { };
			return LevelData[mapName][className + objectID];
		}
	}

}