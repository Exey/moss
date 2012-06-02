package exey.moss.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * For easily adding preloader
	 * @author Exey Panteleev
	 */
	public class PreloaderUtil {
		
		static public function addTextPreloader(parent:DisplayObjectContainer, xpos:Number = 0, ypos:Number =  0, label:String = "Загрузка…", format:TextFormat = null, background:Boolean = true, width:Number = 600, height:Number = 28):void {
			var textField:TextField = new TextField()
			if(!format)
				format = new TextFormat("Arial", 18, 0x345964);
			textField.name = "textPreloader";
			textField.background = background;
			textField.defaultTextFormat = format;
			textField.width = width;
			textField.height = height;
			textField.x = xpos;
			textField.y = ypos;
			parent.addChild(textField);
			textField.text = label;
		}
		
		static public function updateTextPreloader(parent:DisplayObjectContainer, label:String):void {
			var textField:TextField = TextField(parent.getChildByName("textPreloader"));
			if (textField)
				textField.text = label;
		}			
		
		static public function removeTextPreloader(parent:DisplayObjectContainer):void {
			var textField:TextField = TextField(parent.getChildByName("textPreloader"));
			if (textField)
				parent.removeChild(textField);
		}		
	}
}