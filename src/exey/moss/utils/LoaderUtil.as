package exey.moss.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
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
		
		static public function loadWithURLLoader(url:String, handler:Function, dataFormat:String = null, vars:URLVariables = null, method:String = "GET", antiCache:Boolean = false, errorHandler:Function = null):void 
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, error);
            loader.addEventListener(IOErrorEvent.IO_ERROR, error);
			if (dataFormat)
				loader.dataFormat = dataFormat;
			loader.addEventListener(Event.COMPLETE, function(e:Event = null):void {
				loader.removeEventListener(Event.COMPLETE, arguments.callee);
				handler.apply(null, [e.target.data]);
			});
			var r:URLRequest = new URLRequest(url);
			if (vars) {
				if (antiCache)
					vars.anticache = new Date().getTime()
				r.data = vars;
				r.method = method;
			}
			loader.load(r);
			function error(e:Event):void {
				trace("3:LoaderUtil ERROR", e);
				if (errorHandler != null)
					errorHandler.apply(null, [e]);
			}
		}
		
		static public function loadWithLoader(url:String, handler:Function):void 
		{
			var loader:Loader = new Loader();			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event = null):void {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, arguments.callee);
				handler.apply(null, [e.target.content]);
			});
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent = null):void {
				trace("3:LOADER ERROR ", e.target.url, e)
			});
			loader.load(new URLRequest(url), new LoaderContext(true));
		}		
		
		static public function loadBytesToCurrentDomain(bytes:ByteArray, eventHandler:Function):void 
		{
			var skinLoader:Loader = new Loader();
			skinLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, eventHandler);
			skinLoader.loadBytes(bytes, new LoaderContext(false, ApplicationDomain.currentDomain));
		}
		
		static public function loadBitmap(url:String, handler:Function):void 
		{
			loadWithLoader(url, handler);
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