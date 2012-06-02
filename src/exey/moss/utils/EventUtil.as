package exey.moss.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class EventUtil 
	{
		
		static public function onStage(container:DisplayObjectContainer, handler:Function):void 
		{
			container.addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				container.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				handler();
			})
		}
		
		static public function onRemovedStage(container:DisplayObjectContainer, handler:Function):void 
		{
			container.addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event):void {
				container.removeEventListener(Event.REMOVED_FROM_STAGE, arguments.callee);
				handler();
			})
		}		
		
	}

}