package exey.moss.gui.comps.window
{
	import exey.moss.factories.GuiFactory;
	import exey.moss.gui.comps.button.EmptyButton;
	import exey.moss.mngr.ToolTipManager;
	import exey.moss.utils.AlignUtil;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * Window
	 * @author Exey Panteleev
	 */
	public class Window extends CenteredWindowAbstract
	{
		//public var closeSignal:Signal = new Signal();
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

		protected function addHeader(title:String, type:String = "simple"):void
		{
			header = new WindowHeader(_container, 0, 0, title, type);
			AlignUtil.toHorizontalCenter(header, _container);
		}

		protected function addCloseButton(width:Number = NaN, tooltipText:String = ""):void
		{
			if (isNaN(width)) width = this.width	
			closeButton = new EmptyButton(_container, width-30, 5, onClose);
			closeButton.addChild(GuiFactory.closeButton());
			closeButton.scaleX = 1.5;
			closeButton.scaleY = 1.5;
			ToolTipManager.addTextToolTip(closeButton, tooltipText);
		}

		protected function onClose(e:MouseEvent):void
		{
			close();
		}

		public function close():void
		{
			closeSignal.dispatch(this);
		}
	}
}