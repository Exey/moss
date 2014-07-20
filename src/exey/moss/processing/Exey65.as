package exey.moss.processing {
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
		
		private static const EXEY65:String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!-~";
		
		static public function decode(v:String, length:uint = 64):Vector.<uint> 
		{
			var result:Vector.<uint> = new Vector.<uint>(length);
			result.fixed = true;
			var c:String
			for (var i:int = 0; i < length; i++) {
				c = v.charAt(i);
				result[i] = EXEY65.indexOf(c)
			}
			return result;	
		}
		
		static public function encode(h:Vector.<uint>):String 
		{
			var result:String = ""
			var length:int = h.length
			for (var i:int = 0; i < length; i++) {
				result += EXEY65.charAt(h[i])
			}
			return result;
		}
		
		//static public function encode8bitInts(v:Vector.<uint>):void 
		//{
			//var result:String = ""
			//var length:int = v.length
			//var n1:int, n2:int, n3:int, n4:int
			//var n:uint
			//for (var i:int = 0; i < length; i++) {
				//n = v[i]
				//n1 = (n >> 18) & 63
				//n2 = (n >> 12) & 63
				//n3 = (n >> 6) & 6
				//n4 = n & 63
				//result += EXEY65.charAt(n1) + EXEY65.charAt(n2) + EXEY65.charAt(n3) + EXEY65.charAt(n4);
			//}
			//trace(result)
		//}
		
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