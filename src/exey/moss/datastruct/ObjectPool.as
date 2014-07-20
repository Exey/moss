package exey.moss.datastruct {
	import exey.moss.debug.deb;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.osflash.signals.Signal;
	
	/**
	 * A flexible and high performance object pooling utility
	 * @usage Constructor an instance with your given class and use getObject/putObject to check instances in and out of the pool
	 */
	public class ObjectPool 
	{
		
		
		/** The type of Event dispatched when the pool is pruned of unused objects */
		public var cleanedSignal:Signal = new Signal();
		/** The type of Event dispatched when the pool is emptied and reinitialised */
		public var flushedSignal:Signal = new Signal();
		/** The type of Event dispatched when the pool is prepared for destruction and rendered unusable */
		public var disposedSignal:Signal = new Signal();
		
		
		/** The ID of the Error thrown in strict mode when attempting to recycle an object to a pool with no checked-out objects */
		public static const ERROR_RECYCLE_UNUSED :int = 1;
		/** The ID of the Error thrown in strict mode when attempting to check-in a null object reference */
		public static const ERROR_NULL_CHECK_IN :int = 2;
		/** The ID of the Error thrown in strict mode when attempting to check-in an object of the wrong type */
		public static const ERROR_CHECK_IN_TYPE :int = 3;
		/** The ID of the Error thrown in strict mode when attempting to check-in an object instance already checked into the pool */
		public static const ERROR_MULTI_CHECK_IN :int = 4;
		
		
		private var _ObjectClass :Class;
		/** Returns the class reference for the type of object pooled by this instance */
		public function get ObjectClass():Class { return _ObjectClass; }
		
		private var _size :int;
		/** The total number of objects in the pool (used and unused) */
		public function get size():int { return _size; }
		
		private var _bufferSize :int;
		/** The pool buffer or wastage (number of currently unused objects) */
		public function get unused():int { return _bufferSize; }
		
		/** The number of objects in the pool that are currently in-use */
		public function get used():int { return _size - _bufferSize; }
		
		
		private var _pool :Array;
		private var _objectsInUse :Array;
		private var _maxBuffer :uint;
		private var _initObject :Object;
		private var _resetMethod :String;
		private var _disposeMethod :String;
		private var _idealArrayInitialSize :uint = 0;
		private var _strictMode :Boolean;
		
		
		/**
		 * Creates an object pool for maintaining and reusing instances of the given class
		 * @param ObjectClass Any class you wish to pool
		 * @param strictMode [optional] Specifies that the pool will throw errors, rather than just ignore, if invalid objects are checked back into the pool
		 * @param initialSize [optional] Initialises the pool with the given number of object instances
		 * @param maxBuffer [optional] Specifies a maximum amount of waste allowed in the pool before it is automatically pruned of unused objects
		 * @param initObject [optional] Specifies an object that will be passed to the constructor of pooled objects
		 * @param resetMethod [optional] A method name to invoke on pooled objects as they are recycled back to the pool
		 * @param disposeMethod [optional] A method name to invoke when disposing of pooled object instances
		 */
		public function ObjectPool(ObjectClass:Class, strictMode:Boolean = false, initialSize:uint = 0, maxBuffer:uint = 0, initObject:Object = null, resetMethod:String = '', disposeMethod:String = '')
		{
			_ObjectClass = ObjectClass;
			_strictMode = strictMode;
			if (initialSize > _idealArrayInitialSize)
				_idealArrayInitialSize = initialSize;
			flush();
			_maxBuffer = maxBuffer;
			_initObject = initObject;
			_resetMethod = resetMethod;
			_disposeMethod = disposeMethod;
			var i:uint = initialSize;
			while (i--)
				createAndAddObject();
		}
		
		
		/**
		 * Gets an object from the pool, creating one only if necessary
		 * @return An object of the type specified by ObjectPool constructor's ObjectClass parameter
		 */
		public function borrowObject():*
		{
			var objectToReturn:*;
			if (_bufferSize == 0)
				objectToReturn = createObject();
			else
				objectToReturn = _pool[--_bufferSize];
			if (_strictMode)
				_objectsInUse.push(objectToReturn);
			return objectToReturn;
		}
		
		/**
		 * Recycles an object back into the pool for later reuse
		 * @param object - An object of the ObjectClass type that originated from the pool
		 */
		public function returnObject(object:*):void
		{
			var isCorrectType:Boolean = object is _ObjectClass;
			var isAlreadyCheckedIn:Boolean = false;
			if (_strictMode) {
				var usageIndex:int = _objectsInUse.indexOf(object);
				if (usageIndex == -1)
					isAlreadyCheckedIn = true;
				else
					_objectsInUse.splice(usageIndex, 1);
			}
			if (object && isCorrectType && used > 0 && !isAlreadyCheckedIn) {
				addToPool(object, true);
			} else if (_strictMode) {
				if (!used)				throw new Error('You cannot return an object to a pool with no checked-out items. The specified object did not appear to come from this pool.', ERROR_RECYCLE_UNUSED);
				if (object == null)		throw new Error('You cannot return a null object reference to the pool.', ERROR_NULL_CHECK_IN);
				if (!isCorrectType)		throw new Error('You cannot return an object of the wrong type ' + object + ' a pool of type ' + _ObjectClass + '.', ERROR_CHECK_IN_TYPE);
				if (isAlreadyCheckedIn) throw new Error('You cannot return an object to the pool when it\'s already checked-in.', ERROR_MULTI_CHECK_IN);
			}
			if (_maxBuffer && _bufferSize > _maxBuffer)
				clean();
		}
		
		/** fast return all */
		public function reset():void
		{
			resetObjects();
			if(_strictMode) _objectsInUse.length = 0;
			_bufferSize = _size;
			
		}
		
		/** Prunes the pool of unused objects to conserve memory */
		public function clean():void
		{
			var unused:uint = _bufferSize;
			if (unused > 0) {
				var cleanCount:uint = Math.min(_size, unused);
				disposeObjects();
				createList();
				_bufferSize = 0;
				_size -= cleanCount;
			}
			cleanedSignal.dispatch();
		}
		
		/**
		 * Empties the pool completely and reinitialises it
		 * @param force - Forces the flush, even if some objects are still in-use (otherwise the flush is skipped)
		 * @param disposeUnusedObjects - Also attempts to call the 'dispose' method of each pooled object (if any)
		 */
		public function flush(force:Boolean = false, disposeUnusedObjects:Boolean = false):void
		{
			if (used > 0 && !force)
				return;
			if (disposeUnusedObjects)
				disposeObjects();
			_size = _bufferSize = 0;
			createList();
			flushedSignal.dispatch();
		}
		
		/**
		 * Destroys everything and prepares the pool for garbage collection
		 */
		public function dispose():void
		{
			flush(true, true);
			_ObjectClass = null;
			_initObject = null;
			_pool = null;
			_objectsInUse = null;
			_resetMethod = null;
			_disposeMethod = null;
			disposedSignal.dispatch();
		}
		
		
		private function createList():void {
			_pool = new Array(_idealArrayInitialSize);
			_objectsInUse = new Array();
		}
		
		private function resetObjects():void {
			if (_resetMethod == '')
				return;
			var obj:Object;
			var usedLength:int = _objectsInUse.length;
			//deb(usedLength, _pool.length)
			for (var i:int = 0; i < usedLength; i++)
			{
				obj = _objectsInUse[i];
				if (obj)
					obj[_resetMethod]();
			}
		}
		
		private function disposeObjects():void
		{
			if (_disposeMethod == '')
				return;
			var obj:Object;
			for (var i:int = 0; i < _bufferSize; i++) {
				obj = _pool[i];
				if (obj)
					obj[_disposeMethod]();
			}
		}
		
		private function createAndAddObject():void
		{
			addToPool(createObject());
		}
		
		private function addToPool(object:*, reset:Boolean = false):void
		{
			if (reset && _resetMethod != '')
				object[_resetMethod]();
			_pool[_bufferSize++] = object;
		}
		
		private function createObject():*
		{
			_size++;
			return _initObject == null ? new _ObjectClass() : new _ObjectClass(_initObject);
		}
		
	}
}