package exey.moss.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
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
			b.draw(source)
			return b;
		}
		
		/**Proportional, decrease-only*/
		static public function decrease(bigBitmapData:BitmapData, maxWidth:Number, maxHeight:Number = NaN):BitmapData
		{			
			var dx:Number = maxWidth / bigBitmapData.width;
			var dy:Number = maxHeight / bigBitmapData.height;
			if (dx >= 1 && dy >= 1) return bigBitmapData; // too small already
			var scale:Number = (dx < 1 || dy < 1) ? Math.min(dx, dy) : 1;
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			var result:BitmapData = new BitmapData(bigBitmapData.width * scale, bigBitmapData.height * scale, true, 0x000000);
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
	}
}