package exey.moss.gui.comps.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author
	 */
	public class WindowEvent extends Event {
		
		static public const CLOSE:String = "close";
		
		public function WindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event {
			return new WindowEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString("WindowEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}