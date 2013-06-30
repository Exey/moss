package exey.moss.utils 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class SignalUtil 
	{
		
		static public function click(target:EventDispatcher):Signal 
		{
			var s:Signal = new Signal();
			target.addEventListener(MouseEvent.CLICK, function(e:Event = null):void {
				s.dispatch();
			})
			return s
		}
		
	}
}