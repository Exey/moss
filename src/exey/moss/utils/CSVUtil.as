package exey.moss.utils 
{
	/**
	 * Work with CSV
	 * @author Exey Panteleev
	 */
	public class CSVUtil 
	{		
		static public function parse(source:String):Array {
			var result:Array = [];
			var lines:Array = source.split("\r\n");
			for (var i:int = 0; i < lines.length; i++) {
				result[i] = lines[i].split(";");
			}
			return result;
		}
		
	}
}