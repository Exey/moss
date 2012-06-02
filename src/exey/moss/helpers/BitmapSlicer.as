package exey.moss.helpers
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class BitmapSlicer 
	{
		static private const ZERO_POINT:Point = new Point();
		
		public var slices:Vector.<BitmapData>;
		
		private var _sliceWidth:Number;
		private var _sliceHeight:Number;
		
		public function BitmapSlicer(bitmapData:BitmapData, sliceWidth:Number, sliceHeight:Number)
		{
			_sliceWidth = sliceWidth;
			_sliceHeight = sliceHeight;
			slice(bitmapData);
		}
		
		private function slice(bitmapData:BitmapData):void
		{
			var cols:int = (bitmapData.width / _sliceWidth);
			var rows:int = (bitmapData.height / _sliceHeight);
			var length:int = cols * rows;
			slices = new Vector.<BitmapData>(length);
			var slice:BitmapData;
			var rect:Rectangle;
			var rectX:Number = 0;
			var rectY:Number = 0;
			for (var i:int = 0; i < length; i++) {
				slice = new BitmapData(_sliceWidth, _sliceHeight, true, 0x00000000);
				rect = new Rectangle(rectX, rectY, _sliceWidth, _sliceHeight);			
				slice.copyPixels(bitmapData, rect, ZERO_POINT);
				slices[i] = slice;
				rectX += _sliceWidth;
				if ((i+1) % cols == 0) {					
					rectX = 0;
					rectY += _sliceHeight;
				}
			}
		}
		
	}
}