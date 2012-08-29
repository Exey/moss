package exey.moss.gui.comps.window 
{
	import exey.moss.factories.GuiFactory;
	import exey.moss.gui.comps.button.EmptyButton;
	import exey.moss.gui.ToolTipManager;
	import exey.moss.utils.AlignUtil;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev 
	 */
	public class Popup extends CenteredWindowAbstract 
	{
		public var closeSignal:Signal;
		protected var closeButton:EmptyButton;
		protected var header:PopupHeader;
		
		public function Popup(parent:DisplayObjectContainer, width:Number, height:Number, text:String)
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
			closeSignal = new Signal();
		}
		
		protected function addHeader(title:String, type:String = "simple"):void 
		{
			header = new PopupHeader(_container, 0, 0, title, type);
			AlignUtil.toHorizontalCenter(header, _container);
		}
		
		protected function addCloseButton(width:Number = NaN):void
		{
			if (isNaN(width))
				width = this.width			
			closeButton = new EmptyButton(_container, width-80, 5, onClose);
			closeButton.addChild(GuiFactory.closeButton());
			closeButton.scaleX = 1.5;
			closeButton.scaleY = 1.5;
			ToolTipManager.addStaticToolTip(closeButton, "Close");
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