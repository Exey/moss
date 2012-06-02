package exey.moss.gui.comps.tooltip
{
	import com.eclecticdesignstudio.motion.Actuate;
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import flash.display.DisplayObjectContainer;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author
	 */
	public class TextToolTip extends ComponentAbstract
	{
		private var _tf:TextField;
		private var _text:String;
		
		public function TextToolTip(text:String, width:Number = 0, fontSize:Number = 16, padding:Number = 10)
		{
			super(null, 0, 0);
			
			this.mouseEnabled = false
			this.mouseChildren = false
			_text = text;
			//tf = new TextFieldLabel(this, 5, 5, new TextFormat("Trebuchet MS", 16, 0xFFFFFF, true));
			_tf = new TextFieldLabel(this, 5, 5, new TextFormat("Georgia", fontSize, 0xFFFFFF, true, true));
			if (width > 0)
			{
				_tf.wordWrap = true;
				_tf.multiline = true;
				_tf.width = width;
			}
			//tf.embedFonts = true;
			_tf.text = text;
			
			this.graphics.beginFill(0x000000, 0.5);
			this.graphics.drawRoundRect(0, 0, _tf.width + padding, _tf.height + padding*0.8, 4, 4);
			_tf.x = padding * 0.5;
			_tf.y = padding * 0.8 * 0.5;
		}
		
		public function get tf():TextField
		{
			return _tf;
		}
		
		public function autotypeIn(charDuration:Number = 0.1):void
		{
			_tf.text = "";
			updateAutotype(charDuration);
		}
		
		private function updateAutotype(charDuration:Number):void
		{
			var nextCharacter:String = _text.charAt(_tf.text.length);
			_tf.appendText(nextCharacter);
			if (nextCharacter == " " || nextCharacter == "\\")
				updateAutotype(charDuration);
			else if (_tf.text.length >= _text.length)
			{/*trace("2:AUTOTYPING COMPLETED");*/}
			else
				Actuate.timer(0.1).onComplete(updateAutotype, charDuration);
		}
		
	}

}