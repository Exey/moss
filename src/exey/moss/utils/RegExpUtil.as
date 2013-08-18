package exey.moss.utils 
{
	/**
	 * Collection of useful regexpes
	 * @author Exey Panteleev
	 */
	public class RegExpUtil
	{
		static public const EXTRACT_FILENAME:RegExp = /(\w|[-.])+$/;
		
		static public function filenameFromUrl(url:String):String { return url.match(RegExpUtil.EXTRACT_FILENAME)[0]; }
		
	}
}