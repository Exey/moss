package exey.moss.gui.comps.window
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Cubic;
	import exey.moss.utils.AnimationUtil;
	import flash.display.Sprite;
	import org.osflash.signals.Signal;
	
	/**
	 * Centered Window
	 * @author Exey Panteleev
	 */
	public class CenteredWindowAbstract extends Sprite {
		
		public var closeSignal:Signal = new Signal();
		
		private var _width:Number;
		private var _height:Number;
		
		private var originX:Number;
		private var originY:Number;
		
		static public const ANIMATION_DURATION:Number = 0.33;
		
		protected var _container:Sprite;
		
		public function CenteredWindowAbstract() {
			
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
			_container.graphics.endFill();
			_container.graphics.lineStyle();
			_container.graphics.drawRect(0,0,_width, _height);
			_container.x = -width * 0.5
			_container.y = -height * 0.5
			//deb(_container.x, _container.y);
		}
		
		public function animateIn():void
		{
			originX = this.x
			originY = this.y
			AnimationUtil.flyIn(this, ANIMATION_DURATION, Cubic.easeOut, _width, _height);
			AnimationUtil.fadeIn(this, ANIMATION_DURATION, Cubic.easeIn);
			this.visible = true;
		}

		public function animateOut():void
		{
			AnimationUtil.flyOut(this, ANIMATION_DURATION, Cubic.easeIn);
			AnimationUtil.fadeOut(this, ANIMATION_DURATION, Cubic.easeOut);
			Actuate.timer(ANIMATION_DURATION).onComplete(destroy);
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