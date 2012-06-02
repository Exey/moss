package exey.moss.gui.comps.container
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class HBox extends ComponentAbstract 
	{		
		public var gap:Number = 10
		private var _elements:Array;
		
		public function HBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) 
		{
			super(parent, xpos, ypos);
		}
		
		public function addElements(elements:Array):void 
		{
			clean();
			_elements = [];
			var element:DisplayObject;
			var shiftX:Number = 0
			for (var i:int = 0; i < elements.length; i++)
			{				
				element = elements[i]
				element.x = shiftX
				element.y = 0
				addChild(element)
				shiftX += element.width + gap;
				_elements.push(element);
			}		
		}
		
		public function getElementByProperty(propertyName:String, propertyValue:*):*
		{
			var element:*;
			for (var i:int = 0; i < _elements.length; i++) 
			{
				element = _elements[i];
				if (element[propertyName] && element[propertyName] == propertyValue)
					return element;
			}
		}
		
		public function clean():void 
		{
			while (this.numChildren)
				this.removeChildAt(0);
		}
		
		public function destroy():void 
		{
			clean();
			hide();
		}
	}
}