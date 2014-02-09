package exey.moss.gui.comps.media 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.utils.DrawUtil;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * Display Color Progress
	 * @author Exey Panteleev
	 */
	public class ColorProgressBar extends ComponentAbstract 
	{
		private var colorWidth:Number;
		private var barWidth:Number;
		private var barHeight:Number;
		
		private var addedColorLength:int;
		
		public function ColorProgressBar(parent:DisplayObjectContainer, xpos:Number, ypos:Number, barWidth:Number, barHeight:Number) 
		{
			super(parent, xpos, ypos);
			this.barWidth = barWidth;
			this.barHeight = barHeight;
			addedColorLength = 0;
		}
		
		public function init(colorLength:int):void 
		{
			var pixelsPerPhoto:Number = barWidth / colorLength;
			colorWidth = (pixelsPerPhoto < 1) ? pixelsPerPhoto : int(pixelsPerPhoto);
		}
		
		public function addColor(color:uint):void 
		{
			DrawUtil.rect(this.graphics, colorWidth * addedColorLength, 0, colorWidth, barHeight, color);
			addedColorLength++;
		}
		
	}
}