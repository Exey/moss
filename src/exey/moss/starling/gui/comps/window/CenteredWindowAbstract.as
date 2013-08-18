package exey.moss.starling.gui.comps.window 
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Cubic;
	import exey.moss.gui.comps.window.ICenteredWindowAbstract;
	import exey.moss.mngr.WindowManager;
	import exey.moss.utils.AnimationUtil;
	import org.osflash.signals.Signal;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class CenteredWindowAbstract extends Sprite implements ICenteredWindowAbstract 
	{
		private var _closeSignal:Signal = new Signal();
		public function get closeSignal():Signal { return _closeSignal;}
		public function set closeSignal(value:Signal):void { _closeSignal = value; }
		
		private var _width:Number;
		private var _height:Number;
		
		private var originX:Number;
		private var originY:Number;		
		
		protected var _container:Sprite;
		
		public function CenteredWindowAbstract() 
		{
			
		}
		
		/**
		 * place into center for animation
		 * @param	width
		 * @param	height
		 */
		protected function initContainer(width:Number, height:Number):void
		{
			_container = new Sprite();
			updateContainerSize(width, height);
			addChild(_container)
		}
		
		public function updateContainerSize(width:Number, height:Number):void 
		{
			this._height = height;
			this._width = width;
			_container.x = -width * 0.5
			_container.y = -height * 0.5
			//deb(_container.x, _container.y);
		}
		
		public function animateIn():void
		{
			originX = this.x
			originY = this.y
			AnimationUtil.flyIn(this, WindowManager.ANIMATION_DURATION, Cubic.easeOut, _width, _height);
			AnimationUtil.fadeIn(this, WindowManager.ANIMATION_DURATION, Cubic.easeIn);
			this.visible = true;
		}

		public function animateOut():void
		{
			AnimationUtil.flyOut(this, WindowManager.ANIMATION_DURATION, Cubic.easeIn);
			AnimationUtil.fadeOut(this, WindowManager.ANIMATION_DURATION, Cubic.easeOut);
			Actuate.timer(WindowManager.ANIMATION_DURATION).onComplete(destroy);
		}
		
		public function destroy():void
		{
			if (parent && parent.contains(this)){
				this.x = originX
				this.y = originY
				parent.removeChild(this);
			}
		}
		
	}
}