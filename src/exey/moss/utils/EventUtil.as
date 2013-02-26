package exey.moss.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
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
		
		static public function onUpdate(container:DisplayObjectContainer, handler:Function):void 
		{
			container.addEventListener(Event.ENTER_FRAME, function(e:Event):void {
				handler();
			})
		}
		
		static public function onTimer(delay:Number, repeat:int, handler:Function):Timer
		{
			var timer:Timer = new Timer(delay, repeat);
			timer.addEventListener(TimerEvent.TIMER, handler, false, 0, true);
			timer.start();
			return timer;
		}
		
		static public function onResize(container:EventDispatcher, handler:Function):void 
		{
			container.addEventListener(Event.RESIZE, function(e:Event):void {
				var s:Stage = e.currentTarget.stage;
				handler.apply(null, [s.stageWidth, s.stageHeight])
			})
		}
		
	}

}