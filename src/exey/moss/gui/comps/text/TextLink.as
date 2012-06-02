package exey.moss.gui.comps.text 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class TextLink extends TextFieldLabel 
	{
		private var url:String;
		
		public function TextLink(url:String, parent:DisplayObjectContainer, xpos:Number, ypos:Number, textFormat:TextFormat, text:String="", embedFonts:Boolean=false, mouseEnabled:Boolean=false) 
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