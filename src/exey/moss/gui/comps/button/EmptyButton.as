package exey.moss.gui.comps.button
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class EmptyButton extends ComponentAbstract
	{
		private var _handler:Function;
		private var _skin:DisplayObject;
		
		public function EmptyButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, handler:Function)
		{
			super(parent, xpos, ypos);
			_handler = handler;
			this.addEventListener(MouseEvent.CLICK, _handler);
			this.buttonMode = true;
		}
		
		public function destroy():void
		{
			this.removeEventListener(MouseEvent.CLICK, _handler);
			if (parent)
				parent.removeChild(this);
		}		
		
		public function get skin():DisplayObject { return _skin; }
		
		public function set skin(value:DisplayObject):void 
		{
			if (_skin)
				this.removeChild(_skin);
			_skin = value;
			addChild(skin);			
		}
		
	}
}