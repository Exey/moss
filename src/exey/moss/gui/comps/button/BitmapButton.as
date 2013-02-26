package exey.moss.gui.comps.button 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class BitmapButton extends EmptyButton 
	{
		private var downSkin:Bitmap;
		private var overSkin:Bitmap;
		private var normalSkin:Bitmap;
		
		private var _selected:Boolean;		
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			if (_selected)
				this.skin = downSkin;
			else
				this.skin = normalSkin;
		}
		
		public function BitmapButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, normalSkin:*, downSkin:*, overSkin:*, handler:Function) 
		{
			super(parent, xpos, ypos, handler);
			this.overSkin = overSkin as Bitmap;
			this.downSkin = downSkin as Bitmap;
			this.normalSkin = normalSkin as Bitmap;
			this.skin = normalSkin as DisplayObjectContainer;
			this.addEventListener(MouseEvent.MOUSE_OVER, handler_mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, handler_mouseOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, handler_mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, handler_mouseUp);
		}
		
		private function handler_mouseDown(e:MouseEvent):void 
		{
			this.skin = downSkin;
		}
		
		private function handler_mouseUp(e:MouseEvent):void 
		{
			this.skin = normalSkin;
		}
		
		private function handler_mouseOver(e:MouseEvent):void 
		{
			this.skin = overSkin;
		}
		
		private function handler_mouseOut(e:MouseEvent):void 
		{
			this.skin = normalSkin;
		}
		

		
	}
}