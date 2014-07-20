package exey.moss.processing {
	import exey.moss.processing.BitmapSlicer;
	import exey.moss.utils.ColorUtil;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class PatternColorPallete {
		public var name:String;
		
		private var bitmapData:BitmapData;
		public var names:Array;
		public var tileRect:Rectangle;
		
		public var maxWidth:Number;
		public var maxHeight:Number;
		
		public var approxColorNames:Array;
		public var colorsDictionary:Array;
		public var flagRect:Rectangle;
		public var sliced:BitmapSlicer;
		
		
		public function PatternColorPallete(bitmapData:BitmapData, tileRect:Rectangle, names:Array, maxWidth:Number, maxHeight:Number) {
			this.maxHeight = maxHeight;
			this.maxWidth = maxWidth;
			this.names = names;
			this.tileRect = tileRect;
			this.bitmapData = bitmapData;
		}
		
		public function init():void {
			// mosaic converter
			sliced = new BitmapSlicer(bitmapData, tileRect.width, tileRect.height);
			initColorsDictionary(sliced);
		}
		
		private function initColorsDictionary(sliced:BitmapSlicer):void {
			colorsDictionary = [];
			var n:String;
			for each(var b:BitmapData in sliced.slices) {
				n = names[sliced.slices.indexOf(b)];
				if(n) colorsDictionary.push([ColorUtil.averageColorFromBitmapRegion(b, 0, 0, b.width, b.height), n])
				//trace(EmbedResources.FLAGS[sliced.slices.indexOf(b)], ColorUtil.averageColorFromBitmapRegion(b, 0, 0, b.width, b.height))
			}
			
			approxColorNames = colorsDictionary;
			var hexColor:uint;
			var rgb:Object;
			var hsl:Object;
			for(var k:int = 0; k < colorsDictionary.length; k++) {
			  hexColor = colorsDictionary[k][0];
			  rgb = ColorUtil.hex2RGB(hexColor);
			  hsl = ColorUtil.rgbToHSL(rgb.r, rgb.g, rgb.b);
			  approxColorNames[k].push(rgb.r, rgb.g, rgb.b, hsl.h, hsl.s, hsl.l);
			}
		}
		
	}

}