package exey.moss.utils 
{
	/**
	 * Repeated characters replace(/(\w)\1+/g,'$1');
	 * 
	 * Collection of useful regexpes
	 * @author Exey Panteleev
	 */
	public class RegExpUtil
	{
		static public const EXTRACT_FILENAME:RegExp = /(\w|[-.])+$/;
		
		static public function filenameFromUrl(url:String):String { return url.match(RegExpUtil.EXTRACT_FILENAME)[0]; }
		
		static public function filenameWithoutExtFromUrl(url:String):String {return url.slice(url.lastIndexOf("/")+1, url.lastIndexOf(".")); }
		
	}
}