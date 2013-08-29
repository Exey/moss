package exey.moss.starling.gui.comps.window 
{
	import exey.moss.starling.gui.abstract.ComponentAbstract;
	import exey.moss.starling.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.AlignUtil;
	import flash.text.TextFormat;
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class WindowHeader extends ComponentAbstract
	{
		
		private var titleTF:TextField;
		private var textFormat:TextFormat;

		public function WindowHeader(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "Title", type:String = "simple", textFormat:TextFormat = null)
		{
			super(parent, xpos, ypos);
			if (!textFormat) this.textFormat = new TextFormat( "Arial", 14, 0x000000, "bold");
			else this.textFormat = textFormat;
			initialize(title, type);
		}

		private function initialize(title:String, type:String):void
		{
			
			titleTF = new TextFieldLabel(this, 0, 7, textFormat, title, 300);
			//titleTF.filters = [new GlowFilter(0xFFFFFF, 1, 2, 2, 10, BitmapFilterQuality.MEDIUM)]
			AlignUtil.toHorizontalCenter(titleTF, this);
		}
		
	}

}