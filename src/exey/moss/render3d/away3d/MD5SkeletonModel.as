package exey.moss.render3d.away3d 
{
	import away3d.animators.data.Skeleton;
	import away3d.animators.nodes.SkeletonClipNode;
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimator;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.parsers.MD5AnimParser;
	import exey.moss.debug.deb;
	import exey.moss.mngr.AssetManager;
	import exey.moss.mngr.data.AssetData;
	import exey.moss.utils.RegExpUtil;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class MD5SkeletonModel extends MD5Model
	{
		public var skeleton:Skeleton;
		public var animationSet:SkeletonAnimationSet;
		public var animator:SkeletonAnimator;
		
		private var animationURLs:Array;
		
		public var animationNodeComplete:Signal = new Signal();
		
		public function MD5SkeletonModel(modelURL:String, textureURL:String, animationURLs:Array = null) 
		{
			super(modelURL, textureURL);
			this.animationURLs = animationURLs;
		}
		
		override protected function parse_complete(e:AssetEvent):void
		{
			//AssetLibrary.removeEventListener(AssetEvent.ASSET_COMPLETE, parse_complete);
			if (e.asset.assetType == AssetType.MESH) {
				mesh = e.asset as Mesh;
				trace("4:MESH", mesh)
				mesh.material = material;
				meshComplete.dispatch();
				loadAnimations()
			} else if (e.asset.assetType == AssetType.SKELETON) {
				trace("4:SKELETON", e.asset);
				skeleton = e.asset as Skeleton;
			} else if (e.asset.assetType == AssetType.ANIMATION_SET) {
				trace("4:ANIMATION_SET", e.asset);
				animationSet = e.asset as SkeletonAnimationSet;
				animator = new SkeletonAnimator(animationSet, skeleton);
				mesh.animator = animator;
			} else if (e.asset.assetType == AssetType.ANIMATION_NODE) {
				trace("4:ANIMATION_NODE", e.asset);
				var node:SkeletonClipNode = e.asset as SkeletonClipNode;
				node.name = e.asset.assetNamespace;
				animationSet.addAnimation(node);
				animationNodeComplete.dispatch(node);
			} else if (e.asset.assetType == AssetType.GEOMETRY) {
				trace("4:GEOMETRY", e.asset);
			} else {deb(e.asset.assetType, e.asset)}
		}
		
		private function loadAnimations():void 
		{
			if (!animationURLs || !animationURLs.length) return;
			AssetManager.loadGroup(animationURLs, animations_loaded)
		}
		
		private function animations_loaded(d:Vector.<AssetData>):void 
		{
			for (var i:int = 0; i < d.length; i++) {
				var fileName:String = RegExpUtil.filenameFromUrl(d[i].url); 
				AssetLibrary.loadData(d[i].content, null, fileName.substr(0, fileName.lastIndexOf(".")), new MD5AnimParser());
			}
		}
		
	}
}