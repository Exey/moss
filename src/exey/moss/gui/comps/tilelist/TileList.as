package exey.moss.gui.comps.tilelist
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.debug.deb;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * TileList
	 * @author Exey Panteleev
	 */
	public class TileList extends ComponentAbstract
	{	
		protected var _data:Array;
		protected var _pageNum:uint = 0;
		protected var _step:uint = 6;
		protected var _currentItems:Array;
		protected var _itemClass:Class;
		protected var _columns:uint;
		protected var _rows:uint;
		protected var _horizontalGap:Number;
		protected var _verticalGap:Number;
		public function get step():uint { return _step; }
		public function set step(value:uint):void {_step = value;}
		public function get horizontalGap():Number { return _horizontalGap; }
		public function set horizontalGap(value:Number):void {_horizontalGap = value;}
		public function get verticalGap():Number { return _verticalGap; }
		public function set verticalGap(value:Number):void {_verticalGap = value;}
		public function get data():Array { return _data; }
		public function set data(value:Array):void {
			_data = value;
			showFrom(_pageNum*_step);
		}
		public function set pageNum(value:uint):void  {_pageNum = value;}
		public function get pageNum():uint { return _pageNum; }
		
		public function get columns():uint 
		{
			return _columns;
		}
		
		public function set columns(value:uint):void 
		{
			_columns = value;
		}
		
		
		public function TileList(parent:DisplayObjectContainer, xpos:Number, ypos:Number, columns:uint = 3, gap:Number = 20)
		{
			super(parent, xpos, ypos);
			_columns = columns;
			_horizontalGap = gap;
			_verticalGap = gap;
		}
		
		public function initialize(data:Array, itemClass:Class):void
		{
			//deb(data);
			_data = data;
			_itemClass = itemClass;
			showFrom(0)
		}
		
		public function showFrom(value:Number):void
		{
			var i:uint
			if (_currentItems) {
				for (i = 0; i < _currentItems.length; i++)
					_currentItems[i].destroy();
			}
			_currentItems = []
			var currentData:ITileListItemData;
			var item:ITileListItem;
			var currX:Number
			var currY:Number
			var length:uint = value + _step;
			//deb("length", length);
			for (i = value; i < length; i++) {
				currentData = _data[i];
				if (!currentData) break;
				item = new _itemClass();
				currX = (_horizontalGap + item.itemWidth) * ((i - value) % _columns);		
				currY = (_verticalGap + item.itemHeight) * Math.floor((i - value) / _columns);				
				DisplayObject(item).x = currX;
				DisplayObject(item).y = currY;
				addChild(DisplayObject(item));
				item.data = currentData;
				_currentItems.push(item)
			}
		}
				
		public function next():void
		{
			if ((_pageNum+1) * _step > _data.length) return;
			_pageNum++;
			showFrom(_pageNum*_step);
		}		
		
		public function prev():void
		{
			if (_pageNum == 0) return;
			_pageNum--;
			showFrom(_pageNum*_step);
		}
		
		public function removeAllItems():void
		{
			while (this.numChildren)
				this.removeChild(this.getChildAt(0))
		}
		
		
		public function getItemByProperty(propertyName:String, value:*):ITileListItem
		{
			for (var i:int = 0; i < _currentItems.length; i++) {
				//trace("::::::::", propertyName, value, _currentItems[i][propertyName])
				if (_currentItems[i][propertyName] && _currentItems[i][propertyName] == value)
					return _currentItems[i]
			}
			return null
		}
		
		public function removeItemByProperty(propertyName:String, value:*):void 
		{
			var item:ITileListItem = getItemByProperty(propertyName, value);
			if (item) {
				for (var i:int = 0; i < _data.length; i++) {
					if (item.data == _data[i])
						_data.splice(i, 1);					
				}
				removeChild(DisplayObject(item));
			}
		}
		
		public function clean():void 
		{
			while (this.numChildren)
				this.removeChildAt(0);
			_data = [];
			_pageNum = 0;
		}
		
		public function destroy():void 
		{
			clean();
			hide();
		}
		
	}
}