package exey.moss.gui.comps.tooltip
{
	import com.eclecticdesignstudio.motion.Actuate;
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.DrawUtil;
	import exey.moss.utils.FontUtil;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Tooltip for display text only
	 * @author Exey Panteleev
	 */
	public class TextToolTip extends ComponentAbstract
	{
		protected var _tf:TextField;
		public function get tf():TextField{return _tf;};
		
		protected var text:String;
		
		public function TextToolTip(text:String, width:Number = 0, textFormat:TextFormat = null, padding:Number = 10)
		{
			super(null, 0, 0);
			this.text = text;
			this.mouseEnabled = false;
			this.mouseChildren = false;
			var isEmbed:Boolean = false
			if (!textFormat) textFormat = new TextFormat("Georgia", 14, 0xFFFFFF, true, true);
			else isEmbed = FontUtil.isEmbed(textFormat.font);
			_tf = new TextFieldLabel(this, 5, 5, textFormat, "", isEmbed);
			if (width > 0) {
				_tf.wordWrap = true;
				_tf.multiline = true;
				_tf.width = width;
			}
			_tf.text = text;
			
			DrawUtil.roundRect(this.graphics, 0, 0, _tf.width + padding, _tf.height + padding * 0.8, 0x000000, 4, 0.5);
			_tf.x = padding * 0.5;
			_tf.y = padding * 0.8 * 0.5;
		}
				
		public function autotypeIn(charDuration:Number = 0.1):void
		{
			_tf.text = "";
			updateAutotype(charDuration);
		}
		
		protected function updateAutotype(charDuration:Number):void
		{
			var nextCharacter:String = text.charAt(_tf.text.length);
			_tf.appendText(nextCharacter);
			if (nextCharacter == " " || nextCharacter == "\\") updateAutotype(charDuration);
			else if (_tf.text.length >= text.length) {/*trace("2:AUTOTYPING COMPLETED");*/}
			else Actuate.timer(0.1).onComplete(updateAutotype, charDuration);
		}
		
	}
}