package exey.moss.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	/**
	 * Loader and Application domain utilits
	 * @author Exey Panteleev
	 */
	public class LoaderUtil
	{
		static public function getFromCurrentDomain(linkage:String, isBitmapData:Boolean = false):*
		{
			var skinClass:* = ApplicationDomain.currentDomain.getDefinition(linkage)
			if (isBitmapData)
				return new skinClass(0, 0)
			else
				return new skinClass()
		}
		
		static public function getDefinition(linkage:String):*
		{
			if(ApplicationDomain.currentDomain.hasDefinition(linkage))
				return ApplicationDomain.currentDomain.getDefinition(linkage);
			else
				return null;
		}
		
		static public function addTo(parent:DisplayObjectContainer, linkage:String, xpos:Number = 0, ypos:Number = 0):DisplayObject
		{
			var displayObject:DisplayObject = getFromCurrentDomain(linkage) as DisplayObject;
			displayObject.x = xpos
			displayObject.y = ypos
			parent.addChild(displayObject)
			return displayObject
		}
		
		static public function addBitmapTo(parent:DisplayObjectContainer, linkage:String, xpos:Number, ypos:Number):DisplayObject
		{
			var bitmap:Bitmap = new Bitmap(getFromCurrentDomain(linkage, true));
			bitmap.x = xpos
			bitmap.y = ypos
			parent.addChild(bitmap)
			return bitmap
		}
		
		static public function loadWithURLLoader(url:String, handler:Function, dataFormat:String = null):void 
		{
			var loader:URLLoader = new URLLoader();
			if (dataFormat)
				loader.dataFormat = dataFormat;
			loader.addEventListener(Event.COMPLETE, function(e:Event = null):void {
				loader.removeEventListener(Event.COMPLETE, arguments.callee);
				handler.apply(null, [e.target.data]);
			});
			loader.load(new URLRequest(url));
		}
		
		static public function loadBytesToCurrentDomain(bytes:ByteArray, eventHandler:Function):void 
		{
			var skinLoader:Loader = new Loader();
			skinLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, eventHandler);
			skinLoader.loadBytes(bytes, new LoaderContext(false, ApplicationDomain.currentDomain));
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