package exey.moss.stage3d.utils 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import exey.moss.mngr.AssetManager;
	import exey.moss.mngr.data.AssetData;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class Away3DUtil 
	{
		
		static public function skybox(posX:BitmapData, negX:BitmapData, posY:BitmapData, negY:BitmapData, posZ:BitmapData, negZ:BitmapData):SkyBox 
		{
			return new SkyBox(new BitmapCubeTexture(posX, negX, posY, negY, posZ, negZ));
		}
		
		static public function loadAndAddSkybox(textureUrls:Array, scene:Scene3D = null, onComplete:Function = null):void 
		{
			AssetManager.loadGroup(textureUrls, function(v:Vector.<AssetData>):void {
										var skyBox:SkyBox = skybox(v[0].content.bitmapData, v[1].content.bitmapData, 
																   v[2].content.bitmapData, v[3].content.bitmapData,
																   v[4].content.bitmapData, v[5].content.bitmapData);
										if(scene) scene.addChild(skyBox);
										if (onComplete != null) onComplete.apply(null, [skyBox])
									})
		}
		
	}
}