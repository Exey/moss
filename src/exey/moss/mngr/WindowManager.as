package exey.moss.mngr
{
	import com.eclecticdesignstudio.motion.Actuate;
	import exey.moss.gui.comps.window.CenteredWindowAbstract;
	import exey.moss.gui.comps.window.Window;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class WindowManager
	{
		static private var _currentBigWindow:CenteredWindowAbstract;
		static private var _currentSubWindow:CenteredWindowAbstract;
		
		static private var _bigWindowQueue:Array = [];
		static private var _subWindowQueue:Array = [];
		
		static public var container:DisplayObjectContainer;
		
		public function WindowManager(container:DisplayObjectContainer)
		{
			WindowManager.container = container;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Common
		//
		//--------------------------------------------------------------------------
		
		static private function showWindow(window:CenteredWindowAbstract, closeHandler:Function):void
		{
			window.closeSignal.add(closeHandler);
			if (!window.parent)
				container.addChild(window);
			window.animateIn();
		}
		
		static private function destroyWindow(window:CenteredWindowAbstract, closeHandler:Function):void
		{
			window.destroy();
			window = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  BigWindow
		//
		//--------------------------------------------------------------------------
		
		static private function onCloseBigWindow(win:CenteredWindowAbstract):void
		{
			if (!_currentBigWindow) return;
			_currentBigWindow.animateOut();
			if (_bigWindowQueue.length > 0)
				Actuate.timer(CenteredWindowAbstract.ANIMATION_DURATION).onComplete(showBigWindow, _bigWindowQueue.splice(_bigWindowQueue.length - 1, 1)[0]);
		}
		
		static public function destroyBigWindow():void
		{
			if (!_currentBigWindow) return;
			destroyWindow(_currentBigWindow, onCloseBigWindow);
		}
		
		static public function showBigWindow(window:CenteredWindowAbstract):void
		{
			//destroyBigWindow();
			if (_currentBigWindow && _currentBigWindow.parent)
			{
				_bigWindowQueue.push(window);
				return;
			}
			_currentBigWindow = window;
			showWindow(_currentBigWindow, onCloseBigWindow);
		}
		
		//--------------------------------------------------------------------------
		//
		//  SubWindow
		//
		//--------------------------------------------------------------------------
		
		static private function onCloseSubWindow(win:CenteredWindowAbstract):void
		{
			////trace("onCloseSubWindow", _currentSubWindow, _subWindowQueue.length);
			if (!_currentSubWindow) return;
			_currentSubWindow.animateOut();
			if (_subWindowQueue.length > 0)
				Actuate.timer(CenteredWindowAbstract.ANIMATION_DURATION+0.05).onComplete(showSubWindow, _subWindowQueue.splice(_subWindowQueue.length - 1, 1)[0]);
		}
		
		static public function destroySubWindow():void
		{
			if (!_currentSubWindow) return;
			destroyWindow(_currentSubWindow, onCloseSubWindow);
		}
		
		static public function showSubWindow(window:CenteredWindowAbstract):void
		{
			////trace("showSubWindow", _currentSubWindow, _subWindowQueue.length)
			if (_currentSubWindow && _currentSubWindow.parent)
			{
				_subWindowQueue.push(window);
				return;
			}
			//destroySubWindow();
			_currentSubWindow = window;
			showWindow(_currentSubWindow, onCloseSubWindow);
		}
		
		static public function showWindowInCustomContainer(window:CenteredWindowAbstract, container:DisplayObjectContainer):void
		{
			window.closeSignal.addOnce(onCloseWindowInCustomContainer);
			if (!window.parent)
				container.addChild(window);
			window.animateIn();
		}
		
		static private function onCloseWindowInCustomContainer(win:CenteredWindowAbstract):void
		{
			win.animateOut();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Images
		//
		//--------------------------------------------------------------------------
		
		/*static private var _currentImageContainer:Sprite;
		
		static public function showImageByUrl(url:String):void
		{
			WindowManager.removeImage();
			_currentImageContainer = new Sprite();
			LoaderUtils.loadImageTo(url, _currentImageContainer, 0, 100, onLoadToImageContainer);
			_currentImageContainer.addEventListener(MouseEvent.CLICK, removeImage);
			container.addChild(_currentImageContainer);
		}
		
		static private function onLoadToImageContainer(e:LoaderEvent):void
		{
			_currentImageContainer.x = (container.stage.stageWidth-_currentImageContainer.width)*0.5;
			//AlignUtil.toCenter(_currentImageContainer, container);
		}
		
		static public function removeImage(e:MouseEvent = null):void
		{
			if (_currentImageContainer && _currentImageContainer.parent)
				_currentImageContainer.parent.removeChild(_currentImageContainer);
		}*/
	}

}