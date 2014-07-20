package exey.moss.utils 
{
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class DrawUtil
	{
		static public function verticalGradientRect(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, colors:Array):void 
		{
			var m:Matrix = new Matrix();
			m.createGradientBox( width, height, (Math.PI/180)*90, 0, 0 );
			graphics.beginGradientFill( GradientType.LINEAR, colors, [ 1, 1 ], [ 0, 255 ], m, SpreadMethod.PAD);
			graphics.drawRect( startX, startY, width, height );
		}
		
		static public function histogram(g:Graphics, startX:Number, startY:Number, w:Number, h:Number, values:Array, backgroundColor:uint = 0xFFFFFF, maxValue:Number = NaN, clearGraphics:Boolean = true, color:uint = 0x000000, backgroundAlpha:Number = 1):void 
		{
			if(clearGraphics) g.clear();
			DrawUtil.rect(g, startX, startY, w, h, backgroundColor, backgroundAlpha);
			g.lineStyle(1, color, 1, true);
			for (var i:int = 0; i < values.length; i++) {
				g.moveTo(startX+i, startY+h);
				if(isNaN(maxValue))	g.lineTo(startX+i, startY+h-values[i]);
				else g.lineTo(startX+i, startY+Math.max(0.0, h-values[i] * h/maxValue));
			}
			g.lineStyle();
		}
		
		static public function plate(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, color:uint, borderColor:uint, alpha:Number = 1):void
		{
			// shadow
			graphics.beginFill(0x000000, .5*alpha)
			graphics.drawRoundRect(startX+4, startY+4, width, height, 8, 8)
			// border
			graphics.lineStyle(3, borderColor, alpha, true);
			// draw
			graphics.beginFill(color, alpha);
			graphics.drawRoundRect(startX, startY, width, height, 8, 8);
		}
		
		static public function roundRect(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, color:uint, ellipseWidth:Number = 20, alpha:Number = 1):void
		{
			graphics.beginFill(color, alpha)
			graphics.drawRoundRect(startX, startY, width, height, ellipseWidth)
		}		
		
		static public function rect(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, color:uint, alpha:Number = 1):void
		{
			graphics.beginFill(color, alpha);
			graphics.drawRect(startX, startY, width, height);
			graphics.endFill();
		}
		
		static public function rectWithShadow(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, color:uint, alpha:Number = 1, distanceX:Number = 2, distanceY:Number = 2, shadowColor:uint = 0x808080):void 
		{
			DrawUtil.rect(graphics, startX+distanceX, startY+distanceY, width, height, shadowColor, alpha); // shadow
			DrawUtil.rect(graphics, startX, startY, width, height, color, alpha);
		}
		
		static public function border(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, borderColor:uint, borderThickness:Number, borderApha:Number = 1, pixelHinting:Boolean = false):void {
			graphics.lineStyle(borderThickness, borderColor, borderApha, pixelHinting);
			//graphics.beginFill(color)
			graphics.drawRect(startX, startY, width, height)
		}		
		
		static public function borderedRect(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, color:uint, borderColor:uint, borderThickness:Number, alpha:Number, borderAlpha:Number = 1, pixelHinting:Boolean = false):void {
			graphics.lineStyle(borderThickness, borderColor, borderAlpha, pixelHinting);
			graphics.beginFill(color, alpha);
			graphics.drawRect(startX, startY, width, height)
			graphics.endFill();
			graphics.lineStyle();
		}
		
		static public function borderedRoundRect(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, color:uint, borderColor:uint, borderThickness:Number, ellipseWidth:Number = 20, alpha:Number = 1, borderAlpha:Number = 1, pixelHinting:Boolean = false):void
		{
			graphics.lineStyle(borderThickness, borderColor, borderAlpha, pixelHinting);
			graphics.beginFill(color, alpha)
			//graphics.drawRect(startX, startY, width, height)
			graphics.drawRoundRect(startX, startY, width, height, ellipseWidth)
			graphics.lineStyle()
		}
		
		static public function gradientRoundRect(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, colors:Array, ellipseWidth:Number = 20, alpha:Number = 1):void
		{
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, -Math.PI*0.5, 0, -height*0.25);
			graphics.beginGradientFill("linear", colors, [ 1, 1 ], [ 0, 255 ], matrix, "pad", "RGB", 1);
			graphics.drawRoundRect(startX, startY,  width, height, ellipseWidth, ellipseWidth);
			graphics.endFill();
		}
		
		static public function gradientRect(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, colors:Array, alpha:Number = 1, alphas:Array = null, ratios:Array = null):void
		{
			if (!alphas) alphas = [1, 1];
			if (!ratios) ratios = [0, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, -Math.PI*0.5, 0, -height*0.25);
			graphics.beginGradientFill("linear", colors, alphas, ratios, matrix, "pad", "RGB", 1);
			graphics.drawRect(startX, startY,  width, height);
			graphics.endFill();
		}
		
		static public function startGradientFill(graphics:Graphics, colors:Array, width:Number, height:Number):void 
		{
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, -Math.PI*0.5, 0, -height*0.25);
			graphics.beginGradientFill("linear", colors, [ 1, 1 ], [ 0, 255 ], matrix, "pad", "RGB", 1);
		}
		
		static public function ellipse(graphics:Graphics, startX:Number, startY:Number, width:Number, height:Number, color:uint):void
		{
			graphics.beginFill(color)
			graphics.drawEllipse(startX, startY, width, height)
		}
		
		static public function closeButton(graphics:Graphics, color:uint = 0x966234, startX:Number = 0, startY:Number = 0, isBackground:Boolean = true, backgroundColor:uint = 0xe5c2a0, borderColor:uint = 0xb2966d, borderShadowColor:uint = 0x835613):void 
		{
			if (isBackground)
			{
				graphics.beginFill(backgroundColor);
				graphics.lineStyle(1, borderShadowColor, .5);
				graphics.drawCircle(startX+7.5, startY+7.5, 6.5);
				graphics.endFill();
				graphics.lineStyle(1, borderColor, 0.2);
				graphics.drawCircle(startX+7.5, startY+7.5, 5.5);
			}
			graphics.lineStyle(2, color);
			graphics.moveTo(startX+5, 	startY+5);
			graphics.lineTo(startX+10, 	startY+10);
			graphics.moveTo(startX+10, 	startY+5);
			graphics.lineTo(startX+5, 	startY+10);
		}
		
		static public function cross45(graphics:Graphics, color:uint = 0x966234, startX:Number = 0, startY:Number = 0, lineThickness:Number = 2, crossSize:Number = 10):void {
			graphics.lineStyle(lineThickness, color);
			graphics.moveTo(startX+crossSize*0.5, 	startY+crossSize*0.5);
			graphics.lineTo(startX+crossSize, 		startY+crossSize);
			graphics.moveTo(startX+crossSize, 		startY+crossSize*0.5);
			graphics.lineTo(startX+crossSize*0.5, 	startY+crossSize);
			graphics.lineStyle();
		}
		
		static public function soundIcon(graphics:Graphics, speakerWidth:Number = 20, height:Number = 40, color:uint = 0xFF0000, firstArcThickness:Number = 3, secondArcThickness:Number = 3):void 
		{
			var g:Graphics = graphics
			g.beginFill(color);
			g.moveTo(0, height*0.25);
			g.lineTo(speakerWidth*0.5, height*0.25);
			g.lineTo(speakerWidth, 0);
			g.lineTo(speakerWidth, height);
			g.lineTo(speakerWidth*0.5, height*0.75);
			g.lineTo(0, height*0.75);
			g.moveTo(0, height*0.25);
			g.endFill();
			if (!isNaN(firstArcThickness)) {
				g.lineStyle(firstArcThickness, color, 1, true);
				g.moveTo(speakerWidth*1.2, height*0.25);
				g.curveTo(speakerWidth*1.5, height*0.5, speakerWidth*1.2, height*0.75)
			}
			if (!isNaN(firstArcThickness)) {
				g.lineStyle(secondArcThickness, color, 1, true);
				g.moveTo(speakerWidth*1.4, height*0.1);
				g.curveTo(speakerWidth*2, height*0.5, speakerWidth*1.4, height*0.9)
			}
		}
		
		static public function rhombus(graphics:Graphics, color:uint, width:Number, height:Number):void 
		{
			graphics.beginFill(color, 0.5)
			//graphics.lineStyle(3, color, 1, true);
			graphics.moveTo(width * 0.5, 0);
			graphics.lineTo(width, height * 0.5);
			graphics.lineTo(width * 0.5,  height);
			graphics.lineTo(0, height * 0.5);
			graphics.lineTo(width * 0.5, 0);			
		}
		
		/**
		 * @author http://www.kirupa.com/forum/showpost.php?p=2057571&postcount=8
		 * @param graphics
		 * @param p:Number - The number of points on the star.
		 * @param er:Number - The radius of the external, circumscribed circle.
		 * @param ir:Number - The radius of the internal, circumscribed circle.
		 * @param x:Number - The x centre of the circumscribed circle.
		 * @param y:Number - The y centre of the circumscribed circle.
		 * @param ps:Number - The phase shift or angular offset of the polygons vertices.
		 * @example
		 * 	DrawUtil.star(star.graphics, 5, 10, 20, 20, 20, 0xFECC36, 0xFFFFFF)
		 */
		static public function star(graphics:Graphics, p:Number, er:Number, ir:Number, x:Number, y:Number, color:uint = 0xFECC36, borderColor:uint = 0xFFFFFF, ps:Number = undefined, borderThickness:Number = 2, borderAlpha:Number = 1):void
		{
			graphics.lineStyle(borderThickness, borderColor, borderAlpha, true);
			graphics.beginFill(color);
			if (!ps) {
				if (p % 2) {
					ps = -Math.PI / 2;
				} else if ((p - 6) % 4 == 0) {
					ps = 0;
				} else {
					ps = Math.PI / p;
				}
			}
			var i:Number = 2 * Math.PI / p;
			var j:Number = i / 2;
			var ts:Number;
			for (var t:Number = 0; t < 2 * Math.PI; t += i) {
				ts = t - ps;
				graphics[t ? "lineTo" : "moveTo"](x + Math.cos(ts) * er, y + Math.sin(ts) * er);
				graphics.lineTo(x + Math.cos(ts + j) * ir, y + Math.sin(ts + j) * ir);
			}
			graphics.lineTo(x + Math.cos(ps) * er, y + Math.sin( -ps) * er);
			graphics.lineStyle();
		}
		
		static public function rightArrow(graphics:Graphics, color:uint, width:Number, height:Number, shiftX:Number = 0, shiftY:Number = 0):void
		{
			var g:Graphics = graphics;
			g.beginFill(color, 1);
			g.moveTo(shiftX, 		shiftY);
			g.lineTo(shiftX, 		shiftY+height);
			g.lineTo(shiftX+width, 	shiftY+height*0.5);
			g.lineTo(shiftX, 		shiftY);
			g.endFill();
		}
		
		static public function leftArrow(graphics:Graphics, color:uint, width:Number, height:Number, shiftX:Number = 0, shiftY:Number = 0):void
		{
			var g:Graphics = graphics;
			g.beginFill(color, 1);
			g.moveTo(shiftX+width, 	shiftY);
			g.lineTo(shiftX+width, 	shiftY+height);
			g.lineTo(shiftX, 		shiftY+height*0.5);
			g.lineTo(shiftX+width, 	shiftY);
			g.endFill();
		}
		
		static public function line(graphics:Graphics, x1:int, y1:int, x2:int, y2:int, borderColor:uint, borderThickness:Number, borderAlpha:Number = 1, pixelHinting:Boolean = false, caps:String = "none"):void 
		{
			graphics.lineStyle(borderThickness, borderColor, borderAlpha, pixelHinting, "normal", caps);
			graphics.moveTo(x1, y1);
			graphics.lineTo(x2, y2);
			graphics.lineStyle();
			//graphics.moveTo(100, 100); 
			//graphics.lineTo(200, 200);			
		}
		
		/**
		 * Draw Flower
		 * @param	g
		 * @param	color
		 * @param	size
		 */
		static public function flower(g:Graphics, color:uint, size:Number):void 
		{
			const RAD:Number = Math.PI / 180;
			const petalsCount:int = 5;			
			var radius:int = size * .5;
			var innerRadius:int = radius * .05;
			var petalGage:Number = 360 / petalsCount;			
			var angle:Number
			for (var i:int = 1; i <= petalsCount; i++) {
				angle = i * petalGage
				var p1:Point = Point.polar(radius, angle * RAD);
				var p2:Point = Point.polar(radius, (angle + petalGage / 2) * RAD);
				var p3:Point = Point.polar(innerRadius, angle * RAD);
				var p4:Point = Point.polar(radius, (angle - petalGage / 2) * RAD);
				g.moveTo(p1.x, p1.y);
				g.beginFill(color);
				g.curveTo(p2.x, p2.y, p3.x, p3.y);
				g.curveTo(p4.x, p4.y, p1.x, p1.y);
				g.endFill();
			}
		}
		
		static public function crosshair(g:Graphics, x:Number, y:Number, w:Number, h:Number, color:uint, lineThickness:Number = 1, lineAlpha:Number = 0.66):void 
		{
			var mult:Number = 0.33;
			line(g, x+w*0.5, y, x+w*0.5, y+h*mult, color, lineThickness, lineAlpha);
			line(g, x, y+h*0.5, x+w*mult, y+h*0.5, color, lineThickness, lineAlpha);
			line(g, x+w*0.5, y+h*(1-mult), x+w*0.5, y+h*(1-mult)+h*mult, color, lineThickness, lineAlpha);
			line(g, x+w*(1-mult), y+h*0.5, x+w*(1-mult)+w*mult, y+h*0.5, color, lineThickness, lineAlpha);
		}
		
		static public function play(g:Graphics, fillColor:uint, size:Number, startX:Number = 0, startY:Number = 0):void 
		{
			g.beginFill(fillColor);	
			g.moveTo(startX+0, startY+0);
			g.lineTo(startX+0, startY+size);
			g.lineTo(startX+size*0.9, startY+size*0.5);
			g.lineTo(startX+0, startY+0);
		}
		
		/**
		 *   /──────────────┐   ┌──────────────\
		 *  /             1 │   │ -1            \
		 *  \               │   │               /
		 *   \──────────────┘   └──────────────/
		 */
		static public function arrowRect(graphics:Graphics, width:Number, height:Number, dir:int = 1, arrowPercent:Number = 0.25):void 
		{
			var w:Number = dir*width;
			var h:Number = dir*height;
			graphics.moveTo(w * 0.5, 	-h * 0.5);
			graphics.lineTo(w * 0.5,	h * 0.5);
			graphics.lineTo(-w * (0.5 - arrowPercent), 	h * 0.5);
			graphics.lineTo(-w * 0.5, 	0);  // arrow spout
			graphics.lineTo(-w * (0.5 - arrowPercent), 	-h * 0.5);
			graphics.lineTo(w * 0.5, 	-h * 0.5);
		}
		
		static public function matrix(graphics:Graphics, startX:Number, startY:Number, split:Array, pixelSize:Number, lenX:int, lenY:int, color:uint, backgroundColor:int = -1):void 
		{
			if (backgroundColor >= 0) {
				graphics.beginFill(backgroundColor);
				graphics.drawRect(startX, startY, pixelSize*lenX, pixelSize*lenY);
				graphics.endFill();
			}			
			var i:int, x:int, y:int
			var c:uint
			for (x = 0; x < lenX; x++) {
				for (y = 0; y < lenY; y++) {			
					if (split[i++] == 1) {
						graphics.beginFill(color);
						graphics.drawRect(startX+x*pixelSize, startY+y*pixelSize, pixelSize, pixelSize);
						graphics.endFill();
					}					
				}
			}
		}
		
	}
}