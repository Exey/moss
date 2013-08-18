package exey.moss.gui.comps.text {
	import com.eclecticdesignstudio.motion.Actuate;
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ScrollCombatText
	 * @author Exey Panteleev
	 */
	public class ScrollingCombatText extends ComponentAbstract
	{
		private var messageTF:TextField;
		private var valueTF:TextField;
		private var distance:Number;
		private var duration:Number;
		private var valueText:String;
		private var valueIcon:DisplayObject;
		private var textColor:uint;
		private var textFormat:TextFormat;
		
		public function ScrollingCombatText(parent:DisplayObjectContainer, xpos:Number, ypos:Number, text:String, distance:Number = 100, duration:Number = 2, valueText:String = "", valueIcon:DisplayObject = null, textFormat:TextFormat = null) 
		{
			if (!textFormat) textFormat = new TextFormat("Tahoma", 24, 0xFFFFFF);
			super(parent, xpos, ypos);
			this.textFormat = textFormat;
			this.textColor = textColor;
			this.valueIcon = valueIcon;
			this.valueText = valueText;
			this.duration = duration;
			this.distance = distance;
			createText(textColor, text, valueText);	
			animate();
		}
		
		private function createText(color:uint, message:String, value:String = "", icon:DisplayObject = null):void
		{
			var messageX:Number = 0;
			if (value != "") {
				valueTF = new TextFieldLabel(this, 0, 0, textFormat, value);
				//valueTF.textColor = color;
				messageX = valueTF.textWidth + 5;
			}
			
			messageTF = new TextFieldLabel(this, messageX, 0, textFormat, message);
			//messageTF.textColor = color;
			this.cacheAsBitmap = true;
			
			if (valueIcon) {
				icon.x = -icon.width - 5;
				this.addChild(icon);
			}
		}
		
		public function animate():void {
			Actuate.tween(this, duration, { y: this.y - distance}).onComplete(destroy);
		}
		
		private function destroy():void {
			this.hide();
		}
		
	}
}