package exey.moss.utils 
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class StringUtil 
	{	
		/**
		 * Dirty method
		 * http://stackoverflow.com/questions/2583472/regex-to-validate-json
		 * @param	text
		 * @return Boolean
		 */
		static public function isJSON(text:String):Boolean
		{
			return !(/[^,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]/.test(text.replace(/"(\\.|[^"\\])*"/g,'')));
		}
		
		static public function multiplieReplace(sourсe:String, pattern:String, replace:String):String 
		{
			return sourсe.split(pattern).join(replace);
		}
		
		static public function capitalize(text:String):String
		{
			var firstChar:String = text.substr(0, 1);
			var restOfString:String = text.substr(1, text.length);
			return firstChar.toUpperCase()+restOfString.toLowerCase();
		}
		
		static public function replaceAll (str:String, from:String, to:String):String
		{
			var chunks:Array = str.split(from);
			var result:String = "";
			var sep:String = "";
			for (var i:int = 0; i < chunks.length; i++)
			{
				result += sep + chunks[i];
				sep = to;
			}
			return result;
		}
		
		static public function replace(input:String, replace:String, replaceWith:String):String{
			return input.split(replace).join(replaceWith);
		}
		
		static public function getI(i:int):String {
			var r:String = i.toString()
			while (String(r).length < 3) r = "0"+r
			return r;
		}
		
		
	}
}