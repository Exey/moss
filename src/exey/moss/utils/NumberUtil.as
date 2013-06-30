package exey.moss.utils
{
	/**
	 * Number utils
	 * @author Exey
	 */
	public class NumberUtil{
		
		/**
		 * Anologue on Number.toFixed() without rounding
		 * @param	value
		 * @param	fractionDigits
		 * @return
		 */
		static public function toFixedWithoutRound(value:Number, fractionDigits:uint):String
		{
			var s:String = String(value);
			var dotIndex:int = s.indexOf(".");
			if (dotIndex > 0)
				return s.substr(0, s.indexOf(".") + fractionDigits + 1);
			else
				return value.toFixed(fractionDigits);
		}
		
		static public function formatLength(value:Number, places:uint):String
		{
			var result:String = value.toString();
			while ( result.length < places ) {
				result = '0' + result;
			}
			return result;
		}
		
		static public function randRange(start:Number, end:Number) : Number
		{
			return Math.floor(start +(Math.random() * (end - start)));
		}
		
		static public function fixed(n:Number, fixed:uint = 0):Number 
		{
			return parseFloat(n.toFixed(fixed))
		}
	}

}