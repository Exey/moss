package exey.moss.utils
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Cubic;
	import com.eclecticdesignstudio.motion.easing.IEasing;
	import exey.moss.debug.stackTrace;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class AnimationUtil{
		
		static public function flyIn(target:DisplayObject, time:Number, ease:IEasing, containerWidth:Number, containerHeight:Number):void
		{
			target.cacheAsBitmap = true
			//stackTrace(target.x, target.y)
			target.x = target.x+containerWidth*0.5;
			target.y = target.y+containerHeight*0.5;
			//stackTrace(target.x, target.y, containerWidth, containerHeight)
			target.scaleX = .025;
			target.scaleY = .025;
			Actuate.tween(target, time, { scaleX: 1, scaleY: 1 } ).ease(ease);
		}
		
		static public function flyOut(target:DisplayObject, time:Number, ease:IEasing):void
		{
			target.cacheAsBitmap = true
			Actuate.tween(target, time, { scaleX: .025, scaleY: .025 } ).ease(ease);
		}
		
		static public function flyOutTo(target:DisplayObject, time:Number, ease:IEasing, destinationPoint:Point):void
		{
			target.cacheAsBitmap = true
			Actuate.tween(target, time, { scaleX: .025, scaleY: .025, x:destinationPoint.x, y:destinationPoint.y } ).ease(ease);
		}
		
		static public function fadeIn(target:DisplayObject, time:Number, ease:IEasing):void
		{
			target.alpha = 0
			Actuate.tween(target, time, { alpha: 1}).ease(ease);
		}
		
		static public function fadeOut(target:DisplayObject, time:Number, ease:IEasing):void
		{
			Actuate.tween(target, time, { alpha: 0}).ease(ease);
		}
		
		static public function slideY(target:DisplayObject, time:Number, ease:IEasing, newY:Number):void
		{
			Actuate.tween(target, time, {y:newY}).ease(ease);
		}
		
		static public function fadeAndFlyIn(target:DisplayObject, time:Number, containerWidth:Number, containerHeight:Number):void
		{
			AnimationUtil.flyIn(target, time, Cubic.easeOut, containerWidth, containerHeight);
			AnimationUtil.fadeIn(target, time, Cubic.easeIn);
		}
		
		static public function fadeAndFlyOut(target:DisplayObject, time:Number):void
		{
			AnimationUtil.flyOut(target, time, Cubic.easeIn);
			AnimationUtil.fadeOut(target, time, Cubic.easeOut);
		}
	}
}