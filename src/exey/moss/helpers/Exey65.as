package exey.moss.helpers {
	import exey.moss.utils.BitmapUtil;
	import exey.moss.utils.ColorUtil;
	import exey.moss.utils.ImageProcessingUtil;
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * for histogram encoding
	 * @author Exey Panteleev
	 */
	public class Exey65 {
		
		private static const EXEY65:String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-+=";
		
		static public function decode(v:String):Array 
		{
			var result:Array = [];
			var c:String
			for (var i:int = 0; i < v.length; i++) {
				c = v.charAt(i);
				result[i] = EXEY65.indexOf(c)
			}
			return result;	
		}
		
		static public function encode(h:Vector.<uint>):String 
		{
			var result:String = ""
			for (var i:int = 0; i < h.length; i++) {
				result += EXEY65.charAt(h[i])
			}
			return result;
		}
		
		/**
		 * 
		 * @param	b
		 * @param	width
		 * @return [thresholdBitmapData, HistogramValues, Exey65 string]
		 */
		static public function horizontalIntensityHistogram(b:BitmapData, width:Number = 64):Array 
		{
			var bmd:BitmapData = BitmapUtil.decrease(b, width);
			bmd.applyFilter(bmd, bmd.rect, new Point(), ColorUtil.DESATURATE_FILTER);
			var t:BitmapData = ImageProcessingUtil.integralImageThresholding(bmd);
			var h:Vector.<uint> = ImageProcessingUtil.horizontalIntensity(t);
			return [t, h, encode(h)]; 
		}
		
	}
}