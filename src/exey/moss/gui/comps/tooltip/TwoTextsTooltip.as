package exey.moss.gui.comps.tooltip
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Linear;
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.helpers.AnchoredRect;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class TwoTextsTooltip extends ComponentAbstract
	{
		private var _tf1:TextField;
		private var _tf2:TextField;
		private var _tf1Mask:AnchoredRect;
		private var _tf2Mask:AnchoredRect;
		private var _text1:String;
		private var _text2:String;
		
		public function TwoTextsTooltip(text1:String, text2:String, format1:TextFormat, format2:TextFormat, padding:Number, bgColor:uint = 0x000000)
		{
			super(null, 0, 0);
			this.mouseEnabled = false
			this.mouseChildren = false
			
			_text1 = text1;
			_text2 = text2;
			//tf = new TextFieldLabel(this, 5, 5, new TextFormat("Trebuchet MS", 16, 0xFFFFFF, true));
			_tf1 = new TextFieldLabel(this, padding * 0.5, padding * 0.5, format1, text1);
			_tf2 = new TextFieldLabel(this, padding * 0.5, _tf1.height + padding * 0.4, format2, text2);
			_tf2.x = (Math.max(_tf1.width, _tf2.width) + padding * 0.5) - _tf2.width;
			
			//this.graphics.beginFill(bgColor, 0.1);
			this.graphics.beginFill(bgColor, 0.75);
			this.graphics.drawRoundRect(0, 0, Math.max(_tf1.width, _tf2.width) + padding, _tf1.height + _tf2.height + padding, 6, 6);
			
			
		}
		
		public function autotypeIn(charDuration:Number = 0.1, delay:Number = 0):void
		{
			_tf1.text = "";
			_tf2.text = "";
			if (delay)
				Actuate.timer(delay).onComplete(updateAutotype, charDuration, _tf1, _text1);
			else
				updateAutotype(charDuration, _tf1, _text1);
		}
		
		private function updateAutotype(charDuration:Number, tf:TextField, text:String):void
		{
			var nextCharacter:String = text.charAt(tf.text.length);
			tf.appendText(nextCharacter);
			if (nextCharacter == " " || nextCharacter == "\\")
				updateAutotype(charDuration, tf, text);
			else if (tf.text.length >= text.length)
			{
				trace("2:AUTOTYPING COMPLETED");
				if (text == _text1)
					updateAutotype(charDuration, _tf2, _text2);
			}
			else
				Actuate.timer(0.1).onComplete(updateAutotype, charDuration, tf, text);
		}
		
		public function slideTextIn(duration:Number, delay:Number = 0):void
		{
			if (_tf1Mask)
				return;
			_tf1Mask = new AnchoredRect(this, _tf1.x, _tf1.y, 0, _tf1.height);
			_tf2Mask = new AnchoredRect(this, _tf2.x, _tf2.y, 0, _tf2.height);
			_tf1.mask = _tf1Mask;
			_tf2.mask = _tf2Mask;
			//var ratio:Number = (_tf1.width - _tf2.width) / _tf1.width;
			var durationPerPixel:Number = (duration*0.5) / this.width;
			Actuate.tween(_tf1Mask, durationPerPixel*_tf1.width, { width:_tf1.width } ).delay(delay).ease(Linear.easeNone).onComplete(slideText2In, durationPerPixel*_tf2.width);
		}
		
		private function slideText2In(duration:Number):void
		{
			Actuate.tween(_tf2Mask, duration, { width:_tf2.width } ).ease(Linear.easeNone);
		}
	}

}