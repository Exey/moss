package exey.moss.gui.comps.text 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	
	/**
	 * TextFieldLabel with hyperLink
	 * @author Exey Panteleev
	 */
	public class TextLink extends TextFieldLabel 
	{
		private var url:String;
		
		public function TextLink():void
		{
			super(parent, xpos, ypos, textFormat, text, embedFonts, mouseEnabled);
			this.url = url;
			this.addEventListener(MouseEvent.CLICK, handler_click);
		}
		
		private function handler_click(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest(url));
		}
		
	}

}