package exey.moss.gui.comps.media 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class MicrophoneActivity extends ComponentAbstract 
	{
		
		public function MicrophoneActivity(parent:DisplayObjectContainer, xpos:Number, ypos:Number, mic:Microphone) 
		{
			super(parent, xpos, ypos);
			var micActivityIndicator:Shape = new Shape();
			var micDelay:uint = 100;
			var micRepeat:uint = 0; /* Run forever */
			var micTimer:Timer = new Timer(micDelay, micRepeat);
			if (!mic) {
				trace("3: ERROR MicrophoneActivity NO MIC");
				return;				
			}
			micTimer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
				//trace(PrivacyMediaManager.getMicrophone(0).activityLevel, mic.name);
				var w:int;
				if (mic.activityLevel > 0) { w = mic.activityLevel;
				} else { w = 10; }
				micActivityIndicator.graphics.clear();
				micActivityIndicator.graphics.beginFill(0x00FF00);
				micActivityIndicator.graphics.drawRect(0, 0, w, 10);
				micActivityIndicator.graphics.endFill();
			});
			addChild(micActivityIndicator);
			micTimer.start();
		}
		
	}
}