package exey.moss.helpers 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class LayoutHelper 
	{
		
		static public function grid(elements:Array, tileSize:Number, cols:uint, gapX:Number, gapY:Number, startX:Number = 0, startY:Number = 0):void 
		{
			var e:DisplayObject
			for (var i:int = 0; i < elements.length; i++) 
			{
				e = elements[i]
				e.x = startX + (i % cols) * (tileSize + gapX);
				e.y = startY + int(i/cols) * (tileSize + gapY);
			}
		}
	}

}