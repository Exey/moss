package exey.moss.utils {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ImageProcessingUtil {
		
		static public function grayscaleHistogram(b:BitmapData):Vector.<Number> 
		{
            var vector:Vector.<Number>;
            var bmd:BitmapData = b.clone();
            bmd.applyFilter(b, b.rect, new Point(), ColorUtil.DESATURATE_FILTER);
			return bmd.histogram()[0]
		}
		
		/**Difference ratio between histograms, 1.0 means completely identical, 0.0 means completely different */
		static public function compareIntensityHistograms(h1:Vector.<uint>, h2:Vector.<uint>, maxValue:Number = 64):Number 
		{
			if (h1.length != h2.length) {
				trace("3:CAN'T COMAPRE", h1.length, h2.length)
				return NaN;
			}
			var size:int = h1.length;
			var diff:Number = 0;
			for (var i:int = 0; i < size; i++) {
				diff += Math.abs(h1[i] - h2[i]);
			}
			
			return 1.0 - diff / (size*maxValue);
		}
		
		static public function horizontalIntensity(thresholded:BitmapData, height:Number = 64):Vector.<uint>
		{
			var result:Vector.<uint> = new Vector.<uint>(thresholded.width);
			result.fixed = true;
			for (var x:int = 0; x < thresholded.width; x++) {
				result[x] = 0
				for (var y:int = 0; y < thresholded.height; y++) {
					result[x] += (thresholded.getPixel(x, y) > 0) ? 0 : 1;
				}
				result[x] = int((result[x] / thresholded.height) * height);
			}
			return result
		}
		
		/**
		 * very smart threshold
		 * @param bmp Input image (should be gray scaled)
		 * @author inspirit
		 */
		static public function integralImageThresholding(bmp:BitmapData):BitmapData
		{
			var w:int = bmp.width;
			var h:int = bmp.height;
			var size:int = w * h;
			var S:int = w / 8;
			var S2:int = S >> 1;
			var T:Number = 0.15;
			var IT:Number = 1.0 - T;
			var integral:Vector.<int> = new Vector.<int>(size, true);
			var threshold:Vector.<uint> = new Vector.<uint>(size, true);
			
			var data:Vector.<uint> = bmp.getVector(bmp.rect);
			//data.fixed = true;
			var i:int, j:int, diff:int;
			var x1:int, y1:int, x2:int, y2:int, ind1:int, ind2:int, ind3:int;
			var sum:int = 0;
			var ind:int = 0;
		 
			while( ind < size )
			{
				sum += data[ind] & 0xFF;
				integral[ind] = sum;
				ind += w;
			}
		 
			x1 = 0;
			for( i = 1; i < w; ++i )
			{
				sum = 0;
				ind = i;
				ind3 = ind - S2;
		 
				if( i > S ) x1 = i - S;
				diff = i - x1;
				for( j = 0; j < h; ++j )
				{
					sum += data[ind] & 0xFF;
					integral[ind] = integral[int(ind-1)] + sum;
					ind += w;
		 
					if(i < S2) continue;
					if(j < S2) continue;
		 
					y1 = (j < S ? 0 : j - S);
		 
					ind1 = y1 * w;
					ind2 = j * w;
		 
					if (((data[ind3]&0xFF)*(diff * (j - y1))) < ((integral[int(ind2 + i)] - integral[int(ind1 + i)] - integral[int(ind2 + x1)] + integral[int(ind1 + x1)])*IT))
					{
						threshold[ind3] = 0x00;
					} else {
						threshold[ind3] = 0xFFFFFF;
					}
					ind3 += w;
				}
			}
		 
			y1 = 0;
			for( j = 0; j < h; ++j )
			{
				i = 0;
				y2 = h - 1;
				if( j < h - S2 ) 
				{
					i = w - S2;
					y2 = j + S2;
				}
		 
				ind = j * w + i;
				if( j > S2 ) y1 = j - S2;
				ind1 = y1 * w;
				ind2 = y2 * w;
				diff = y2 - y1;
				for( ; i < w; ++i, ++ind )
				{
		 
					x1 = ( i < S2 ? 0 : i - S2);
					x2 = i + S2;
		 
					// check the border
					if (x2 >= w) x2 = w - 1;
		 
					if (((data[ind]&0xFF)*((x2 - x1) * diff)) < ((integral[int(ind2 + x2)] - integral[int(ind1 + x2)] - integral[int(ind2 + x1)] + integral[int(ind1 + x1)])*IT))
					{
						threshold[ind] = 0x00;
					} else {
						threshold[ind] = 0xFFFFFF;
					}
				}
			}
			//trace(threshold.length)
			var dst:BitmapData = new BitmapData(bmp.width, bmp.height, false);
			dst.setVector(dst.rect, threshold);
			return dst
		}
	}
}