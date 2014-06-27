package exey.moss.helpers 
{
	/**
	 * Layouts
	 * @author Exey Panteleev
	 */
	public class LayoutHelper 
	{
		
		static public function grid(elements:Array, tileSizeX:Number, tileSizeY:Number, cols:uint, gapX:Number, gapY:Number = 0, startX:Number = 0, startY:Number = 0):void 
		{
			var e:Object
			for (var i:int = 0; i < elements.length; i++) 
			{
				e = elements[i]
				e.x = startX + (i % cols) * (tileSizeX + gapX);
				e.y = startY + int(i/cols) * (tileSizeY + gapY);
			}
		}
	}

}