package exey.moss.gui.comps.text 
{
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.DrawUtil;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import exey.moss.gui.abstract.ComponentAbstract;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleLabel extends ComponentAbstract
	{
		private var _tf:TextField;
		
		private var _horizontalPadding:Number;
		private var _verticalPadding:Number;
		
		public function SimpleLabel(parent:DisplayObjectContainer, xpos:Number, ypos:Number, text:String, color:uint, textFormat:TextFormat, embedFonts:Boolean = false, horizontalPadding:Number = 5, verticalPadding:Number = 5)
		{
			_horizontalPadding = horizontalPadding;
			_verticalPadding = verticalPadding;
			initialize(text, color, textFormat, embedFonts);
			super(parent, xpos, ypos);
		}
		
		private function initialize(text:String, color:uint, textFormat:TextFormat, embedFonts:Boolean):void
		{
			_tf = new TextFieldLabel(this, _horizontalPadding, _verticalPadding, textFormat, text, embedFonts);
			DrawUtil.roundRect(this.graphics, 0, 0, _tf.width + _horizontalPadding*2, _tf.height + _verticalPadding*2, color, 5);
		}
		
		public function set text(value:String):void 
		{
			_tf.text = value;
		}
		
	}

}