package exey.moss.mngr
{
	import exey.moss.mngr.data.ResourceData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * The load manager for multiple loaders.
	 * It doesn't handle progress event but caches each loaded content which is shared between clients
	 * Content should be allowed by flash player security
	 * @author Exey Panteleev
	 */
	public class ResourceManager
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ResourceManager()
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
		
		static private var _cache:Dictionary = new Dictionary();
		static private var _freeLoaders:Vector.<Loader>;
		static private var _activeLoaders:Dictionary = new Dictionary();
		static private var _pendingHandlers:Dictionary = new Dictionary();
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		static public function get(url:String):*
		{
			if (_cache[url] != null)
				return _cache[url];
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
		static public function load(url:String, loadHandler:Function):void
		{
			if(_cache[url] != null)
			{
				loadHandler(_cache[url]);
				return;
			}

			if(_pendingHandlers[url] == null)
			{
				_pendingHandlers[url] = new Vector.<Function>;
			}
			_pendingHandlers[url].push(loadHandler);

			if(_activeLoaders[url] == null)
			{
				var loader:Loader = getLoader();
				_activeLoaders[loader] = url;
				loader.load(new URLRequest(url));
			}
		}

		/**
		 * cancel the loading which was previously initiated by the load() method
		 * @param url
		 * @param loadHandler
		 */
		static public function cancel(url:String, loadHandler:Function):void
		{
			if(_pendingHandlers[url] != null)
			{
				for (var i:int=0;i<_pendingHandlers[url].length;i++)
				{
					if(_pendingHandlers[url][i] == loadHandler)
					{
						_pendingHandlers[url].splice(i,1);
						break;
					}
				}
				if(_pendingHandlers[url].length == 0)
				{
					_activeLoaders[url].close();
					_activeLoaders[url] = null;
					delete _activeLoaders[url];
				}
			}
		}

		/**
		 * remove cached objects and free loaders
		 * @param disposeLoaders if false than loaders doesn't disposed
		 */
		static public function clearCache(disposeLoaders:Boolean = true):void
		{
			for (var url:String in _cache)
			{
				_cache[url] = null;
				delete _cache[url];
			}
			if(disposeLoaders && _freeLoaders != null)
			{
				while(_freeLoaders.length)
				{
					_freeLoaders.shift();
				}
			}
		}
		
		/**
		 *
		 * @param	group [url]
		 * @param	errorHandler
		 */
		static public function loadGroup(group:Array, completeHandler:Function = null, id:String = ''):void
		{
			if (id == "")
				id = new Date().getTime().toString();
			unlinkGroupCompleteHandler(id);
			var groupLoaded:Vector.<ResourceData> = new Vector.<ResourceData>();
			var groupForLoading:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < group.length; i++)
			{
				var url:String = group[i];
				if (ResourceManager.get(url))
					groupLoaded.push(new ResourceData(url, ResourceManager.get(url)));
				else
					groupForLoading.push(url);
			}
			//trace("ResourceManagerItem/loadGroupWithCombatBulk", groupForLoading.length, groupForLoading);
			if (groupForLoading.length == 0 && completeHandler != null)
			{
				completeHandler.apply(null, [groupLoaded]);
			}
			else
			{
				var resourceManagerGroup:ResourceManagerGroup = new ResourceManagerGroup(groupForLoading, groupLoaded, completeHandler);
				resourceManagerGroup.id = id;
				resourceManagerGroup.addEventListener(Event.COMPLETE, deleteResourceManagerGroup);
				resourceManagerGroups.push(resourceManagerGroup);
			}
		}
		
		static public function unlinkGroupCompleteHandler(id:String):void
		{
			for (var i:int = 0; i < resourceManagerGroups.length; i++)
			{
				var group:ResourceManagerGroup = resourceManagerGroups[i];
				if (group.id == id)
					group.unlinkCompleteHandler();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		static private function deleteResourceManagerGroup(e:Event):void
		{
			var group:ResourceManagerGroup = e.target as ResourceManagerGroup;
			group.removeEventListener(Event.COMPLETE, deleteResourceManagerGroup);
			var index:uint = resourceManagerGroups.indexOf(group);
			resourceManagerGroups[index] = null;
			resourceManagerGroups.splice(index, 1);
		}

		static private function getLoader():Loader
		{
			if(_freeLoaders != null && _freeLoaders.length > 0)
			{
				return _freeLoaders.shift();
			}
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeLoadHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorLoadHandler);
			return loader;
		}

		static private function errorLoadHandler(event:IOErrorEvent):void
		{
			trace("3: ResourceManager ERROR LOAD", event.text)
			handleResult(LoaderInfo(event.target));
		}

		static private function completeLoadHandler(event:Event):void
		{
			handleResult(LoaderInfo(event.target));
		}

		static private function handleResult(loaderInfo:LoaderInfo):void
		{
			var url:String = _activeLoaders[loaderInfo.loader];
			var handlers:Vector.<Function> = _pendingHandlers[url];
			if(handlers != null)
			{
				while(handlers.length)
				{
					var handler:Function = handlers.shift();
					handler(new ResourceData(url, loaderInfo.content));
				}
				_pendingHandlers[url] = null;
				delete _pendingHandlers[url];
			}
			if(loaderInfo.content)
			{
				_cache[url] = loaderInfo.content;
				loaderInfo.loader.unload();
			}
			_activeLoaders[loaderInfo.loader] = null;
			delete _activeLoaders[loaderInfo.loader];
			if(_freeLoaders == null)
			{
				_freeLoaders = new Vector.<Loader>;
			}
			_freeLoaders.push(loaderInfo.loader);
		}
		
	}

}

import exey.moss.mngr.data.ResourceData;
import exey.moss.mngr.ResourceManager;
import flash.events.Event;
import flash.events.EventDispatcher;
/**
 * @private
 */
internal final class ResourceManagerGroup extends EventDispatcher
{
	private var _completeHandler:Function;
	private var _groupLoaded:Vector.<ResourceData>;
	private var _urls:Vector.<String> = new Vector.<String>();
	private var _result:Vector.<ResourceData>;
	public var id:String;
	
	public function ResourceManagerGroup(urls:Vector.<String>, groupLoaded:Vector.<ResourceData>, completeHandler:Function):void
	{
		_completeHandler = completeHandler;
		_groupLoaded = groupLoaded;
		_result = new Vector.<ResourceData>();
		_urls = urls;
		
		for (var i:int = 0; i < _urls.length; i++)
			ResourceManager.load(urls[i], load_complete);
	}
	
	public function unlinkCompleteHandler():void
	{
		_completeHandler = null;
	}
	
	private function load_complete(data:ResourceData):void
	{
		_result.push(data);
		//trace("loadingItem_complete "+loadingItem.url.url)
		_urls.splice(_urls.indexOf(data.url), 1);
		if (_urls.length == 0 && _completeHandler != null)
		{
			_completeHandler.apply(null, [_result.concat(_groupLoaded)]);
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}