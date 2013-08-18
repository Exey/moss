package exey.moss.factories 
{
	import exey.moss.utils.ColorUtil;
	import exey.moss.utils.DrawUtil;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	/**
	 * UI Graphics generating factory
	 * @author Exey Panteleev
	 */
	public class GuiFactory
	{
		
		static public function arrowGradientButton(width:Number, height:Number, cornerRadius:Number, fillColor:Array, fillAlpha:Number, lineThickness:Number = 0, lineColor:Number = 0, lineAlpha:Number = 0, isGlare:Boolean=true):Sprite 
		{
			var button:Sprite = new Sprite();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, -Math.PI * 0.5, 0, -height * 0.25);
			button.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
			button.graphics.beginGradientFill("linear", fillColor, [ 1, 1 ], [ 0, 255 ], matrix, "pad", "RGB", 1);
			DrawUtil.arrowRect(button.graphics, width, height);
			button.filters = [ new GlowFilter(ColorUtil.luminance(fillColor[0], -0.05), 0.5, 2, 2, 4, 1, true) ];
			return button;
		}
		
		static public function innerGlowButton(width:Number, height:Number, cornerRadius:Number, fillColor:Number, fillAlpha:Number = 1, lineThickness:Number = 0, lineColor:Number = 0, lineAlpha:Number = 0, isGlare:Boolean=true, blurX:Number = 14, blurY:Number = 14):Sprite
		{
			var button:Sprite = new Sprite();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, -Math.PI*0.5, 0, -height*0.25);
			button.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
			//button.graphics.beginGradientFill("linear", fillColor, [ 1, 1 ], [ 0, 255 ], matrix, "pad", "RGB", 1);
			button.graphics.beginFill(fillColor)
			button.graphics.drawRoundRect(-width*0.5, -height*0.5, width, height, cornerRadius, cornerRadius);
			button.filters = [ new GlowFilter(0x43676D, 0.8, blurX, blurY, 1.2, 1, true) ];
			return button;
		}	
		
		static public function gradientButton(width:Number, height:Number, cornerRadius:Number, fillColor:Array, fillAlpha:Number = 1, lineThickness:Number = 0, lineColor:Number = 0, lineAlpha:Number = 0, isGlare:Boolean=true):Sprite
		{
			var button:Sprite = new Sprite();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, -Math.PI*0.5, 0, -height*0.25);
			button.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
			button.graphics.beginGradientFill("linear", fillColor, [ 1, 1 ], [ 0, 255 ], matrix, "pad", "RGB", 1);
			button.graphics.drawRoundRect(-width*0.5, -height*0.5, width, height, cornerRadius, cornerRadius);
			button.filters = [ new GlowFilter(ColorUtil.luminance(fillColor[0], -0.05), 0.5, 2, 2, 4, 1, true) ];
			return button;
		}		
		
		static public function glassyButton(width:Number, height:Number, cornerRadius:Number, fillColor:Number, fillAlpha:Number, lineThickness:Number = 0, lineColor:Number = 0, lineAlpha:Number = 0, isGlare:Boolean=true):Sprite
		{
			var button:Sprite = new Sprite();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, 0, 0, 0);
			button.graphics.beginFill(fillColor, fillAlpha);
			button.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
			button.graphics.drawRoundRect(-width*0.5, -height*0.5, width, height, cornerRadius, cornerRadius);
			button.filters = [ new GlowFilter(0x020202, 0.5, width*0.1, width*0.1, 1, 1, true) ];
			if (isGlare) {
				var glare:Shape = new Shape();
				matrix = new Matrix();
				matrix.createGradientBox(width * 0.9, height * 0.4, Math.PI * 0.5);				
				glare.graphics.beginGradientFill("linear", [0xFFFFFF, 0xFFFFFF, fillColor], [1, 0.2, 0.1], [ 0, 255, 0 ], matrix, "pad", "RGB", 0);
				glare.graphics.drawRoundRect(0, 0, width * 0.9, height * 0.4, cornerRadius*0.5, cornerRadius*0.5);
				glare.graphics.endFill();
				glare.x = width * 0.05-width*0.5;
				glare.y = height * 0.1-height*0.5;
				button.addChild(glare);
			}
			return button;
		}
		
		static public function closeButton(color:uint = 0x966234, startX:Number = 0, startY:Number = 0, isBackground:Boolean = true, backgroundColor:uint = 0xe5c2a0, borderColor:uint = 0xb2966d, borderShadowColor:uint = 0x835613, sizeMultiplier:Number = 1):Sprite 
		{
			var button:Sprite = new Sprite();
			if (isBackground) {
				button.graphics.beginFill(backgroundColor);
				button.graphics.lineStyle(1*sizeMultiplier, borderShadowColor, .5);
				button.graphics.drawCircle(startX+7.5*sizeMultiplier, startY+7.5*sizeMultiplier, 6.5*sizeMultiplier);
				button.graphics.endFill();
				button.graphics.lineStyle(1*sizeMultiplier, borderColor, 0.2);
				button.graphics.drawCircle(startX+7.5*sizeMultiplier, startY+7.5*sizeMultiplier, 5.5*sizeMultiplier);
			}
			button.graphics.lineStyle(2*sizeMultiplier, color);
			button.graphics.moveTo(startX+5*sizeMultiplier, 	startY+5*sizeMultiplier);
			button.graphics.lineTo(startX+10*sizeMultiplier, 	startY+10*sizeMultiplier);
			button.graphics.moveTo(startX+10*sizeMultiplier, 	startY+5*sizeMultiplier);
			button.graphics.lineTo(startX+5*sizeMultiplier, 	startY+10*sizeMultiplier);
			button.graphics.lineStyle();
			button.graphics.endFill();
			return button;
		}
		
	}
}