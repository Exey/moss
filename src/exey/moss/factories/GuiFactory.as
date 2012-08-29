package exey.moss.factories 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author 
	 */
	public class GuiFactory
	{
		
		static public function glassyButton(width:Number, height:Number, cornerRadius:Number, fillColor:Number, fillAlpha:Number, lineThickness:Number = 0, lineColor:Number = 0, lineAlpha:Number = 0):Sprite
		{
			var button:Sprite = new Sprite();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, 0, 0, 0);
			button.graphics.beginFill(fillColor, fillAlpha);
			button.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
			button.graphics.drawRoundRect(0, 0, width, height, cornerRadius, cornerRadius);
			button.filters = [ new GlowFilter(0x020202, 0.5, width*0.1, width*0.1, 1, 1, true) ];
			var glare:Shape = new Shape();
			matrix = new Matrix();
			matrix.createGradientBox(width * 0.9, height * 0.4, Math.PI*0.5);
			glare.graphics.beginGradientFill("linear", [0xFFFFFF, 0xFFFFFF, fillColor], [1, 0.2, 0.1], [ 0, 255, 0 ], matrix, "pad", "RGB", 0);
			glare.graphics.drawRoundRect(0, 0, width * 0.9, height * 0.4, cornerRadius*0.5, cornerRadius*0.5);
			glare.graphics.endFill();
			glare.x = width * 0.05;
			glare.y = height * 0.1;
			button.addChild(glare);
			return button;
		}
		
		static public function closeButton(color:uint = 0x966234, startX:Number = 0, startY:Number = 0, isBackground:Boolean = true, backgroundColor:uint = 0xe5c2a0, borderColor:uint = 0xb2966d, borderShadowColor:uint = 0x835613):Sprite 
		{
			var button:Sprite = new Sprite();
			if (isBackground)
			{
				button.graphics.beginFill(backgroundColor);
				button.graphics.lineStyle(1, borderShadowColor, .5);
				button.graphics.drawCircle(startX+7.5, startY+7.5, 6.5);
				button.graphics.endFill();
				button.graphics.lineStyle(1, borderColor, 0.2);
				button.graphics.drawCircle(startX+7.5, startY+7.5, 5.5);
			}
			button.graphics.lineStyle(2, color);
			button.graphics.moveTo(startX+5, 	startY+5);
			button.graphics.lineTo(startX+10, 	startY+10);
			button.graphics.moveTo(startX+10, 	startY+5);
			button.graphics.lineTo(startX+5, 	startY+10);
			return button;
		}
		
	}
}