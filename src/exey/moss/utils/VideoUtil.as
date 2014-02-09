package exey.moss.utils 
{
	import flash.media.Camera;
	import flash.media.Video;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class VideoUtil 
	{
		
		static public function addCamera(name:String, width:Number, height:Number, fps:Number = 25, quality:int = 100):Video 
		{
			var v:Video = new Video();
			var c:Camera = Camera.getCamera();
			if (!c) return v;
			c.setMode(width, height, fps);
			c.setQuality(0, quality);
			v.attachCamera(c);
			return v;
		}
		
	}
}