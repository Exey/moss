package exey.moss.gui.comps.text 
{
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.DrawUtil;
	import exey.moss.utils.JavaScriptUtil;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import exey.moss.gui.abstract.ComponentAbstract;
	
	/**
	 * Primitive Label with graphic background
	 * @author Exey Panteleev
	 */
	public class SimpleLabel extends ComponentAbstract
	{
		private var textField:TextField;
		private var horizontalPadding:Number;
		private var verticalPadding:Number;
		private var color:uint;
		
		public function set text(value:String):void {
			textField.text = value;
			if (value.length) redrawBackground(color)
		}
		public function set htmlText(value:String):void {
			textField.htmlText = value;
			if (value.length && textField.htmlText.length) redrawBackground(color)
		}
		
		public function SimpleLabel(parent:DisplayObjectContainer, xpos:Number, ypos:Number, text:String, color:uint, textFormat:TextFormat, embedFonts:Boolean = false, horizontalPadding:Number = 5, verticalPadding:Number = 5)
		{
			this.horizontalPadding = horizontalPadding;
			this.verticalPadding = verticalPadding;
			initialize(text, color, textFormat, embedFonts);
			super(parent, xpos, ypos);
		}
		
		private function initialize(text:String, color:uint, textFormat:TextFormat, embedFonts:Boolean):void
		{
			textField = new TextFieldLabel(this, horizontalPadding, verticalPadding, textFormat, text, embedFonts);
			if (text.length) redrawBackground(color);
			else this.color = color; // just remember to future
		}
		
		public function redrawBackground(color:uint):void 
		{
			this.color = color;
			DrawUtil.roundRect(this.graphics, 0, 0, textField.width + horizontalPadding*2, textField.height + verticalPadding*2, color, 5);
		}
	}
}