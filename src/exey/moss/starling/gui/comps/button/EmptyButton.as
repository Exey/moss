package exey.moss.starling.gui.comps.button 
{
	import exey.moss.starling.gui.abstract.ComponentAbstract;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/** Dispatched when the user triggers the button. Bubbles. */
	[Event(name="triggered",type="starling.events.Event")]	
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class EmptyButton extends ComponentAbstract 
	{	
		protected static const MAX_DRAG_DIST:Number = 50;
		protected var scaleWhenDown:Number;
		protected var alphaWhenDisabled:Number;
		protected var isDown:Boolean;
		protected var useHandCursor2:Boolean;
		
		protected var contentsLayer:Sprite;
		protected var handler:Function;
		
		protected var _enabled:Boolean;
		public function get enabled():Boolean { return _enabled; }
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = value;
				contentsLayer.alpha = value ? 1.0 : alphaWhenDisabled;
				resetContents();
			}
		}
		
		private var _skin:DisplayObjectContainer;
		public function get skin():DisplayObjectContainer { return _skin; }
		public function set skin(value:DisplayObjectContainer):void {
			if (_skin) this.removeChild(skin);
			_skin = value;
			if(_skin) addChild(_skin);			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------		
		public function EmptyButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, handler:Function, initEmptySkin:Boolean = false)
		{
			super(parent, xpos, ypos);
			this.handler = handler;
			scaleWhenDown =  0.9;
			alphaWhenDisabled = 0.5;
			_enabled = true;
			isDown = false;
			useHandCursor2 = true;
			
			contentsLayer = new Sprite();
			addChild(contentsLayer);
			addEventListener(TouchEvent.TOUCH, touch_handler);
			if (initEmptySkin) {
				skin = new Sprite();
				contentsLayer.addChild(skin);
			}
		}
		
		protected function resetContents():void
		{
			isDown = false;
			contentsLayer.x = contentsLayer.y = 0;
			contentsLayer.scaleX = contentsLayer.scaleY = 1.0;
		}
		
		protected function touch_handler(event:TouchEvent):void
		{
			Mouse.cursor = (useHandCursor2 && _enabled && event.interactsWith(this)) ? MouseCursor.BUTTON : MouseCursor.AUTO;
			//trace("3:MouseCursor", Mouse.cursor, "|", useHandCursor2, _enabled, event.interactsWith(this))
			var touch:Touch = event.getTouch(this);
			if (!_enabled || touch == null) return;
			if (touch.phase == TouchPhase.BEGAN && !isDown) {
				contentsLayer.scaleX = contentsLayer.scaleY = scaleWhenDown;
				contentsLayer.x = (1.0 - scaleWhenDown) / 2.0 * skin.width;
				contentsLayer.y = (1.0 - scaleWhenDown) / 2.0 * skin.height;
				isDown = true;
			} else if (touch.phase == TouchPhase.MOVED && isDown) {
				// reset button when user dragged too far away after pushing
				var buttonRect:Rectangle = getBounds(stage);
				if (touch.globalX < buttonRect.x - MAX_DRAG_DIST || touch.globalY < buttonRect.y - MAX_DRAG_DIST || touch.globalX > buttonRect.x + buttonRect.width + MAX_DRAG_DIST || touch.globalY > buttonRect.y + buttonRect.height + MAX_DRAG_DIST) {
					resetContents();
				}
			} else if (touch.phase == TouchPhase.ENDED && isDown) {
				resetContents();
				dispatchEventWith(Event.TRIGGERED, true);
				if(handler != null) handler.apply(null, [this])
			}
		}
		
		public function destroy():void
		{
			if (parent) parent.removeChild(this);
		}
		
	}
}