package exey.moss.gui.comps.container 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ImageContainer extends ComponentAbstract
	{
		public var bitmap:Bitmap;
		public var userData:Object;
		
		public function ImageContainer(parent:DisplayObjectContainer, xpos:Number, ypos:Number, bitmapData:BitmapData) 
		{
			super(parent, xpos, ypos);
			bitmap = new Bitmap(bitmapData);
			addChild(bitmap)
		}
		
	}

}