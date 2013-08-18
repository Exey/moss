package exey.moss.gui.comps.control
{
	import exey.moss.factories.GuiFactory;
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.AlignUtil;
	import exey.moss.utils.DrawUtil;
	import exey.moss.utils.FontUtil;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * @see AlertManager
	 * @author Exey Panteleev
	 */
	public class AlertMessage extends ComponentAbstract
	{
		static public const RED:uint = 0xFF8080;
		static public const BLUE:uint = 0x417DFC;
		
		static public const HEIGHT:Number = 100;
		private var messageWidth:Number;
		
		static private const BACKGROUND_COLOR:uint = 0xFFFFFF;		
		static private const BORDER_THICKNESS:Number = 4;
		
		private var textField:TextField;
		
		public function AlertMessage(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, text:String = "", color:uint = AlertMessage.BLUE, messageWidth:Number = 600, textFormat:TextFormat = null)
		{
			this.messageWidth = messageWidth;
			initialize(text, color, textFormat);
			this.cacheAsBitmap = true;
			super(parent, xpos, ypos);
		}
		
		private function initialize(text:String, color:uint, textFormat:TextFormat):void
		{
			var skin:Sprite = new Sprite();
			DrawUtil.rect(skin.graphics, 0, 0, messageWidth, 100, color, 1)
			this.addChild(skin);
			
			var multiline:Boolean = false;
			var wordWrap:Boolean = false;
			var fontWidth:Number = 600;
			var isEmbed:Boolean = false
			if (!textFormat) textFormat = new TextFormat( "Arial", 28, 0x000000, "bold" )
			else			 isEmbed = FontUtil.isEmbed(textFormat.font)
			if (text.length < 60) { textFormat.size = 28 }
			else {
				if (text.length > 300)  textFormat.size = 12
				else					textFormat.size = 16
				multiline = true;
				wordWrap = true;			
			}
			textField = new TextFieldLabel(this, 10, 20, textFormat, text, isEmbed, true);
			textField.multiline = multiline;
			textField.wordWrap = wordWrap;
			textField.width = fontWidth;
			AlignUtil.toCenter(textField, this, 0, -5);
			
			var closeButton:Sprite = GuiFactory.closeButton();
			closeButton.addEventListener(MouseEvent.CLICK, onClose);
			closeButton.x = messageWidth - 30;
			closeButton.y = 5;
			closeButton.scaleX = closeButton.scaleY = 1.5;
			closeButton.buttonMode = true;
			addChild(closeButton);
		}
		
		private function onClose(e:MouseEvent):void 
		{
			hide();
		}
		
	}
}