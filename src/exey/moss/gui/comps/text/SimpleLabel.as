package exey.moss.gui.comps.text 
{
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.debug.stackTrace;
	import exey.moss.utils.DrawUtil;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import exey.moss.gui.abstract.ComponentAbstract;
	
	/**
	 * Primitive Label
	 * @author Exey Panteleev
	 */
	public class SimpleLabel extends ComponentAbstract
	{
		private var textField:TextField;
		private var horizontalPadding:Number;
		private var verticalPadding:Number;
		
		public function SimpleLabel(parent:DisplayObjectContainer, xpos:Number, ypos:Number, text:String, color:uint, textFormat:TextFormat, embedFonts:Boolean = false, horizontalPadding:Number = 5, verticalPadding:Number = 5)
		{
			this.horizontalPadding = horizontalPadding;
			this.verticalPadding = verticalPadding;
			initialize(text, color, textFormat, embedFonts);
			super(parent, xpos, ypos);
		}
		
		private function initialize(text:String, color:uint, textFormat:TextFormat, embedFonts:Boolean):void
		{
			stackTrace(text)
			textField = new TextFieldLabel(this, horizontalPadding, verticalPadding, textFormat, text, embedFonts);
			DrawUtil.roundRect(this.graphics, 0, 0, textField.width + horizontalPadding*2, textField.height + verticalPadding*2, color, 5);
		}
		
		public function set text(value:String):void 
		{
			stackTrace(value)
			textField.text = value;
		}
		
	}
}