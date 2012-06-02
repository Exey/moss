package exey.moss.gui.comps.tooltip
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author
	 */
	public class XMLToolTip extends ComponentAbstract
	{
		private var _fontColor:uint;
		
		public function XMLToolTip(xml:XML, width:Number, color:uint = 0x000000, alpha:Number = 0.5, fontColor:uint = 0xFFFFFF)
		{
			super(null, 0, 0);
			this._fontColor = fontColor;
			
			//this.mouseEnabled = false
			//this.mouseChildren = false
			
			var tooltipHeight:Number = 5;
			
			var i:uint = 0
			for each (var item:XML in xml.p)
			{
				if (item.img.length() > 0)
				{
					addImage(item.img[0].@src, 10, tooltipHeight);
					tooltipHeight += int(item.img[0].@height) + 5;
					////trace("+", item.img[0].@height);
				}
				else
				{
					var tf:TextField = addText(item, 10, tooltipHeight, width);
					tooltipHeight += tf.height+5;
				}
				////trace(i, tooltipHeight)
				i++
			}
			
			//tf = new TextFieldLabel(this, 5, 5, new TextFormat("Trebuchet MS", 16, 0xFFFFFF, true));
			//if (width > 0)
			//{
				//tf.wordWrap = true;
				//tf.multiline = true;
				//tf.width = width;
			//}
			//tf.embedFonts = true;
			//tf.text = text;
			
			this.graphics.beginFill(color, alpha);
			this.graphics.drawRoundRect(0, 0, width + 10, tooltipHeight + 10, 4, 4);
			this.mouseChildren = false;
		}
		
		private function addText(text:String, xpos:Number, ypos:Number, width:Number):TextField
		{
			var tf:TextField = new TextFieldLabel(this, xpos, ypos,  new TextFormat("Trebuchet MS", 16, _fontColor, true), text);
			tf.wordWrap = true;
			tf.multiline = true;
			tf.width = width;
			////trace("addText", text, tf.height)
			return tf;
		}
		
		protected function addImage(url:String, xpos:Number, ypos:Number):void
		{
			
		}
		
	}

}