package exey.moss.starling.gui.comps.text {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class TextFieldLabel extends TextField {
		
		public function TextFieldLabel(parent:DisplayObjectContainer, xpos:Number, ypos:Number, textFormat:TextFormat, text:String, width:Number = 200, height:Number = 50, hAlign:String = HAlign.CENTER, vAlign:String = VAlign.CENTER) {
			super(width, height, text, textFormat.font, textFormat.size as Number, textFormat.color as Number, textFormat.bold);
			if (parent != null) parent.addChild(this);
			this.x = xpos;
			this.y = ypos;
			this.hAlign = hAlign;
			this.vAlign = vAlign;	
		}
		
		public function destroy():void {
			if (parent)
				this.parent.removeChild(this);
		}
		
	}
}