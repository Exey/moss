package exey.moss.starling.gui.comps.window {
	import exey.moss.factories.GuiFactory;
	import exey.moss.starling.gui.comps.button.EmptyButton;
	import exey.moss.utils.AlignUtil;
	import exey.moss.utils.DrawUtil;
	import exey.moss.utils.PlaceUtil;
	import exey.moss.utils.StarlingUtil;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class Window extends CenteredWindowAbstract {
		
		protected var closeButton:EmptyButton;
		protected var header:WindowHeader;

		public function Window(parent:DisplayObjectContainer, width:Number, height:Number, text:String)
		{
			initialize(width, height, text);
			AlignUtil.toCenter(this, parent);
			this.visible = false;
			if(parent)
				parent.addChild(this);
		}

		protected function initialize(width:Number, height:Number, title:String):void
		{
			initContainer(width, height);
			addHeader(title);
		}

		protected function addHeader(title:String, type:String = "simple", textFormat:TextFormat = null):void
		{
			header = new WindowHeader(_container, 0, 0, title, type, textFormat);
			AlignUtil.toHorizontalCenter(header, _container);
		}

		protected function addCloseButton(width:Number = NaN, tooltipText:String = ""):void
		{
			if (isNaN(width)) width = this.width;
			closeButton = new EmptyButton(_container, width - 30, 5, onClose, true);
			var s:Sprite = GuiFactory.closeButton(0x000000, 0, 0, true, 0xFFFFFF, 0x000000, 0x000000, 1.5);
			DrawUtil.rect(s.graphics, -s.width * 0.05, -s.height * 0.05, s.width * 1.1, s.height * 1.1, 0, 0);
			var cb:DisplayObject = StarlingUtil.imageFromDO(s);
			PlaceUtil.place(cb, closeButton.skin, -s.width*1.5, s.height*0.7);
			//ToolTipManager.addTextToolTip(closeButton, tooltipText);
		}

		protected function onClose(b:EmptyButton):void
		{
			close();
		}

		public function close():void
		{
			closeSignal.dispatch(this);
		}
		
	}
}