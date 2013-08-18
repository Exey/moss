package exey.moss.starling.gui.comps.text 
{
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import starling.display.DisplayObjectContainer;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class TextLink extends TextFieldLabel 
	{		
		private var url:String;
		private var clickHandler:Function;
		private var isDown:Boolean = false;
		
		public function TextLink(url:String, parent:DisplayObjectContainer, xpos:Number, ypos:Number, textFormat:TextFormat, text:String="", clickHandler:Function = null):void
		{
			super(parent, xpos, ypos, textFormat, text);
			this.underline = true;
			this.clickHandler = clickHandler;
			this.url = url;
			addEventListener(TouchEvent.TOUCH, touch_handler);
		}
		
		private function touch_handler(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this);
			if (!touch) return;
			Mouse.cursor = e.interactsWith(this) ? MouseCursor.BUTTON : MouseCursor.AUTO;
			//trace("touch_handler", touch);
			if (touch.phase == TouchPhase.BEGAN && !isDown) isDown = true;
			if (touch.phase == TouchPhase.ENDED && isDown) {
				if(url && url.length > 0) navigateToURL(new URLRequest(url));
				if (clickHandler != null) clickHandler();
				isDown = false;
			}
		}		
		
	}
}