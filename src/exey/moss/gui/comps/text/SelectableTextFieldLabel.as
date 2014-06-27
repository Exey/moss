package exey.moss.gui.comps.text 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class SelectableTextFieldLabel extends TextFieldLabel 
	{
		
		private var _enabled:Boolean;
		public function get enabled():Boolean {
			return _enabled;
		}
		public function set enabled(value:Boolean):void {
			_enabled = value;
			if(!_enabled) {
				this.alpha = 0.5;
				this.mouseEnabled = false;
			} else {
				this.alpha = 1;
				this.mouseEnabled = true;
			}
		}
		
		public function SelectableTextFieldLabel(parent:DisplayObjectContainer, xpos:Number, ypos:Number, textFormat:TextFormat, text:String="", width:Number=NaN, height:Number=NaN, embedFonts:Boolean=false, mouseEnabled:Boolean=false) 
		{
			super(parent, xpos, ypos, textFormat, text, embedFonts, mouseEnabled);
			this.autoSize = TextFieldAutoSize.NONE;
			this.width = width;
			this.height = height;
			this.mouseEnabled = true;
			this.selectable = true;
			this.border = true;
			this.multiline = true;
			this.wordWrap = true;
		}
		
	}
}