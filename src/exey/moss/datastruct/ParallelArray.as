package exey.moss.datastruct	 
{
	/**
	 * Object parallel array with getLast() method
	 * @author Exey
	 */
	public class ParallelArray
	{
		private var arrays:Array;
		private var lengthLimitToType:uint;

		// Cache
		private var cachedFullArray:Array;
		private var isCached:Boolean = false;
		private var cachedTypes:Array;
		private var lastObject:Object;
		
		public function ParallelArray(numTypes:int, lengthLimitToType:uint) 
		{
			this.lengthLimitToType = lengthLimitToType;
			arrays = [];
			var i: int = numTypes;
			while ( --i > -1 ) {
				arrays[i] = [];
				////trace("ParallelArray", i, arrays[i]);
			}
		}
		
		public function add(object:Object, type:int):void 
		{
			lastObject = object;
			var array:Array = arrays[type];
			////trace("add", lastObject, type, array, object.channel, object.text);
			var arrayLength:uint = array.length;
			if (arrayLength > this.lengthLimitToType) {
				array.splice(0, arrayLength-this.lengthLimitToType)
			}
			
			array.push(object);
			isCached = false;
		}		
		
		public function getLast(num:uint, types:Array = null, sortBy:String = ""):Array 
		{
			if (!types || num == 0) return [];
			else if (num == 1) return [lastObject];
			
			// caching
			if (!isCached || types != cachedTypes) buildFullArray(types);
			
			//cachedFullArray.sortOn(sortBy, Array.NUMERIC | Array.DESCENDING);
			cachedFullArray.sortOn(sortBy, Array.NUMERIC);
			
			return cachedFullArray.splice(cachedFullArray.length - num, num);
		}
		
		private function buildFullArray(types:Array):void 
		{
			cachedTypes = types;
			cachedFullArray = null;
			var isFirst:Boolean = true;
			for (var i:int = 0; i < types.length; i++) {
				if (types[i]) {
					if (!cachedFullArray) 
						cachedFullArray = arrays[i];
					else
						cachedFullArray = cachedFullArray.concat(arrays[i]);
					////trace("buildFullArray", types[i], arrays[i], "|", arrays[i].length, cachedFullArray.length)
				}
			}
			isCached = true;
		}
		
	}
}