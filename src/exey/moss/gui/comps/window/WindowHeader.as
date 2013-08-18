package exey.moss.gui.comps.window
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.AlignUtil;
	import flash.display.DisplayObjectContainer;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * types: simple, withMoneyBar
	 * @author
	 */
	public class WindowHeader extends ComponentAbstract
	{
		private var titleTF:TextField;

		public function WindowHeader(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "Title", type:String = "simple")
		{
			super(parent, xpos, ypos);
			initialize(title, type);
		}

		private function initialize(title:String, type:String):void
		{
			titleTF = new TextFieldLabel(this, 0, 7, new TextFormat( "Arial", 20, 0x000000, "bold" ), title);
			titleTF.filters = [new GlowFilter(0xFFFFFF, 1, 2, 2, 10, BitmapFilterQuality.MEDIUM)]
			AlignUtil.toHorizontalCenter(titleTF, this);
		}
		
	}
}