package exey.moss.utils{
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Exey
	 */
	public class ColorUtil {
		
		static public const DESATURATE_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.212671, 0.715160, 0.072169, 0, 0, 0.212671, 0.715160, 0.072169, 0, 0, 0.212671, 0.715160, 0.072169, 0, 0, 0, 0, 0, 1, 0]);
		
		/**
		 * Example: <code>
		 * var c1:uint = 0xFF0000
		 * var c2:uint = 0x00FF00
		 * var goodValue:Number = 0.5
		 * var poorValue:Number = 3
		 * var dist = MathUtil.distance(centerX, centerY, shootX, shootY);
		 * var mixed:int  = mix(c1, 1-MathUtil.nearRatio(poorValue, goodValue, dist), c2, 1-MathUtil.nearRatio(goodValue, poorValue, dist));
		 * </code>
		 * @param	color1
		 * @param	color1Ratio
		 * @param	color2
		 * @param	color2Ratio
		 * @return
		 */
		static public function mix(color1:uint, color1Ratio:Number, color2:uint, color2Ratio:Number):int
		{			
			var rgb1:Object = ColorUtil.hex2RGB(color1);
			var rgb2:Object = ColorUtil.hex2RGB(color2);
			var rgb3:Object = {};
            rgb3.r = int( (rgb1.r*color1Ratio)+(rgb2.r*color2Ratio) );
            rgb3.g = int( (rgb1.g*color1Ratio)+(rgb2.g*color2Ratio) );
            rgb3.b = int( (rgb1.b*color1Ratio)+(rgb2.b*color2Ratio) );
            return (rgb3.r << 16) | (rgb3.g << 8) | rgb3.b;			
		}			
		
		/**Difference ratio between colors, 1.0 means completely identical, 0.0 means completely different */
		static public function compareColors(color1:uint, color2:uint):Number
		{
			var rgb1:Object = ColorUtil.hex2RGB(color1)
			var rgb2:Object = ColorUtil.hex2RGB(color2)
			return 1.0 - Number(Math.abs(rgb1.r - rgb2.r) + 
								Math.abs(rgb1.g - rgb2.g) + 
								Math.abs(rgb1.b - rgb2.b)) / 768.0; //256.0 * 3;
		}
		
		static public function averageColorFromBitmapRegion(b:BitmapData, x:Number, y:Number, w:Number, h:Number):uint
		{
			var rect:Rectangle = new Rectangle( x, y, w, h );
			var box:BitmapData = new BitmapData( w, h, false );
			box.copyPixels( b, rect, new Point() );
			return ColorUtil.averageColor( box );
		}
		
		/** bitshifting way (slow) */
		static public function averageColor( source:BitmapData ):uint
		{
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			var count:Number = 0;
			var pixel:Number;
			for (var x:int = 0; x < source.width; x++)
			{
				for (var y:int = 0; y < source.height; y++)
				{
					pixel = source.getPixel(x, y);
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
					count++
				}
			}
			red /= count;
			green /= count;
			blue /= count;
			return red << 16 | green << 8 | blue;
		}
		
		/** histogram way (fast) */
		static public function averageColorByHistogram(source:BitmapData):uint 
		{
			 var histogram:Vector.<Vector.<Number>> = source.histogram();
			 
			 var red:Number = 0;
			 var green:Number = 0;
			 var blue:Number = 0;
			 
			 var w:Number = source.width;
			 var h:Number = source.height;
			 var countInverse:Number = 1 / (w*h);
			 
			 for (var i:int = 0; i < 256; ++i) {
			  red += i * histogram[0][i];
			  green += i * histogram[1][i];
			  blue += i * histogram[2][i];
			 }
			 
			 red *= countInverse;
			 green *= countInverse;
			 blue *= countInverse;
			 
			 return red << 16 | green << 8 | blue;
		}
		
		/**
		 * thanks @see http://www.easyrgb.com/math.php?MATH=M19#text19
		 * @param	r
		 * @param	g
		 * @param	b
		 * @return
		 */
		static public function rgbToHSL(r:Number, g:Number, b:Number):Object
		{
			var hsl:Object = { };
			
			r = r/255.0;
			g = g/255.0;
			b = b/255.0;
			
			var h:Number;
			var s:Number; 
			var l:Number;

			var max:Number = Math.max(Math.max(r, g), b); //Min. value of RGB
			var min:Number = Math.min(Math.min(r, g), b); //Max. value of RGB
			var deltaMax:Number = max - min; //Delta RGB value
			
			l = ( max + min ) * .5;
			
			if (deltaMax == 0) { 
				//This is a gray, no chroma...
				h = 0; //HSL results from 0 to 1
				s = 0;
			}else {
				//Chromatic data...
			   if ( l < 0.5 ) s = deltaMax / ( max + min );
			   else           s = deltaMax / ( 2 - max - min );

			   var deltaR:Number = ( ( ( max - r ) / 6 ) + ( deltaMax / 2 ) ) / deltaMax;
			   var deltaG:Number = ( ( ( max - g ) / 6 ) + ( deltaMax / 2 ) ) / deltaMax;
			   var deltaB:Number = ( ( ( max - b ) / 6 ) + ( deltaMax / 2 ) ) / deltaMax;

			   if      ( r == max ) h = deltaB - deltaG;
			   else if ( g == max ) h = ( 1 / 3 ) + deltaR - deltaB;
			   else if ( b == max ) h = ( 2 / 3 ) + deltaG - deltaR;

			   if ( h < 0 ) h += 1;
			   if ( h > 1 ) h -= 1;
			}

			hsl.h = Math.round(h*100);
			hsl.s = Math.round(s*100);
			hsl.l = Math.round(l*100);

			return hsl;
		}
		
		static public function hex2RGB ( hex:Number ):Object
		{
			var rgb:Object = {};
			rgb.r = (hex & 0xff0000) >> 16;
			rgb.g = (hex & 0x00ff00) >> 8;
			rgb.b = hex & 0x0000ff;
			return rgb;
		}
		
		static public function numberToHex(number:uint, minimumLength:uint = 1, showHexDenotation:Boolean = true):String
		{
            var hex:String = number.toString(16).toUpperCase();
			while (minimumLength > hex.length) 
				hex = "0" + hex;
            if (showHexDenotation) 
				hex = "0x" + hex;
            return hex;
        }

		
		static public function rgbToMatrix ( r:Number, g:Number, b:Number, a:Number ):Array
		{
			var matrix:Array = [];
			matrix = matrix.concat([Number(Number(r/255).toFixed(3)), 0, 0, 0, 0]); // red
			matrix = matrix.concat([0, Number(Number(g/255).toFixed(3)), 0, 0, 0]); // green
			matrix = matrix.concat([0, 0, Number(Number(b/255).toFixed(3)), 0, 0]); // blue
			matrix = matrix.concat([0, 0, 0, a, 0]); // alpha
			return matrix;
		}
		
		/**
		 * http://en.wikipedia.org/wiki/YIQ
		 * @param	r
		 * @param	g
		 * @param	b
		 * @return
		 */
		static public function rgbToYIQ(r:Number, g:Number, b:Number):Object 
		{
			var yiq:Object = {};
			yiq.y = 0.299 * r + 0.587 * g + 0.114 * b;
			yiq.i = 0.596 * r - 0.274 * g - 0.322 * b;
			yiq.q = 0.211 * r - 0.522 * g + 0.311 * b;
			return yiq;
		}		
		
		static public function findApproxColorName(hex:Number, colorsDictionary:Array, approxColorNames:Array):String
		{
			var rgb:Object = ColorUtil.hex2RGB(hex);
			var r:Number = rgb.r; 
			var g:Number = rgb.g; 
			var b:Number = rgb.b;
			var hsl:Object = ColorUtil.rgbToHSL(r, g, b);
			var h:Number = hsl.h;
			var s:Number = hsl.s;
			var l:Number = hsl.l;
			var ndf1:Number = 0;
			var ndf2:Number = 0;
			var ndf:Number = 0;
			var cl:Number = -1
			var df:Number = -1;
			//trace("findApproxColorName", hex);
			var color:Array;
			for (var i:int = 0; i < approxColorNames.length; i++) {
				color = approxColorNames[i];
				if(hex == color[0]) return color[1];
				ndf1 = Math.pow(r - color[2], 2) + Math.pow(g - color[3], 2) + Math.pow(b - color[4], 2);
				ndf2 = Math.abs(Math.pow(h - color[5], 2)) + Math.pow(s - color[6], 2) + Math.abs(Math.pow(l - color[7], 2));
				ndf = ndf1 + ndf2 * 2;
				if(df < 0 || df > ndf) {
					df = ndf;
					cl = i;
				}
			}
			return colorsDictionary[cl][1];
		}
		
		/**
		 * luminance("6699CC", 0.2);	// "#7ab8f5" - 20% lighter
		 * luminance("69C", -0.5);	// "#334d66" - 50% darker
		 * @param	color
		 * @param	lum
		 * @return
		 */
		static public function luminance(color:uint, lum:Number):int 
		{
			var hex:String = numberToHex(color, 1, false);
			lum = lum || 0;
			var resultHex:String = "", c:int, cs:String, i:int;
			for (i = 0; i < 3; i++) {
				c = parseInt(hex.substr(i*2,2), 16);
				cs = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16);
				resultHex += ("00"+cs).substr(cs.length);
			}
			return parseInt("0x"+resultHex);
		}
		
	}
}