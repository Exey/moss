package exey.moss.utils 
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class PlaceUtil 
	{
		
		public function PlaceUtil() {
			
		}
		
		static public function to(parent:Object, displayObject:Object, xPos:Number = 0, yPos:Number = 0):Object {
			parent.addChild(displayObject)
			displayObject.x = xPos
			displayObject.y = yPos
			return displayObject
		}
		
		static public function place(displayObject:Object, parent:Object, xPos:Number, yPos:Number):Object {
			parent.addChild(displayObject)
			displayObject.x = xPos
			displayObject.y = yPos
			return displayObject
		}
		
		/** Flash/Starling API Universal */
		static public function placeAndAddListener(displayObject:Object, parent:Object, xPos:Number, yPos:Number, handler:Function, event:String):Object {
			parent.addChild(displayObject)
			displayObject.x = xPos
			displayObject.y = yPos
			displayObject.addEventListener(event, handler);
			return displayObject
		}
		
	}

}