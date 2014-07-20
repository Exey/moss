package exey.moss.processing {
	import exey.moss.utils.ArrayUtil;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ColorSplittedBitmap {
		
		public var width:Number;
		public var height:Number;
		public var colors:Array;
		
		public function ColorSplittedBitmap(b:BitmapData)
		{
			// perfomance optimizations
			var colorsFounded:Vector.<uint> = new Vector.<uint>(), colorsFoundedLength:int = 0;
			var lastColor:uint = uint.MAX_VALUE, lastCP:ColorPixels;
			// necessary
			var bw:int = this.width = b.width, bh:int = this.height = b.height;
			var colors:Array = [];
			var c:uint, x:int, y:int, cpi:int, cp:ColorPixels;
			for (x = 0; x < bw; x++) {
				for (y = 0; y < bh; y++) {
					c = b.getPixel(x, y);
					if (c == lastColor) {
						lastCP.add([x, y]);
					}else {
						for (cpi = 0; cpi < colorsFoundedLength; cpi++) if (colorsFounded[cpi] == c) break;
						cp = colors[cpi]
						if (!cp) {
							colorsFounded[colorsFoundedLength] = c;
							cp = colors[colorsFoundedLength] = new ColorPixels(c, [x, y]);
							colorsFoundedLength++
						} else {
							cp.add([x,y]);
						}
						lastColor = c;
						lastCP = cp;
					}
				}
			}
			this.colors = colors;
		}
		
		public function sortByPixelLength():void 
		{
			colors.sortOn("pixelLength", Array.NUMERIC | Array.DESCENDING)
		}
		
	}
}
import exey.moss.utils.ColorUtil;

class ColorPixels {
	public var color:uint;
	public var pixels:Array = [];
	public var pixelLength:uint = 0;
	public var colorName:String;
	public var userData:Object;
	
	public function ColorPixels(color:uint, firstElement:Array):void
	{
		this.color = color;
		add(firstElement);
	}
	
	public function add(el:Array):void
	{
		pixels[pixelLength] = el;
		pixelLength++;
	}
	
	public function toString():String 
	{
		return "[ColorPixels color=" + ColorUtil.numberToHex(color) + " pixelLength=" + pixelLength + " colorName=" + colorName + "]";
	}
}