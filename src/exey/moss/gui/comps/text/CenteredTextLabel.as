package exey.moss.gui.comps.text 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Center aligned TextFieldLabel
	 * @author Exey Panteleev
	 */
	public class CenteredTextLabel extends TextFieldLabel 
	{
		
		public function CenteredTextLabel(parent:DisplayObjectContainer, xpos:Number, ypos:Number, textFormat:TextFormat, text:String="", width:Number = NaN, height:Number = NaN, embedFonts:Boolean=false, mouseEnabled:Boolean=false) 
		{
			textFormat.align = "center"
			super(parent, xpos, ypos, textFormat, text, embedFonts, mouseEnabled);			
			this.wordWrap = this.multiline = true;
			if (!isNaN(width) || !isNaN(height)) {
				this.autoSize = TextFieldAutoSize.NONE
				if(!isNaN(width)) this.width = width;
				if(!isNaN(height)) this.height = height;
			}
		}
		
	}
}