package exey.moss.gui.comps.control
{
	import exey.moss.factories.GuiFactory;
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.AlignUtil;
	import exey.moss.utils.DrawUtil;
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
		
		public function AlertMessage(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, text:String = "", color:uint = AlertMessage.BLUE, messageWidth:Number = 600)
		{
			this.messageWidth = messageWidth;
			initialize(text, color);
			this.cacheAsBitmap = true;
			super(parent, xpos, ypos);
		}
		
		private function initialize(text:String, color:uint):void
		{
			//var skin:Sprite = new Sprite();
			//DrawUtil.rect(skin.graphics, 0, 0, messageWidth, 100, 0xFEF5C2, 1)
			//this.addChild(skin);
			var format:TextFormat
			var multiline:Boolean = false;
			var wordWrap:Boolean = false;
			var fontWidth:Number = 600;
			if (text.length < 60) {
				format = new TextFormat( "Arial", 28, 0x000000, "bold" )
			}
			else 
			{
				if (text.length > 300) {
					format = new TextFormat( "Arial", 12, 0x000000, "bold" );
				} else {
					format = new TextFormat( "Arial", 16, 0x000000, "bold" );
				}
				multiline = true;
				wordWrap = true;			
			}
			textField = new TextFieldLabel(this, 10, 20, format, text, false, true);
			textField.multiline = multiline;
			textField.wordWrap = wordWrap;
			textField.width = fontWidth;
			AlignUtil.toCenter(textField, this, 0, -5);
			
			var closeButton:Sprite = GuiFactory.closeButton();
			closeButton.addEventListener(MouseEvent.CLICK, onClose);
			closeButton.x = messageWidth- 60;
			closeButton.y = 25;
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