package exey.moss.gui 
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Cubic;
	import exey.moss.gui.comps.control.AlertMessage;
	import exey.moss.utils.AnimationUtil;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author 
	 */
	public class AlertManager
	{
		
		static private var alertContainer:DisplayObjectContainer;
		static private var alertMessage:AlertMessage;
		
		public function AlertManager(alertContainer:DisplayObjectContainer) 
		{
			AlertManager.alertContainer = alertContainer;
		}
		
		static public function showThreeSeconds(text:String, animateIn:Boolean = false, animateOut:Boolean = false, color:uint = 0x417DFC):void 
		{
			show(text, animateIn, color);
			if (animateOut) Actuate.timer(3).onComplete(hide);
			else Actuate.timer(3).onComplete(destoyAlertMessage);
		}
		
		static public function show(text:String, animate:Boolean = false, color:uint = 0x417DFC):void
		{
			//////trace("AlertManager show", text);
			if (alertMessage)
				alertMessage.hide();
			if (animate)
			{
				alertMessage = new AlertMessage(alertContainer, 150, 150, text, color);
				AnimationUtil.slideY(alertMessage, 1, Cubic.easeOut, 200);
			}
			else
			{
				alertMessage = new AlertMessage(alertContainer, 150, 150, text, color);
			}
		}
		
		static public function hide():void
		{
			////trace("AlertManager hide");
			if (!alertMessage)
				return;
 			AnimationUtil.slideY(alertMessage, 1, Cubic.easeOut, -alertMessage.height);
			Actuate.timer(1).onComplete(destoyAlertMessage);
		}
		
		static public function destoyAlertMessage():void
		{
			////trace("AlertManager destoyAlertMessage");
			if (!alertMessage)
				return;
			alertMessage.hide();
			alertMessage = null;
		}
	}

}