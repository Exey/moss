package exey.moss.gui.comps.window
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Cubic;
	import exey.moss.utils.AnimationUtil;
	import exey.moss.helpers.stackTrace;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author
	 */
	public class CenteredWindowAbstract extends Sprite {
		private var _width:Number;
		private var _height:Number;
		
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
			//stackTrace(_container.x, _container.y);
		}
		
		public function animateIn():void
		{
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
			if (parent && parent.contains(this))
				parent.removeChild(this);
		}
	}
}