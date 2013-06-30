package exey.moss.utils 
{
	import flash.text.Font;
	/**
	 * Font Util
	 * @author Exey Panteleev
	 */
	public class FontUtil 
	{
		
		static public function isEmbed(fontName:String):Boolean
		{
			var embedFonts:Array = Font.enumerateFonts();
			for each (var f:Font in embedFonts) 
				if (f.fontName == fontName) return true;
			return false;
		}
		
	}
}