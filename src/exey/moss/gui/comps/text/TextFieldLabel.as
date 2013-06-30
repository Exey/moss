package exey.moss.gui.comps.text {
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Extended TextField for comfortable use
	 * @author Exey Panteleev
	 */
	public class TextFieldLabel extends TextField {
		
		public function TextFieldLabel(parent:DisplayObjectContainer, xpos:Number, ypos:Number, textFormat:TextFormat, text:String = "", embedFonts:Boolean = false, mouseEnabled:Boolean = false) {
			super();
			if (parent != null) parent.addChild(this);
			this.x = xpos;
			this.y = ypos;
			this.defaultTextFormat = textFormat;
			this.embedFonts = embedFonts;
			this.mouseEnabled = mouseEnabled;
			if (text && text.length > 0)
				this.text = text;
			this.autoSize = TextFieldAutoSize.LEFT;
		}
		
		public function destroy():void {
			if (parent)
				this.parent.removeChild(this);
		}
	}
}