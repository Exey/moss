package exey.moss.processing
{
	import exey.moss.processing.PerceptualHashSimple;
	import exey.moss.utils.ColorUtil;
	import exey.moss.utils.ImageProcessingUtil;
	import exey.moss.utils.MathUtil;
	import exey.moss.utils.NumberUtil;
	import flash.display.BitmapData;
	import flash.net.FileReference;
	/**
	 * Bitmap Statistics
	 * @author Exey Panteleev
	 */
	public class BitmapStatistics 
	{
		public var url:String;
		public var fileName:String;
		public var file:FileReference; // for AIR flash.filesystem.File;
		public function get folder():String { var s:Array = url.split("/"); return decodeURIComponent(s[s.length - 2]); }
		public var folderName:String
		
		// dimensions
		public var width:int;
		public var height:int;
		public var aspectRatio:Number;
		// color
		public var averageColor:uint;
		public var averageLuma:Number;
		// histogram optional
		//public var intensityHistogram:Vector.<uint>;
		// perceptual hash
		public var binaryString:String;
		public var binaryStringSize:int;
		public var binaryStringSizeX:int;
		public var binaryStringSizeY:int;
		// mutable data
		public var diff:Number = 0
		public var index:uint
		public var customBitmapData:BitmapData // TODO need clean Refactor to use binary string outside
		
		public function get aspectRatioArray():Array {
			return ImageProcessingUtil.aspect(width, height)
		}
		
		/**
		 * Constructor
		 */
		public function BitmapStatistics() 
		{

		}
		
		public function calculateDiff(img:BitmapStatistics):void 
		{
			//var t:Number = getTimer();
			var lumaDiff:Number = 1.0 - Math.abs(averageLuma - img.averageLuma) / 255;
			var colorDiff:Number = ColorUtil.compareColors(averageColor, img.averageColor);
			//var histogramDiff:Number = ImageProcessingUtil.compareIntensityHistograms(intensityHistogram, img.intensityHistogram);
			//var fingerprintDiff:Number = 1-(MathUtil.levenshtein(binaryString, img.binaryString)/binaryStringSize);
			var fingerprintDiff:Number = 1-(MathUtil.hamming(binaryString, img.binaryString)/binaryStringSize);
			var aspectRatioDiff:Number = 1.0 - (Math.abs(aspectRatio - img.aspectRatio) / Math.max(aspectRatio, img.aspectRatio));
			//this.diff = (lumaDiff+colorDiff+histogramDiff+aspectRatioDiff)/4;
			this.diff = (lumaDiff+colorDiff+fingerprintDiff+aspectRatioDiff)/4;
			//trace("calculateDiff", fingerprintDiff, "DIFF CALC TIME", (getTimer()-t)/1000);
		}
		
		public function toString():String 
		{
			return "[BitmapStatistics Diff "+Number(diff).toFixed(7)+" LCH "+NumberUtil.formatLength(NumberUtil.fixed(averageLuma, 3), 7)+" "+ColorUtil.numberToHex(averageColor, 6)+" "+binaryString+" | Dimensions "+width+"x"+height+" FileName: "+fileName+"]"
		}
		
		private function formatHistogram(v:Vector.<uint>):String 
		{
			var r:String = "";
			for (var i:int = 0; i < v.length; i++) {
				r += NumberUtil.formatLength(v[i], 2)+","
			}
			return r;
		}
		
		/** Factory method */
		static public function fromFingeprint(url:String, fileName:String, badFilenameHandler:Function = null):BitmapStatistics 
		{
			// Validate
			var s:Array = fileName.substr(0, fileName.lastIndexOf(".")).split("_");
			var fingerprint:String = String(s[3])
			if (!s || s.length < 4 || (fingerprint.charAt(2) != PerceptualHashSimple.DELIMITER && fingerprint.charAt(1) != PerceptualHashSimple.DELIMITER)) {
				trace("3:BitmapStatistics WRONG FILENAME " + fileName+" " + url);
				if (badFilenameHandler != null)
					badFilenameHandler.apply(null, [])
				return null;
			}
			//else {trace("OK", s[3])}
			
			var bs:BitmapStatistics = new BitmapStatistics();
			bs.url = url;
			bs.fileName = fileName;			
			bs.averageLuma = s[0] * 0.001;
			bs.averageColor = parseInt("0x"+s[1]);
			var wh:Array = s[2].split("x");
			bs.width = wh[0];
			bs.height = wh[1];
			bs.aspectRatio = wh[0]/wh[1];
			//intensityHistogram = Exey65.decode(s[3])
			var tuple:Array = PerceptualHashSimple.convertFromFingerprintStringToBinaryString(s[3])
			bs.binaryString = tuple[2];
			bs.binaryStringSizeX = tuple[0];
			bs.binaryStringSizeY = tuple[1];
			bs.binaryStringSize = bs.binaryStringSizeX*bs.binaryStringSizeY
			return bs
		}
		
		/** 
		 * Factory method 
		 * Filename example:
		 * 152617_AC918D_604x403_30'20'0o01Y00z00cg0j400xw04b01ye040o1R3g8ow0620mww4g81kw188w80c0wy009w0ao00C001000g01I01X000M02c00D008000w.jpg
		 */
		//static public function fromBitmapData(fileName:String, color:uint, index:uint):BitmapStatistics 
		static public function fromBitmapData(bitmapData:BitmapData, file:FileReference, index:uint = 0):BitmapStatistics 
		{
			//var hihTuple:Array = Exey65.horizontalIntensityHistogram(b.bitmapData);
			
			var bs:BitmapStatistics = new BitmapStatistics();
			bs.customBitmapData = PerceptualHashSimple.createFingerprintBitmapData(bitmapData, 30) // 30x30
			bs.file = file;
			bs.url = Object(file).url // if AIR flash.filesystem.File
			bs.index = index;
			bs.averageColor = ColorUtil.averageColorByHistogram(bitmapData);
			bs.fileName = ColorUtil.numberToHex(bs.averageColor, 6).substr(2) + "_" 
						  + bitmapData.width + "x" + bitmapData.height +"_"
						  + PerceptualHashSimple.convertBitmapDataToFingerprintString(bs.customBitmapData) 
						  + bs.url.substring(bs.url.lastIndexOf("."), bs.url.length).toLowerCase()						  
			var sf:Array = bs.url.split("/");
			bs.folderName = sf[sf.length - 2];
			return bs
		}
		
	}
}