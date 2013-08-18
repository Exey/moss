package exey.moss.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FullScreenEvent;
	import flash.events.TimerEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.utils.Timer;
	/**
	 * Short event declaration
	 * @author Exey Panteleev
	 */
	public class EventUtil 
	{
		static public function onStage(container:Object, handler:Function):void 
		{
			if (container.stage) {
				handler();
			} else {
				container.addEventListener(Event.ADDED_TO_STAGE, function(e:Event = null):void {
					container.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
					handler();
				})
			}
		}
		
		static public function onRemovedStage(container:DisplayObjectContainer, handler:Function):void 
		{
			container.addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event = null):void {
				container.removeEventListener(Event.REMOVED_FROM_STAGE, arguments.callee);
				handler();
			})
		}		
		
		static public function onUpdate(container:Object, handler:Function):void 
		{
			container.addEventListener(Event.ENTER_FRAME, function(e:Event = null):void {
				handler();
			})
		}
		
		static public function onFullScreen(container:DisplayObjectContainer, handler:Function):void 
		{
			container.addEventListener(Event.FULLSCREEN, function(e:FullScreenEvent):void {
				handler(e.fullScreen);
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
			container.addEventListener(Event.RESIZE, function(e:Event = null):void {
				handler.apply(null, [e.currentTarget.stage.stageWidth, e.currentTarget.stage.stageHeight])
			})
		}
		
		static public function uncaughtErrors(loaderInfo:LoaderInfo, uncaughtErrorHandler:Function):void 
		{
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);			
		}
		
		static public function onNextFrame(container:EventDispatcher, handler:Function):void 
		{
			container.addEventListener(Event.ENTER_FRAME, function(e:Event = null):void {
				container.removeEventListener(Event.ENTER_FRAME, arguments.callee);
				handler();
			})
		}
		
	}

}