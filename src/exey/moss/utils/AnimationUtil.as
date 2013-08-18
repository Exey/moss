package exey.moss.utils
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Cubic;
	import com.eclecticdesignstudio.motion.easing.Elastic;
	import com.eclecticdesignstudio.motion.easing.equations.ElasticEaseIn;
	import com.eclecticdesignstudio.motion.easing.equations.ElasticEaseOut;
	import com.eclecticdesignstudio.motion.easing.IEasing;
	import com.eclecticdesignstudio.motion.easing.Quad;
	import exey.moss.debug.deb;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class AnimationUtil{
		
		static public function glare(container:DisplayObjectContainer, width:Number, height:Number, rotation:Number, colors:Array, xEnd:Number = 300, duration:Number =2, delay:Number = 2):Shape 
		{
			var glare:Shape = new Shape();
			DrawUtil.gradientRect(glare.graphics, 0, 0, width, height, colors, 1, [1, 1, 1], [0, 255, 255]);
			glare.rotation = rotation;
			glare.blendMode = BlendMode.LIGHTEN;
			PlaceUtil.place(glare, container, 0, 0 )
			Actuate.tween(glare, duration, { x: xEnd } ).delay(delay);
			return glare
		}
		
		static public function flyIn(target:Object, time:Number, ease:IEasing, containerWidth:Number, containerHeight:Number):void
		{
			if(target is DisplayObject) target.cacheAsBitmap = true
			//deb(target.x, target.y)
			target.x = target.x+containerWidth*0.5;
			target.y = target.y+containerHeight*0.5;
			//deb(target.x, target.y, containerWidth, containerHeight)
			target.scaleX = .025;
			target.scaleY = .025;
			Actuate.tween(target, time, { scaleX: 1, scaleY: 1 } ).ease(ease);
		}
		
		static public function flyOut(target:Object, time:Number, ease:IEasing):void
		{
			if(target is DisplayObject) target.cacheAsBitmap = true
			Actuate.tween(target, time, { scaleX: .025, scaleY: .025 } ).ease(ease);
		}
		
		static public function flyOutTo(target:DisplayObject, time:Number, ease:IEasing, destinationPoint:Point):void
		{
			target.cacheAsBitmap = true
			Actuate.tween(target, time, { scaleX: .025, scaleY: .025, x:destinationPoint.x, y:destinationPoint.y } ).ease(ease);
		}
		
		static public function fadeIn(target:Object, time:Number, ease:IEasing, delay:Number = 0):void
		{
			target.alpha = 0
			Actuate.tween(target, time, { alpha: 1}).ease(ease).delay(delay);
		}
		
		static public function fadeOut(target:Object, time:Number, ease:IEasing, completeHandler:Function = null):void
		{
			Actuate.tween(target, time, { alpha: 0}).ease(ease).onComplete(completeHandler);
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
		
		static public function heartbeat(target:Object, time:Number, onComplete:Function = null, minScale:Number = 0.75):void 
		{
			if (!target) return;
			//deb(target, time, target.scaleX, target.scaleY)
			Actuate.tween(target, time * 0.5, { scaleX: minScale, scaleY: minScale } ).ease(Elastic.easeIn).onComplete(function():void{
				Actuate.tween(target, time * 0.5, { scaleX: 1, scaleY: 1 } ).ease(Elastic.easeInOut).onComplete(onComplete);
			})
		}
		
		static public function stopAnimations(target:Object):void 
		{
			Actuate.stop(target);
		}
		
		static public function allSequentialFadeIn(container:Object, totalTime:Number, floatingY:Number = 0):void 
		{
			var c:DisplayObject;
			var timePerAnimation:Number = totalTime / container.numChildren;
			for (var i:int = 0; i < container.numChildren; i++) {
				c = container.getChildAt(i);
				fadeIn(c, timePerAnimation, Quad.easeOut, i*timePerAnimation)
				if (floatingY != 0) {
					c.y += floatingY;
					Actuate.tween(c, timePerAnimation, {y: c.y-floatingY}).ease(Quad.easeOut).delay(i*timePerAnimation)
				}
			}
		}
	}
}