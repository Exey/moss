package exey.moss.utils
{
/**
 * ...
 * @author Exey Panteleev
 */
	public class ArrayUtil {
		
		/**
		 * Counting the properties(with specified value) of elements in array
		 * @param	arr The Array
		 * @param	property The properties
		 * @param	value The specified value
		 * @return The number of elements having that propertyValue
		 */
		static public function countByProperty(arr:Array, property:String, value:*):uint {
			var result:uint = 0
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i][property] == value)
					result++
			}
			return result;
		}

		/**
		 * Counting the quantity of property's values
		 * elements with the same value of property are counted as one
		 * @param	arr
		 */
		static public function countNonIdenticalProperties(arr:Array, property:String, isSorted:Boolean = false):uint {
			//TODO arr.sort(sortByProperty)
			var result:uint = 0
			var previousValue:String = ""
			for (var i:int = 0; i < arr.length; i++) {
				////trace("arr.length", arr.length, "i", i, property, arr[i][property], arr[i][property] != previousValue, "result", result)
				if (arr[i][property] != previousValue)
					result++
				previousValue = arr[i][property]
			}
			return result;
		}
		
		static public function sortByProperty():void {
			
		}
		
		/**
		 * Convert Object to Array
		 */
		static public function objectToArray(object:Object):Array {
			var array:Array = [];
			for (var name:String in object) { array.push(name) }
			array.sort();
			return array;
		}
		
		/**
		 * Convert Object to Array
		 */
		static public function object2Array(obj:*):Array
		{
			var result:Array = []
			for (var name:String in obj) {
				obj[name].id = name
				//////trace("object2Array", name, obj[name].id)
				result.push(obj[name])
			}
			//////trace("object2Array ", result.length, "result[0]", result[0], "result[1]", result[1])
			return result;
		}
		
		/**
		 * Convert Object to Array
		 */
		static public function objectKeys2Array(object:Object):Array
		{
			var result:Array = new Array();
			for (var name:String in object)
				result.push(name);
			return result;
		}
		
		/**
		 * change 0/1 in hash to words
		 */
		static public function booleans2Word(array:Array, row:String, trueWord:String, falseWord:String):Array {
			var result:Array = [];
			for each(var obj:Object in array) {
				if (obj[row] == 1)
					obj[row] = trueWord
				else if (obj[row] == 0)
					obj[row] = falseWord
				result.push(obj)
			}
			return result
		}
		
		static public function objectKeysWithSpecifiedValuesToArray(object:Object, value:*):Array
		{
			var result:Array = []
			for (var name:String in object)
			{
				////trace("objectKeysWithSpecifiedValuesToArray", name, object[name], value, "|", object[name] == value)
				if (object[name] == value)
					result.push(name);
			}
			return result;
		}
		
		static public function isValueExistInArray(array:Array, value:*):Boolean
		{
			for (var i:int = 0; i < array.length; i++)
			{
				if (array[i] == value)
					return true;
			}
			return false;
		}
		
		static public function numberValuesSum(array:Array):Number
		{
			var result:Number = 0;
			for (var i:int = 0; i < array.length; i++)
			{
				result += array[i];
			}
			return result;
		}
	}
}