package exey.moss.gui.comps.window
{
	import exey.moss.factories.GuiFactory;
	import exey.moss.gui.comps.button.EmptyButton;
	import exey.moss.gui.comps.events.WindowEvent;
	import exey.moss.utils.AlignUtil;
	import exey.moss.utils.DrawUtil;
	import exey.moss.utils.LoaderUtil;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author
	 */
	public class Window extends CenteredWindowAbstract
	{
		protected var _tf:TextField;
		protected var _closeButton:Sprite;
		protected var _header:WindowHeader;
		
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
		
		protected function addHeader(title:String, type:String = "simple"):void {
			_header = new WindowHeader(_container, 0, 0, title, type);
			AlignUtil.toHorizontalCenter(_header, _container);
		}
		
		protected function addCloseButton(width:Number = NaN):void {
			if (isNaN(width))
				width = this.width
			_closeButton = GuiFactory.closeButton();
			//_closeButton = new EmptyButton(_container, width-30, 5, onClose);
			//_closeButton.addChild(LoaderUtils.getFromCurrentDomain("CloseButton"));
			//_closeButton.addChild(LoaderUtils.getBitmap("closeButton"));
			
			_closeButton.scaleX = 1.5;
			_closeButton.scaleY = 1.5;
			//ToolTipManager.addStaticToolTip(_closeButton, Conf.lang.CLOSE_BTN);
		}
		
		protected function onClose(e:MouseEvent):void
		{
			close();
			//_closeButton.destroy();
		}
		
		public function close():void
		{
			this.dispatchEvent(new WindowEvent(WindowEvent.CLOSE));
		}
	}
}