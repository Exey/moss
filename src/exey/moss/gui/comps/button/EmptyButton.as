package exey.moss.gui.comps.button
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * Component with no graphics with button logic
	 * @author Exey Panteleev
	 */
	public class EmptyButton extends ComponentAbstract
	{
		
		private var _skin:DisplayObject;
		public function get skin():DisplayObject { return _skin; }
		public function set skin(value:DisplayObject):void {
			if (_skin) this.removeChild(skin);
			_skin = value;
			if(_skin) addChild(_skin);			
		}
		
		protected var _enabled:Boolean
		public function get enabled():Boolean { return _enabled; }
		public function set enabled(value:Boolean):void {
			_enabled = value;
			if (!_enabled) {
				this.mouseEnabled = false;
				this.mouseChildren = false;
				this.alpha = 0.5;
			} else {
				this.mouseEnabled = true;
				this.mouseChildren = true;
				this.alpha = 1;
			}
		}
		
		protected var handler:Function;
		
		/**
		 * Constructor
		 */
		public function EmptyButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, handler:Function, initEmptySkin:Boolean = false, addToSkin:DisplayObject = null, skinAddition:DisplayObject = null)
		{
			super(parent, xpos, ypos);
			addHandler(handler);
			this.buttonMode = true;
			if (initEmptySkin) {
				skin = new Sprite();
			}
			if (addToSkin) {
				(skin as DisplayObjectContainer).addChild(addToSkin);
				if (skinAddition) (skin as DisplayObjectContainer).addChild(skinAddition);
			}	
		}
		
		public function addHandler(handler:Function):void {
			this.handler = handler;
			if (handler != null) 
				this.addEventListener(MouseEvent.CLICK, handler);
		}
		
		public function destroy():void
		{
			if(handler != null) this.removeEventListener(MouseEvent.CLICK, handler);
			if (parent)
				parent.removeChild(this);
		}	
		
	}
}