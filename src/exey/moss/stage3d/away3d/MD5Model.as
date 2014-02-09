package exey.moss.stage3d.away3d {
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.parsers.MD5MeshParser;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import exey.moss.debug.deb;
	import exey.moss.mngr.AssetManager;
	import exey.moss.mngr.data.AssetData;
	import org.osflash.signals.Signal;
	/**
	 * MD5Mesh model loader helper
	 * @author Exey Panteleev
	 */
	public class MD5Model {
		
		public var modelData:*
		public var textureData:*
		
		public var mesh:Mesh
		public var material:TextureMaterial
		
		public var meshComplete:Signal = new Signal();
		
		public function MD5Model(modelURL:String, textureURL:String)
		{
			AssetManager.loadGroup([modelURL, textureURL], assets_loaded)
		}
		
		protected function assets_loaded(data:Vector.<AssetData>):void
		{
			modelData = data[0].content;
			textureData = data[1].content;
			material = new TextureMaterial(new BitmapTexture( textureData.bitmapData));
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, parse_complete);
			AssetLibrary.loadData(modelData, null, null, new MD5MeshParser());
		}
		
		protected function parse_complete(e:AssetEvent):void
		{
			deb(e.asset.assetType, e.asset);
			//AssetLibrary.removeEventListener(AssetEvent.ASSET_COMPLETE, parse_complete);
			if (e.asset.assetType == AssetType.MESH) {
				mesh = e.asset as Mesh;
				mesh.material = material;
				meshComplete.dispatch();
			}
		}
		
	}
}