package exey.moss.gui.comps.button
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class EmptyButton extends ComponentAbstract
	{
		private var handler:Function;
		private var _skin:DisplayObject;
		public function get skin():DisplayObject { return _skin; }
		public function set skin(value:DisplayObject):void 
		{
			if (_skin) this.removeChild(skin);
			_skin = value;
			if(_skin) addChild(_skin);			
		}
		
		public function EmptyButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, handler:Function)
		{
			super(parent, xpos, ypos);
			handler = handler;
			this.addEventListener(MouseEvent.CLICK, handler);
			this.buttonMode = true;
		}
		
		public function destroy():void
		{
			this.removeEventListener(MouseEvent.CLICK, handler);
			if (parent)
				parent.removeChild(this);
		}		
		

		
	}
}