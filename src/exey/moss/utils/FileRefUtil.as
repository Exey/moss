package exey.moss.utils 
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class FileRefUtil 
	{
		
		static public function getFileName(path:String, withExtension:Boolean = false):String 
		{
			var name:String;
			var pathSplit:Array = path.split("/");
			name = pathSplit[pathSplit.length - 1];
			if (!withExtension)
				name = name.split(".")[0]
			return name
		}
		
	}

}