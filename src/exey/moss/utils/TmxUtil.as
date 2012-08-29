package exey.moss.utils
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class TmxUtil
	{
		
		/**
		 * Returns 2d array [y][x]
		 * Grabbed from flixel
		 * @param	csv
		 * @return
		 */
		static public function CSVtoArray2(csv:String):Array
		{
			var result:Array = [];
			var c:uint; // cols
			var r:uint; // rows
			var cols:Array;
			var rows:Array = csv.split("\n");
			var widthInTiles:uint;
			var heightInTiles:uint = rows.length;
			for (r = 0; r < heightInTiles; r++)
			{
				result[r] = []
				cols = rows[r].split(",");
				if (cols.length <= 1)
				{
					heightInTiles--;
					continue;
				}
				if(widthInTiles == 0)
					widthInTiles = cols.length;
				for (c = 0; c < widthInTiles; c++)
				{
					result[r][c] = cols[c];
				}
			}
			return result;
		}
		
		static public function printTMX():String
		{
			return ""
		}
	}
}