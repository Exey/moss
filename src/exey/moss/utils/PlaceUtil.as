package exey.moss.utils 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class PlaceUtil 
	{
		
		public function PlaceUtil() {
			
		}
		
		static public function to(parent:Object, displayObject:Object, xPos:Number = 0, yPos:Number = 0):Object
		{
			parent.addChild(displayObject);
			displayObject.x = xPos;
			displayObject.y = yPos;
			return displayObject;
		}
		
		static public function place(displayObject:Object, parent:Object, xPos:Number, yPos:Number, depthIndex:int = -1):Object
		{
			if (depthIndex != -1)
				parent.addChildAt(displayObject, depthIndex)
			else
				parent.addChild(displayObject);
			displayObject.x = xPos;
			displayObject.y = yPos;
			return displayObject;
		}
		
		static public function placeAndSetSize(displayObject:Object, parent:Object, xPos:Number, yPos:Number, width:Number, height:Number):Object
		{
			place(displayObject, parent, xPos, yPos);
			displayObject.width = width;
			displayObject.height = height;
			return displayObject;
		}
		
		/** Flash/Starling API Universal */
		static public function placeAndAddListener(displayObject:Object, parent:Object, xPos:Number, yPos:Number, handler:Function, event:String):Object
		{
			parent.addChild(displayObject);
			displayObject.x = xPos;
			displayObject.y = yPos;
			displayObject.addEventListener(event, handler);
			return displayObject;
		}
		
		static public function placeArrayOfElements(parent:Object, elements:Array):void 
		{
			for (var i:int = 0; i < elements.length; i++) 
				parent.addChild(elements[i])
		}
		
		static public function wrapAndCenter(element:DisplayObject, padding:Number = 0):DisplayObject 
		{
			var s:Sprite = new Sprite();
			element.x = element.width * 0.5+padding;
			element.y = element.height * 0.5+padding;
			s.addChild(element);
			return s;
		}
		
		static public function wrap(element:DisplayObject, padding:Number = 0):DisplayObject 
		{
			var s:Sprite = new Sprite();
			element.x = element.y = padding;
			DrawUtil.rect(s.graphics, 0, 0, element.width + padding * 2, element.height + padding * 2, 0x000000, 0);
			s.addChild(element);
			return s;
		}
		
		static public function scaleTo(displayObject:DisplayObject, widthMax:Number, heightMax:Number):DisplayObject 
		{
			var widthRatio:Number = widthMax/displayObject.width;
			var heightRatio:Number = heightMax/displayObject.height;
			if (widthRatio >= 1 || heightRatio >= 1) return displayObject;
			var ratio:Number = Math.min(widthRatio, heightRatio);
			displayObject.scaleX = displayObject.scaleY = ratio;
			return displayObject;
		}
		
		static public function placeGroup(elements:Array, parent:Object):void 
		{
			var length:uint = elements.length;
			for (var i:int = 0; i < length; i++) 
				parent.addChild(elements[i]);
		}
		
	}
}