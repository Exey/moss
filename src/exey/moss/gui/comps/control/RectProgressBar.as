package exey.moss.gui.comps.control
{
	import com.eclecticdesignstudio.motion.Actuate;
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.debug.stackTrace;
	import exey.moss.utils.AlignUtil;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class RectProgressBar extends ComponentAbstract
	{
		private var textField:TextField;
		private var color:uint;
		private var borderColor:uint;
		private var progressColor:uint;
		private var barWidth:Number;
		private var barHeight:Number;		
		private var currentPercent:Number = 0;
		
		private var _showEndValue:Boolean = false;
		public function get showEndValue():Boolean { return _showEndValue; }
		public function set showEndValue(value:Boolean):void {
			_showEndValue = value;
		}
		private var _borderWidth:Number = 3;
		public function get borderWidth():Number { return _borderWidth; }
		public function set borderWidth(value:Number):void 
		{
			_borderWidth = value;
		}
		private var _value:Number;
		public function get value():Number { return _value; }
		public function set value(value:Number):void 
		{
			_value = value;
			if (_showEndValue) {
				textField.text = int(_value) + "/" + _endValue + additionalText;
			}else {
				textField.text = String(int(_value)) + additionalText;;
			}
			AlignUtil.toHorizontalCenter(textField, this);
		}
		private var _endValue:Number;
		public function get endValue():Number { return _endValue; }
		
		public var additionalText:String = "";
		
		public var updated:Signal = new Signal();
		
		public function RectProgressBar(parent:DisplayObjectContainer, xpos:Number, ypos:Number, width:Number, height:Number, color:uint, borderColor:uint, progressColor:uint, borderWidth:Number = 3, textFormat:TextFormat = null, embedFonts:Boolean = false)
		{
			super(parent, xpos, ypos);
			barWidth = width;
			barHeight = height;
			color = color;
			borderColor = borderColor;
			progressColor = progressColor;
			initialize(textFormat, embedFonts);
		}
		
		private function initialize(textFormat:TextFormat, embedFonts:Boolean):void
		{
			if (textFormat)
			{				
				textField = new TextFieldLabel(this, 0, 0, textFormat);
				textField.embedFonts = embedFonts;
			}
			else
			{
				textField = new TextFieldLabel(this, 0, 0, new TextFormat( "Arial", 14, 0xFFFFFF, "bold" ));
				textField.embedFonts = true;
			}
			textField.mouseEnabled = false;
			textField.filters = [ new GlowFilter(0x474747, 1, 2, 2, 10, BitmapFilterQuality.MEDIUM)];
			AlignUtil.toCenter(textField, this, 0, -2);
			_value = 0;
		}
		
		override public function draw():void 
		{
			graphics.clear();
			var distance:Number = _borderWidth;
			var progressPadding:Number = _borderWidth * 0.5;
			// shadow
			graphics.beginFill(0x000000, .5)
			// draw
			graphics.lineStyle(_borderWidth, borderColor, 1, true);
			graphics.beginFill(color);
			graphics.drawRoundRect(0, 0, barWidth, barHeight, 10);
			// draw progress
			graphics.lineStyle();
			graphics.beginFill(progressColor);
			//stackTrace(progressPadding, currentPercent, barWidth, distance, barWidth * currentPercent - distance, barHeight - distance)
			graphics.beginFill(0xFFFF00, .7)
			graphics.drawRoundRect(progressPadding, progressPadding, barWidth * currentPercent - distance, barHeight - distance, 5);
			graphics.beginFill(0xffffff, .6)
			graphics.drawRoundRect(0, 1, barWidth, 5, 8)
		}
		
		public function update(currentValue:Number, startValue:Number, endValue:Number):void
		{
			//stackTrace(currentValue, startValue, endValue)
			_endValue = endValue;
			Actuate.tween(this, 0.5, { 'value': currentValue } ).onComplete(onUpdateComplete);
			currentPercent = (currentValue-startValue) / (endValue-startValue);
			if (isNaN(currentPercent))
				currentPercent = 0;
			if(currentValue >= startValue)
				draw();
		}
		
		private function onUpdateComplete():void
		{
			updated.dispatch();
		}
		
	}
}