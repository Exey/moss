package exey.moss.utils 
{
	/**
	 * Russian Language Utils
	 * @author Exey Panteleev
	 */
	public class RussianLangUtils
	{		
		/**
		 * Chooses variant of declension dependent on the number
		 * @usage
		 * 	<code>
		 * 		numericDeclension(73, "Монета", "Монеты", "Монет"); // returns Монеты
		 * 		numericDeclension(38, "Попугай", "Попугая", "Попугаев"); // returns Попугаев
		 *  </code>
		 */
		static public function numericDeclension(number:Number, nominative:String, genitive:String, plural:String):String
		{
			var lastDidit:int = int(String(number).match(/(.)$/)[0]);
			if (int(String(number).match(/1.$/)))
				return plural;
			if (lastDidit == 1)
				return nominative;
			else if (lastDidit > 0 && lastDidit < 5)
				return genitive;
			else
				return plural;				
		}
		
	}

}