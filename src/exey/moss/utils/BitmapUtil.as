package exey.moss.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class BitmapUtil
	{
		static public function cropBitmapData(bitmapData:BitmapData, x:Number, y:Number, width:Number, height:Number, color:uint = 0xE7D79B):BitmapData
		{
			var result:BitmapData = new BitmapData(width, height, true, color);
			var userPhotoBitmapDataCropped:BitmapData = new BitmapData(width, height, true, color);
			userPhotoBitmapDataCropped.copyPixels(bitmapData, bitmapData.rect, new Point(x, y));
			return userPhotoBitmapDataCropped;
		}
		
		static public function rotateRectangular(bitmapData:BitmapData, angleRadians:Number):BitmapData
		{
			var result:BitmapData = new BitmapData(bitmapData.width, bitmapData.height)
			var matrix:Matrix = new Matrix();
			matrix.translate(-bitmapData.width*0.5, -bitmapData.height*0.5);
			matrix.rotate( angleRadians );
			matrix.translate(bitmapData.width*0.5, bitmapData.height*0.5);
			result.draw(bitmapData, matrix);
			return result;
		}
		
		static public function rasterize(source:DisplayObject):BitmapData
		{
			var b:BitmapData = new BitmapData(source.width, source.height, true, 0x00000000);
			b.draw(source);
			return b;
		}
		
		/**Proportional, decrease-only*/
		static public function decrease(bigBitmapData:BitmapData, maxWidth:Number, maxHeight:Number = NaN):BitmapData
		{
			var dx:Number = maxWidth / bigBitmapData.width;
			var dy:Number = maxHeight / bigBitmapData.height;
			if (dx >= 1 && dy >= 1) return bigBitmapData; // too small already
			var scale:Number 
			if (isNaN(maxHeight)) scale = dx < 1 ? dx : 1;
			else scale = (dx < 1 || dy < 1) ? Math.min(dx, dy) : 1;
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			var result:BitmapData = new BitmapData(Math.round(bigBitmapData.width * scale), Math.round(bigBitmapData.height * scale), true, 0x000000);
			result.draw(bigBitmapData, matrix, null, null, null, true);
			return result;
		}
		
		/** Proportional */
		static public function resizeByShort(bmd:BitmapData, shortSide:Number):BitmapData 
		{
			var dx:Number = shortSide / bmd.width;
			var dy:Number = shortSide / bmd.height;
			var scale:Number = Math.max(dx, dy);
            var result:BitmapData 
			if (bmd.width > bmd.height) result = new BitmapData(bmd.width*scale, shortSide, bmd.transparent);
			else result = new BitmapData(shortSide, bmd.height*scale, bmd.transparent);
            var matrix:Matrix = new Matrix();
            matrix.scale(scale, scale);
            result.draw(bmd, matrix);
            return result;
		}
		
		/** Proportional */
		static public function resizeByLong(bmd:BitmapData, longSide:Number):BitmapData 
		{
			var dx:Number = longSide / bmd.width;
			var dy:Number = longSide / bmd.height;
			var scale:Number = Math.min(dx, dy);
            var result:BitmapData; 
			if (bmd.width > bmd.height) result = new BitmapData(longSide, bmd.height*scale, bmd.transparent);
			else result = new BitmapData(bmd.width*scale, longSide, bmd.transparent);
            var matrix:Matrix = new Matrix();
            matrix.scale(scale, scale);
            result.draw(bmd, matrix);
            return result;
		}
		
		static public function resizeByWidth(bmd:BitmapData, width:Number):BitmapData 
		{
			var scale:Number = width / bmd.width;
            var result:BitmapData;
			result = new BitmapData(width, bmd.height*scale, bmd.transparent);
            var matrix:Matrix = new Matrix();
            matrix.scale(scale, scale);
            result.draw(bmd, matrix);
            return result;
		}		
		
		static public function cropRectCentered(bmd:BitmapData, size:Number):BitmapData 
		{
			if ((bmd.width < size || bmd.height < size) || (bmd.width == size && bmd.height == size)) { 
					trace("3:CAN'T CROP width", bmd.width, "height", bmd.height); 
					return bmd; }
			return cropBitmapData(bmd, (bmd.width-size)*0.5, (bmd.height-size)*0.5, size, size)
		}
		
		/**
		 *	"Extremely Fast Line Algorithm"
		 *	@author 	Po-Han Lin (original version: http://www.edepot.com/algorithm.html)
		 *	@author 	Simo Santavirta (AS3 port: http://www.simppa.fi/blog/?p=521)
		 *	@author 	Jackson Dunstan (minor formatting: http://jacksondunstan.com/articles/506)
		 * 	@author 	skyboy (optimization for 10.1+)
		 *	@param  BitmapData: bmd	Bitmap to draw on
		 *	@param 	int: x			X component of the start point
		 *	@param 	int: y			Y component of the start point
		 *	@param 	int: x2			X component of the end point
		 *	@param 	int: y2			Y component of the end point
		 *	@param 	uint: color		Color of the line
		 */
		public function efla(bmd:BitmapData, x:int, y:int, x2:int, y2:int, color:uint):void {
			var shortLen:int = y2 - y;
			var longLen:int = x2 - x;
			if (!longLen) if (!shortLen) return;
			var i:int, id:int, inc:int;
			var multDiff:Number;

			bmd.lock();

			// TODO: check for this above, swap x/y/len and optimize loops to ++ and -- (operators twice as fast, still only 2 loops)
			if ((shortLen ^ (shortLen >> 31)) - (shortLen >> 31) > (longLen ^ (longLen >> 31)) - (longLen >> 31)) {
				if (shortLen < 0) {
					inc = -1;
					id = -shortLen % 4;
				} else {
					inc = 1;
					id = shortLen % 4;
				}
				multDiff = !shortLen ? longLen : longLen / shortLen;

				if (id) {
					bmd.setPixel32(x, y, color);
					i += inc;
					if (--id) {
						bmd.setPixel32(x + i * multDiff, y + i, color);
						i += inc;
						if (--id) {
							bmd.setPixel32(x + i * multDiff, y + i, color);
							i += inc;
						}
					}
				}
				while (i != shortLen) {
					bmd.setPixel32(x + i * multDiff, y + i, color);
					i += inc;
					bmd.setPixel32(x + i * multDiff, y + i, color);
					i += inc;
					bmd.setPixel32(x + i * multDiff, y + i, color);
					i += inc;
					bmd.setPixel32(x + i * multDiff, y + i, color);
					i += inc;
				}
			} else {
				if (longLen < 0) {
					inc = -1;
					id = -longLen % 4;
				} else {
					inc = 1;
					id = longLen % 4;
				}
				multDiff = !longLen ? shortLen : shortLen / longLen;

				if (id) {
					bmd.setPixel32(x, y, color);
					i += inc;
					if (--id) {
						bmd.setPixel32(x + i, y + i * multDiff, color);
						i += inc;
						if (--id) {
							bmd.setPixel32(x + i, y + i * multDiff, color);
							i += inc;
						}
					}
				}
				while (i != longLen) {
					bmd.setPixel32(x + i, y + i * multDiff, color);
					i += inc;
					bmd.setPixel32(x + i, y + i * multDiff, color);
					i += inc;
					bmd.setPixel32(x + i, y + i * multDiff, color);
					i += inc;
					bmd.setPixel32(x + i, y + i * multDiff, color);
					i += inc;
				}
			}

			bmd.unlock();
		}
		
		static public function tint(b:BitmapData, color:uint):void {
			b.colorTransform(b.rect, new ColorTransform(color >> 16 & 0x0000FF / 255, color >> 8 & 0x0000FF / 255, color & 0x0000FF / 255));
		}
		
	}
}