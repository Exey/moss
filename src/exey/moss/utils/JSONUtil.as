package exey.moss.utils 
{
	/**
	 * Work with JSON
	 * @author Exey Panteleev
	 */
	public class JSONUtil 
	{ 
		
		static public function getRootElementName(json:Object):String 
		{
			for (var name:String in json) 
				return name
			return undefined
		}
	}

}