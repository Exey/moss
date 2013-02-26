package exey.moss.gui.layout 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import exey.moss.gui.abstract.ComponentAbstract;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class HBox extends ComponentAbstract 
	{		
		public var gap:Number = 10
		private var _items:Array;
		
		public function HBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) 
		{
			super(parent, xpos, ypos);
		}
		
		public function set dataProvider(data:Array):void 
		{
			clean();
			_items = [];
			var item:DisplayObject;
			var shiftX:Number = 0
			for (var i:int = 0; i < data.length; i++)
			{				
				item = data[i]
				item.x = shiftX
				item.y = 0
				addChild(item)
				shiftX += item.width + gap;
				_items.push(item);
			}		
		}
		
		public function getItemByProperty(propertyName:String, propertyValue:*):*
		{
			var item:*;
			for (var i:int = 0; i < _items.length; i++) 
			{
				item = _items[i];
				if (item[propertyName] && item[propertyName] == propertyValue)
					return item;
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