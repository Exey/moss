package exey.moss.starling.view 
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Quad;
	import exey.moss.view.IView;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class AbstractView extends Sprite implements IView
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function AbstractView()
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function show():void
		{
			this.visible = true;
		}
		
		public function fadeOut(duration:Number):void
		{
			Actuate.tween(this, duration, { alpha:0 }).ease(Quad.easeIn).onComplete(hide);
		}
		
		public function fadeIn(duration:Number, delay:Number):void
		{
			if (this.visible)
				return;
			this.alpha = 0;
			show();
			Actuate.tween(this, duration, { alpha:1 } ).ease(Quad.easeIn).delay(delay);
		}
		
	}

}