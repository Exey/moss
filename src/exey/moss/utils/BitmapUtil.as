package exey.moss.utils
{
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
		
		static public function rotateRectangular(bitmapData:BitmapData, angleRadians:Number):BitmapData {
			var result:BitmapData = new BitmapData(bitmapData.width, bitmapData.height)
			var matrix:Matrix = new Matrix();
			matrix.translate(-bitmapData.width*0.5, -bitmapData.height*0.5);
			matrix.rotate( angleRadians );
			matrix.translate(bitmapData.width*0.5, bitmapData.height*0.5);
			result.draw(bitmapData, matrix);
			return result;
		}
		
		static public function rasterize(source:DisplayObject):BitmapData {
			var b:BitmapData = new BitmapData(source.width, source.height, true, 0x00000000);
			b.draw(source)
			return b;
		}
		
		/**Proportional, decrease-only*/
		static public function decrease(bigBMD:BitmapData, maxWidth:Number = NaN, maxHeight:Number = NaN):BitmapData {			
			var dx:Number = maxWidth / bigBMD.width;
			var dy:Number = maxHeight / bigBMD.height;
			if (dx >= 1 && dy >= 1)
				return bigBMD;
			var scale:Number = (dx < 1 || dy < 1) ? Math.min(dx, dy) : 1;
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			var smallBMD:BitmapData = new BitmapData(bigBMD.width * scale, bigBMD.height * scale, true, 0x000000);
			smallBMD.draw(bigBMD, matrix, null, null, null, true);
			return smallBMD;
		}
	}
}