package exey.moss.mngr 
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Cubic;
	import exey.moss.gui.comps.control.AlertMessage;
	import exey.moss.gui.comps.control.IAlertMessage;
	import exey.moss.utils.AnimationUtil;
	import exey.moss.utils.PlaceUtil;
	import flash.text.TextFormat;
	/**
	 * Alert messages manager
	 * @author Exey Panteleev
	 */
	public class AlertManager
	{	
		static private var alertContainer:Object;
		static private var alertMessage:IAlertMessage;
		
		static private var textFormat:TextFormat;
		static private var messagePosX:Number;
		static private var messagePosY:Number;
		static private var messageWidth:Number;
		
		public function AlertManager(alertContainer:Object, messagePosX:Number = 0, messagePosY:Number = 0, messageWidth:Number = 100, textFormat:TextFormat = null) 
		{
			AlertManager.alertContainer = alertContainer;
			AlertManager.messagePosY = messagePosY;
			AlertManager.messagePosX = messagePosX;
			AlertManager.messageWidth = messageWidth;
			if(textFormat) AlertManager.textFormat = textFormat;
		}
		
		static public function showThreeSeconds(text:String, animateIn:Boolean = false, animateOut:Boolean = false, color:uint = 0x417DFC):void 
		{
			show(text, animateIn, color);
			if (animateOut) Actuate.timer(3).onComplete(hide);
			else Actuate.timer(3).onComplete(destoyAlertMessage);
		}
		
		static public function showAlertMessage(alertMessage:IAlertMessage, animate:Boolean = false, newYPos:Number = 200):void 
		{
			if (alertMessage) alertMessage.hide();
			AlertManager.alertMessage = alertMessage;
			PlaceUtil.place(alertMessage, alertContainer, messagePosX, messagePosY);
			if (animate) {
				alertMessage.y = -alertMessage.height;
				AnimationUtil.slideY(alertMessage, 1, Cubic.easeOut, newYPos);
			}
		}
		
		static public function show(text:String, animate:Boolean = false, color:uint = 0x417DFC, newYPos:Number = 200):void
		{
			if (alertMessage) alertMessage.hide();
			if (animate) {
				alertMessage = new AlertMessage(alertContainer, messagePosX, messagePosY, text, color, messageWidth, textFormat);
				AnimationUtil.slideY(alertMessage, 1, Cubic.easeOut, newYPos);
			} else {
				alertMessage = new AlertMessage(alertContainer, messagePosX, messagePosY, text, color, messageWidth, textFormat);
			}
		}
		
		static public function hide():void
		{
			if (!alertMessage) return;
 			AnimationUtil.slideY(alertMessage, 1, Cubic.easeOut, -alertMessage.height);
			Actuate.timer(1).onComplete(destoyAlertMessage);
		}
		
		static public function destoyAlertMessage():void
		{
			if (!alertMessage) return;
			alertMessage.hide();
			alertMessage = null;
		}
		
	}
}