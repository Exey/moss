package exey.moss.datastruct {
	import flash.geom.Point;
	/**
	 * Fast 2D Array based on Vector of wildcards
	 * @author Exey Panteleev
	 */
	final public class Array2D {
		
		private var _size:Point
		public function get size():Point 
		{
			if  (!_size) 			_size = new Point();
			if	(_size.x != sizeX)  _size.x = sizeX;
			if	(_size.y != sizeY)  _size.y = sizeY;
			return _size;
		}
		
		public var sizeX	: int;
		public var sizeY	: int;
		
		
		private var data	: Vector.< * >;
		/**
		 * Constructor
		 */
		public function Array2D( sizeX:int, sizeY:int ) 
		{
			this.sizeX = sizeX;
			this.sizeY = sizeY;
			allocate();
		}
		
		private function allocate():void 
		{
			data = new Vector.< * >( sizeX * sizeY );
		}
 
		public function put(x:int, y:int, content:*):void 
		{
			data[ (y * sizeX) + x ] = content;
		}
 
		public function at(x:int, y:int):* 
		{
			return data[ (y * sizeX) + x ];
		}
		
		public function toString():String 
		{
			return "[Array2D sizeX=" + sizeX + " sizeY=" + sizeY + "]";
		}
		
	}
}