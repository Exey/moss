package exey.moss.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class MovieClipUtil 
	{
		
		static public function stopAll(content:DisplayObjectContainer):void
		{
			if (content is MovieClip)
				(content as MovieClip).stop();
			
			if (content.numChildren)
			{
				var child:DisplayObjectContainer;
				for (var i:int, n:int = content.numChildren; i < n; ++i)
				{
					if (content.getChildAt(i) is DisplayObjectContainer)
					{
						child = content.getChildAt(i) as DisplayObjectContainer;
						
						if (child.numChildren)
							stopAll(child);
						else if (child is MovieClip)
							(child as MovieClip).stop();
					}
				}
			}
		}
		
		static public function playAll(content:DisplayObjectContainer):void
		{
			if (content is MovieClip)
				(content as MovieClip).play();
			
			if (content.numChildren)
			{
				var child:DisplayObjectContainer;
				for (var i:int, n:int = content.numChildren; i < n; ++i)
				{
					if (content.getChildAt(i) is DisplayObjectContainer)
					{
						child = content.getChildAt(i) as DisplayObjectContainer;
						
						if (child.numChildren)
							playAll(child);
						else if (child is MovieClip)
							(child as MovieClip).play();
					}
				}
			}
		}
	}
}