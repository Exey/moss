package exey.moss.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	/**
	 * Loader and Application domain utilits
	 * @author Exey Panteleev
	 */
	public class LoaderUtils
	{
		public static function getFromCurrentDomain(linkage:String, isBitmapData:Boolean = false):*
		{
			var skinClass:* = ApplicationDomain.currentDomain.getDefinition(linkage)
			if (isBitmapData)
				return new skinClass(0, 0)
			else
				return new skinClass()
		}
		
		public static function getDefinition(linkage:String):*
		{
			if(ApplicationDomain.currentDomain.hasDefinition(linkage))
				return ApplicationDomain.currentDomain.getDefinition(linkage);
			else
				return null;
		}
		
		public static function addTo(parent:DisplayObjectContainer, linkage:String, xpos:Number = 0, ypos:Number = 0):DisplayObject
		{
			var displayObject:DisplayObject = getFromCurrentDomain(linkage) as DisplayObject;
			displayObject.x = xpos
			displayObject.y = ypos
			parent.addChild(displayObject)
			return displayObject
		}
		
		public static function addBitmapTo(parent:DisplayObjectContainer, linkage:String, xpos:Number, ypos:Number):DisplayObject
		{
			var bitmap:Bitmap = new Bitmap(getFromCurrentDomain(linkage, true));
			bitmap.x = xpos
			bitmap.y = ypos
			parent.addChild(bitmap)
			return bitmap
		}
		
		static public function loadWithURLLoader(url:String, handler:Function):void 
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function(e:Event):void {
				loader.removeEventListener(Event.COMPLETE, arguments.callee);
				handler.apply(null, [e.target.data]);
			});
			loader.load(new URLRequest(url));
		}
		
		/*
		static public function getBitmap(name:String):Bitmap
		{
			return new Bitmap(Bitmap(LoaderMax.getContent(name).rawContent).bitmapData);
		}
		
		static public function loadImageTo(url:String, container:DisplayObjectContainer, xpos:Number = 0, ypos:Number = 0, onComplete:Function = null):void
		{
			var data:Object = { container: container, x: xpos, y: ypos };
			if(onComplete != null)
				data.onComplete = onComplete
			new ImageLoader(url, data).load();
		}*/
	}
}