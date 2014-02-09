package exey.moss.utils 
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class StarlingUtil
	{	
		
		static public function drawAndAdd(container:DisplayObjectContainer, xpos:Number, ypos:Number, method:Function, ...methodParams):Image 
		{
			var s:Shape = new Shape();
			method.apply(null, [s.graphics].concat(methodParams))
			var img:Image = imageFromDO(PlaceUtil.wrap(s, 0));
			if(container)
				container.addChild(img);
			img.x = xpos;
			img.y = ypos;
			return img;
		}
		
		static public function drawCenterAndAdd(container:DisplayObjectContainer, xpos:Number, ypos:Number, method:Function, ...methodParams):Image 
		{
			var s:Shape = new Shape();
			method.apply(null, [s.graphics].concat(methodParams))
			var img:Image = imageFromDO(PlaceUtil.wrapAndCenter(s, 0));
			if(container)
				container.addChild(img);
			img.x = xpos;
			img.y = ypos;
			return img;
		}
		
		static public function textureFromDO(source:flash.display.DisplayObject):Texture 
		{
			return Texture.fromBitmapData(BitmapUtil.rasterize(source as flash.display.DisplayObject));
		}
		
		static public function imageFromDO(source:flash.display.DisplayObject):Image 
		{
			var bmd:BitmapData = BitmapUtil.rasterize(source as flash.display.DisplayObject);
			var tex:Texture = Texture.fromBitmapData(bmd);
			return new Image(tex);
		}
		
	}
}