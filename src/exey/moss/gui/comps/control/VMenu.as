package exey.moss.gui.comps.control 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.utils.EventUtil;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class VMenu extends ComponentAbstract 
	{
		
		public var labelClick:Signal;
		
		public var menuLabels:Array;
		
		private var _dataProvider:XMLList;
		public function set dataProvider(data:XMLList):void {
			this.addChild(createMenuPanel(data));
			_dataProvider = data;
		}
		
		private var _enabled:Boolean = true;
		public function get enabled():Boolean {return _enabled;}
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			if (!_enabled) {
				EventUtil.onNextFrame(this, function():void {
					this.alpha = 0.5;
					this.mouseEnabled = false;
					setPropertyForAllElements("enabled", false)
				});
			} else {
				EventUtil.onNextFrame(this, function():void {
					this.mouseEnabled = true;
					setPropertyForAllElements("enabled", true)
					this.alpha = 1;
				});
			}
		}
		
		private var _isOpen:Boolean = false;
		public function get isOpen():Boolean { return _isOpen; }
		
		
		private var menuPanel:Sprite;
		private var textFormat:TextFormat;
		
		/**
		 * Constructor
		 * @param	data
		 * @param	textFormat
		 */
		public function VMenu(data:XMLList = null, textFormat:TextFormat = null) 
		{
			super(null, 0, 0);
			if(textFormat)
				this.textFormat = textFormat;
			else
				this.textFormat = new TextFormat("Tahoma", 9, 0xFFFFFF);
			if(data)
				this.dataProvider = data;
			labelClick = new Signal()
		}
		
		
		public function initFromArray(value:Vector.<String>):Sprite 
		{
			reset();
			this.menuLabels = [];
			menuPanel = new Sprite();
			//var itemCount:uint = 0;
			for (var i:int = 0; i < value.length; i++) {
				this.menuLabels[i] = new SubButton(menuPanel, 0, i * ((textFormat.size as Number)*1.55), onLabelClick, value[i], 1, textFormat, 0x676767, 0.5, 10, 2);
				//itemCount++;
			}
			addChild(menuPanel);
			return menuPanel;
		}
		
		public function reset():void 
		{
			if(menuPanel)
				while (menuPanel.numChildren) menuPanel.removeChildAt(0);
			if(menuLabels)
				menuLabels.length = 0;
		}
		
		override public function show(parent:DisplayObjectContainer):void 
		{
			_isOpen = true;
			super.show(parent);
		}
		
		override public function hide():void 
		{
			_isOpen = false;
			super.hide();
		}
		
		private function setPropertyForAllElements(propertyName:String, propertyValue:*):void {
			var len:int = menuLabels.length;
			var b:SubButton;
			for (var i:int = 0; i < len; i++) {
				b = menuLabels[i];
				b[propertyName] = propertyValue;
			}
		}
		
		private function createMenuPanel(xmlList:XMLList):Sprite 
		{
			this.menuLabels = [];
			var menuPanel:Sprite = new Sprite();
			var itemCount:uint = 0;
			var menuLabel:SubButton;
			var item:XML;
			for each(item in xmlList) {
				menuLabel = new SubButton(menuPanel, 0, itemCount * 20, onLabelClick, item.@text);
				this.menuLabels.push(menuLabel);
				itemCount++;
			}
			return menuPanel;
		}
		
		private function onLabelClick(e:Event = null):void
		{
			e.stopImmediatePropagation();
			var menuLabel:SubButton;
			menuLabel = SubButton(e.currentTarget);
			labelClick.dispatch(menuLabel.text)
			//hide();
		}
		
	}
}