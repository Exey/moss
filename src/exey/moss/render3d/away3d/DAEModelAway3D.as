package exey.moss.render3d.away3d {
	import away3d.containers.ObjectContainer3D;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.AssetLibrary;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.parsers.DAEParser;
	import exey.moss.debug.deb;
	import exey.moss.mngr.AssetManager;
	import exey.moss.mngr.data.AssetData;
	import flash.net.URLRequest;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class DAEModelAway3D {
		
		public var scene:ObjectContainer3D;
		
		public var sceneComplete:Signal = new Signal();
		
		public function DAEModelAway3D(modelURL:String) 
		{
			//AssetManager.load(modelURL, asset_loaded);
			var l3d:Loader3D = new Loader3D();
			l3d.addEventListener(LoaderEvent.RESOURCE_COMPLETE, all_complete);
			l3d.load(new URLRequest(modelURL), new AssetLoaderContext(), null, new DAEParser());
			//return l3d;
		}
			
		//protected function asset_loaded(data:AssetData):void
		//{ 
			//var context:AssetLoaderContext = new AssetLoaderContext();
            //AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, parse_complete, false, 0, true);
            //var loader:Loader3D = new Loader3D();
            //loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, all_complete, false, 0, true);
            //loader.loadData(data.content, context, null, new DAEParser());
		//}
		
		private function all_complete(e:LoaderEvent):void 
		{
			scene = e.target as ObjectContainer3D;
			trace("3:all_complete", e.url)
			sceneComplete.dispatch();
		}
		
		//private function parse_complete(e:AssetEvent):void 
		//{
			//deb(e.asset.assetType, e.asset)	
		//}
		
	}
}