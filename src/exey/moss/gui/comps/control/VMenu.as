package exey.moss.gui.comps.control 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class VMenu extends ComponentAbstract 
	{		
		private var _dataProvider:XMLList;
		public var menuLabels:Array;
		
		private var _isOpen:Boolean = false;
		public var labelClick:Signal;
		
		public function VMenu(data:XMLList = null) {
			super(null, 0, 0);
			if(data)
				this.dataProvider = data;
			labelClick = new Signal()
		}
		
		public function set dataProvider(data:XMLList):void {
			this.addChild(createMenuPanel(data));
			_dataProvider = data;
		}
		
		public function get isOpen():Boolean { return _isOpen; }
		
		private function createMenuPanel(xmlList:XMLList):Sprite {
			this.menuLabels = [];
			var menuPanel:Sprite = new Sprite();
			var itemCount:uint = 0;
			var menuLabel:SubButton;
			var item:XML;
			for each(item in xmlList) {
				menuLabel = new SubButton(menuPanel, 0, itemCount * 20, onLabelClick, item.@text);
				//if (item.item.length()) {
					//menuLabel.dropDownList = new DropDownList(this, itemCount * MenuLabel.WIDTH, MenuLabel.HEIGHT);
					//menuLabel.dropDownList.dataProvider = item.item;
					//menuLabel.addEventListener("LabelOver", onLabelOver);
					//menuLabel.dropDownList.hide();
				//}
				this.menuLabels.push(menuLabel);
				itemCount++;
			}
			return menuPanel;
		}
		
		private function onLabelClick(e:Event = null):void
		{
			var menuLabel:SubButton;
			// hide all other items
			//for each(menuLabel in menuLabels) {
				//menuLabel.dropDownList.hide();
			//}
			menuLabel = SubButton(e.target);
			//menuLabel.dropDownList.show(this);
			////trace("ContextMenu onLabelClick");
			//dispatchEvent(new ContextMenuEvent(ContextMenuEvent.LABEL_CLICK, menuLabel.text));
			labelClick.dispatch(menuLabel.text)
			
			hide();
		}
		
		override public function show(parent:DisplayObjectContainer):void {
			_isOpen = true;
			super.show(parent);
		}
		
		override public function hide():void {
			_isOpen = false;
			super.hide();
		}
		
	}

}