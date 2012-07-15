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
		static public function isJSON(text:String):Boolean {
			return !(/[^,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]/.test(text.replace(/"(\\.|[^"\\])*"/g,'')));
		}
		
		static public function capitalize(text:String):String {
			var firstChar:String = text.substr(0, 1);
			var restOfString:String = text.substr(1, text.length);
			return firstChar.toUpperCase()+restOfString.toLowerCase();
		}		
	}
}