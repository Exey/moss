package exey.moss.utils
{
/**
 * ...
 * @author Exey Panteleev
 */
	public class ArrayUtil {		
		
		/** returns arrays of x/y in array */ 
		static public function generateXYArray(startX:int, startY:int, sizeX:int, sizeY:int):Array
		{
			var arr:Array = [];
			var length:int = sizeX*sizeY;
			for (var i:int = 0; i < length; i++) 
				arr.push([startX + (i%sizeX), startY + int(i/sizeX)]);
			return arr;
		}
		
		static public function maxValue(a:Array):Number
		{
			var maxValue:int;
            for (var s:* in a) {
                if (a[s]>maxValue) {
                    maxValue = a[s];
                }
            }
			return maxValue
		}
		
		/** Returns an index of nearest element of array to value*/
		static public function nearest(arr:Array, value:Number):Number
		{
			if (arr.length <= 1) { return 0; }
			// must be null as zero would mean an exact match
			var near:Number = NaN;
			var neardiff:Number = NaN;
			var diff:Number;
			for (var i:int = 0; i < arr.length; i++) {
					diff = Math.abs(arr[i] - value);
					//trace("Diff:"+diff);
					if (diff <= neardiff || isNaN(neardiff)) {
							neardiff = diff;
							near = i;
					}
			}
			return near;
		}		
		
		/**
		 * Counting the properties(with specified value) of elements in array
		 * @param	arr The Array
		 * @param	property The properties
		 * @param	value The specified value
		 * @return The number of elements having that propertyValue
		 */
		static public function countByProperty(arr:Array, property:String, value:*):uint
		{
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
		static public function countNonIdenticalProperties(arr:Array, property:String, isSorted:Boolean = false):uint
		{
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
		
		static public function sortByProperty(arr:Array, propertyName:String):Array
		{
			arr.sortOn(propertyName, Array.NUMERIC | Array.DESCENDING);
			return arr;
		}
		
		/**
		 * Convert Object to Array
		 */
		static public function objectToArray(object:Object):Array
		{
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
				if(!(obj[name] is Number))
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
		static public function booleans2Word(array:Array, row:String, trueWord:String, falseWord:String):Array
		{
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
		
		static public function exctractMaxValues(num:uint, source:Array):Array
		{
			var cloned:Array = source.concat()
			cloned.sort(Array.DESCENDING);
			return cloned.splice(0, Math.min(num, source.length));
		}
		
		static public function sumValues(array:Array):Number
		{
			var result:Number = 0;
			for (var i:int = 0; i < array.length; i++) result += array[i];
			return result;
		}
		
		static public function columnFrom2DArrayByIndex(source:Array, index:uint):Array 
		{
			var result:Array = [];
			var sourceLength:int = source.length;
			for (var i:int = 0; i < sourceLength; i++)
				result.push(source[i][index])
			return result
		}
		
		static public function objectByPropertyFromArray(propertyName:String, propertyValue:String, source:Array):Object 
		{
			var length:uint = source.length;
			var item:Object;
			for (var i:int = 0; i < length; i++) {
				item = source[i]
				if (item[propertyName] == propertyValue)
					return item;
			}
			return null
		}
		
		static public function objectsAsArrayByPropertyFromArray(propertyName:String, propertyValue:String, source:Array):Array 
		{
			var length:uint = source.length;
			var item:Object;
			var items:Array = [];
			for (var i:int = 0; i < length; i++) {
				item = source[i]
				if (item[propertyName] == propertyValue)
					items.push(item)
			}
			return items
		}
		
		static public function objectsAsArrayByConditionFromArray(func:Function, source:Array):Array 
		{
			return source.filter(func);
		}
		
		static public function rowFrom2DArrayByValueAndIndex(colValue:String, colIndex:Number, source:Array):Array
		{
			var item:Array
			var length:uint = source.length;
			for (var i:int = 0; i < length; i++) {
				item = source[i];
				if (item[colIndex] == colValue) break;
			}
			return item
		}
		
		static public function fromProperty(source:Array, propertyName:String):Array 
		{
			var result:Array = [];
			for (var i:int = 0; i < source.length; i++) {
				result[i] = source[i][propertyName];
			}
			return result;
		}
		
		static public function fromVector(v:Object):Array
		{
			var len:int = v.length;
			var ret:Array = new Array(len);
			for (var i:int = 0; i < len; ++i)
			{
				ret[i] = v[i];
			}
			return ret;
		}
		
		static public function createWithLength(length:uint):Array 
		{
			var a:Array = [];
			for (var i:int = 0; i < length; i++) {
				a[i] = null
			}
			return a;
		}
		
		static public function selectByProperty(source:Array, propertyName:String, propertyValue:*):* 
		{
			for (var i:int = 0; i < source.length; i++) 
				if (source[i][propertyName] == propertyValue) 
					return source[i];
			return null;
		}
		
		static public function shuffle(arr:Array):void 
		{
			var arr2:Array = [];
			while (arr.length > 0) arr2.push(arr.splice(Math.round(Math.random() * (arr.length - 1)), 1)[0]);
		}
		
		static public function randomizeArray(array:Array):Array{
			var newArray:Array = new Array();
			while(array.length > 0){
				newArray.push(array.splice(Math.floor(Math.random()*array.length), 1)[0]);
			}
			return newArray;
		}	
		
		static public function randomSort(a:*, b:*):Number
		{
			if (Math.random() < 0.5) return -1;
			else return 1;
		}
		
		static public function wrapElementsToObjectProperty(arr:Array, propertyName:String):Array
		{
			var result:Array = [];
			var o:Object;
			for (var i:int = 0; i < arr.length; i++) {
				o = { };
				o[propertyName] = arr[i];
				result[i] = o;
			}
			return result
		}
	}
}