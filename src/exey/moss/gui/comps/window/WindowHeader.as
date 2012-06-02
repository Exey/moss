package exey.moss.gui.comps.window
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.malevich.view.styles.Fonts;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	/**
	 * ...
	 * types: simple, withMoneyBar
	 * @author
	 */
	public class WindowHeader extends ComponentAbstract
	{
		private var _titleTF:TextField;
		
		public function WindowHeader(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "Title", type:String = "simple")
		{
			super(parent, xpos, ypos);
			initialize(title, type);
		}
		
		private function initialize(title:String, type:String):void
		{
			_titleTF = new TextFieldLabel(this, 0, 0, Fonts.TREBUCHET_24_WHITE, "title")
		}
		
	}

}