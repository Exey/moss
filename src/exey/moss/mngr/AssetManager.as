package exey.moss.mngr
{
	import exey.moss.mngr.data.AssetData;
	import exey.moss.utils.ObjectUtil;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;
	/**
	 * The load manager for multiple loaders.
	 * It doesn't handle progress event but caches each loaded content which is shared between clients
	 * Content should be allowed by flash player security
	 * @author Exey Panteleev
	 */
	public class AssetManager
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function AssetManager()
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		static private const resourceManagerGroups:Array = new Array();
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		static private var cache:Dictionary = new Dictionary();
		static private var freeLoaders:Vector.<AnyResourceLoader>;
		static private var activeLoaders:Dictionary = new Dictionary();
		static private var pendingHandlers:Dictionary = new Dictionary();
		static private var pendingHandlerCompleteParams:Dictionary = new Dictionary();
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		static public function get(url:String):*
		{
			if (cache[url] != null)
				return cache[url];
			else
				return null;
		}
		
		/**
		 * start load display object
		 * @param url
		 * @param loadHandler function called when the load complete,
		 * if the object with such url already have been loaded the function called immediately
		 * the function takes one parameter of type Object
		 * (which is a loaded content) on success or null on load error
		 */
		static public function load(url:String, loadHandler:Function, ...completeParams):void
		{
			if(cache[url] != null)
			{
				var params:Array = [new AssetData(url, cache[url])];
				params = params.concat(completeParams)
				loadHandler.apply(null, params);
				return;
			}

			if(pendingHandlers[url] == null)
			{
				pendingHandlers[url] = new Vector.<Function>;
			}
			pendingHandlers[url].push(loadHandler);
			pendingHandlerCompleteParams[url] = completeParams;
			if(activeLoaders[url] == null)
			{
				var loader:AnyResourceLoader = getLoader();
				activeLoaders[loader] = url;
				loader.load(url);
			}
		}
		
		/**
		 * cancel the loading which was previously initiated by the load() method
		 * @param url
		 * @param loadHandler
		 */
		static public function cancel(url:String, loadHandler:Function):void
		{
			if(pendingHandlers[url] != null)
			{
				for (var i:int=0;i<pendingHandlers[url].length;i++)
				{
					if(pendingHandlers[url][i] == loadHandler)
					{
						pendingHandlers[url].splice(i,1);
						break;
					}
				}
				if(pendingHandlers[url].length == 0)
				{
					activeLoaders[url].close();
					activeLoaders[url] = null;
					delete activeLoaders[url];
				}
			}
		}

		/**
		 * remove cached objects and free loaders
		 * @param disposeLoaders if false than loaders doesn't disposed
		 */
		static public function clearCache(disposeLoaders:Boolean = true):void
		{
			for (var url:String in cache)
			{
				cache[url] = null;
				delete cache[url];
			}
			if(disposeLoaders && freeLoaders != null)
			{
				while(freeLoaders.length)
				{
					freeLoaders.shift();
				}
			}
		}
		
		/**
		 *
		 * @param	group [url]
		 * @param	errorHandler
		 */
		static public function loadGroup(group:Array, completeHandler:Function = null, id:String = '', ...completeParams):void
		{
			if (id == "")
				id = new Date().getTime().toString();
			unlinkGroupCompleteHandler(id);
			var groupLoaded:Vector.<AssetData> = new Vector.<AssetData>();
			var groupForLoading:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < group.length; i++)
			{
				var url:String = group[i];
				if (AssetManager.get(url))
					groupLoaded.push(new AssetData(url, AssetManager.get(url)));
				else
					groupForLoading.push(url);
			}
			if (groupForLoading.length == 0 && completeHandler != null)
			{
				completeHandler.apply(null, [groupLoaded].concat(completeParams));
			}
			else
			{
				var resourceManagerGroup:AssetManagerGroup = new AssetManagerGroup(groupForLoading, groupLoaded, completeHandler);
				resourceManagerGroup.id = id;
				resourceManagerGroup.completeParams = completeParams;
				resourceManagerGroup.addEventListener(Event.COMPLETE, deleteAssetManagerGroup);
				resourceManagerGroups.push(resourceManagerGroup);
			}
		}
		
		static public function unlinkGroupCompleteHandler(id:String):void
		{
			for (var i:int = 0; i < resourceManagerGroups.length; i++)
			{
				var group:AssetManagerGroup = resourceManagerGroups[i];
				if (group.id == id)
					group.unlinkCompleteHandler();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		static private function deleteAssetManagerGroup(e:Event):void
		{
			var group:AssetManagerGroup = e.target as AssetManagerGroup;
			group.removeEventListener(Event.COMPLETE, deleteAssetManagerGroup);
			var index:uint = resourceManagerGroups.indexOf(group);
			resourceManagerGroups[index] = null;
			resourceManagerGroups.splice(index, 1);
		}

		static private function getLoader():AnyResourceLoader
		{
			if(freeLoaders != null && freeLoaders.length > 0)
			{
				return freeLoaders.shift();
			}
			var loader:AnyResourceLoader = new AnyResourceLoader();
			loader.addEventListener(Event.COMPLETE, completeLoadHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorLoadHandler);
			return loader;
		}

		static private function errorLoadHandler(e:IOErrorEvent):void
		{
			trace("3: ResourceManager ERROR LOAD", e.text)
			handleResult(e.target as AnyResourceLoader);
		}

		static private function completeLoadHandler(e:Event):void
		{
			handleResult(e.target as AnyResourceLoader);
		}

		static private function handleResult(loader:AnyResourceLoader):void
		{
			var url:String = activeLoaders[loader];
			var handlers:Vector.<Function> = pendingHandlers[url];
			if(handlers != null)
			{
				while(handlers.length)
				{
					var handler:Function = handlers.shift();
					var params:Array = [new AssetData(url, loader.content)];
					params = params.concat(pendingHandlerCompleteParams[url])
					delete pendingHandlerCompleteParams[url];
					//trace("================ResourceManager====================", ObjectUtil.getKeys(pendingHandlerCompleteParams).length, "|", params)
					handler.apply(null, params);
				}
				pendingHandlers[url] = null;
				delete pendingHandlers[url];
			}
			if(loader.content)
			{
				cache[url] = loader.content;
				loader.unload();
			}
			activeLoaders[loader] = null;
			delete activeLoaders[loader];
			if(freeLoaders == null)
			{
				freeLoaders = new Vector.<AnyResourceLoader>;
			}
			freeLoaders.push(loader);
		}
		
	}

}

import exey.moss.debug.stackTrace;
import exey.moss.mngr.data.AssetData;
import exey.moss.mngr.AssetManager;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
import flash.system.SecurityDomain;
/**
 * @private
 */
internal final class AssetManagerGroup extends EventDispatcher
{
	private var completeHandler:Function;
	private var groupLoaded:Vector.<AssetData>;
	private var urls:Vector.<String> = new Vector.<String>();
	private var result:Vector.<AssetData>;
	public var id:String;
	public var completeParams:Array
	
	public function AssetManagerGroup(urls:Vector.<String>, groupLoaded:Vector.<AssetData>, completeHandler:Function):void
	{
		this.completeHandler = completeHandler;
		this.groupLoaded = groupLoaded;
		result = new Vector.<AssetData>();
		this.urls = urls;
		
		for (var i:int = 0; i < urls.length; i++)
			AssetManager.load(urls[i], load_complete);
	}
	
	public function unlinkCompleteHandler():void
	{
		completeHandler = null;
	}
	
	private function load_complete(data:AssetData):void
	{
		result.push(data);
		urls.splice(urls.indexOf(data.url), 1);
		if (urls.length == 0 && completeHandler != null)
		{
			completeHandler.apply(null, [result.concat(groupLoaded)].concat(completeParams));
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}

internal final class AnyResourceLoader extends EventDispatcher
{
	public var request:URLRequest;
	public var content:*;
	private var loader:Object;
	
	public function AnyResourceLoader():void 
	{
		
	}
	
	public function load(url:String):void 
	{
		trace("1:LOAD", url);
		request = new URLRequest(url)
		var ext:String = url.substr(url.lastIndexOf('.') + 1, url.length).toLowerCase();
		if (ext == "json" || ext == "js" || ext == "xml" || ext == "tmx" || ext == "dae" || ext == "css")
		{
			loader = new URLLoader()
				//trace("loadNextFile", _currentItem.fileExtension )
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, loader_complete); 
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_error); 				
		}
		else if (ext == "mp3")
		{
			loader = new Sound();
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, loader_complete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_error);
		}
		else
		{
			var context:LoaderContext = new LoaderContext(true, ApplicationDomain.currentDomain);
			if (Security.sandboxType != 'localTrusted') context.securityDomain = SecurityDomain.currentDomain;			
			loader = new Loader();
			loader.load(request, context);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete); 
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_error); 				
		}
	}
	
	public function unload():void
	{
		if (loader is URLLoader) content = (loader as URLLoader).data = null;
		else if (loader is Sound) loader = null;
		else content = (loader as Loader).unload();
		content = null
	}

	private function loader_error(e:IOErrorEvent):void
	{ 
		dispatchEvent(e)
	}
	
	private function loader_complete(e:Event):void
	{
		if (loader is URLLoader)
			content = (loader as URLLoader).data;
		else if (loader is Sound)
			content = loader as Sound;
		else // Loader
			content = (loader as Loader).contentLoaderInfo.content;
		var event:Event = new Event(Event.COMPLETE);
		dispatchEvent(event);
	}
}