package exey.moss.render3d.alternativa3d
{
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import exey.moss.debug.deb;
	import exey.moss.helpers.BitmapSlicer;
	import exey.moss.mngr.AssetManager;
	import exey.moss.mngr.data.AssetData;
	import exey.moss.render3d.utils.Alternativa3DUtil;
	import exey.moss.utils.LoaderUtil;
	import exey.moss.utils.TmxUtil;
	import flash.display.BitmapData;
	import net.pixelpracht.tmx.TmxMap;
	import org.osflash.signals.Signal;
	/**
	 * TMX Room-like 2D-3D Location for Away3D
	 * tmx must have: ground, walls and cell layers
	 * @example <code>
	 * new TMXLocationAlt3D(viewport.view, -1024, -1024, "home/tmx/map01.tmx", "home/tmx/grounds256.png", "home/tmx/walls256.png");
	 * </code>
	 * @author Exey Panteleev
	 */
	public class TMXLocationAlt3D
	{
		private var merged:Boolean;
		private var transparentMerged:Boolean;
		public var added:Signal = new Signal();
		
		protected var scene:Object3D;
		protected var tiles:Vector.<TileAlt3D>
		protected var offsetX:Number;
		protected var offsetY:Number;
		protected var textureSize:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function TMXLocationAlt3D(scene:Object3D, offsetX:Number, offsetY:Number, tmxUrl:String, groundTexturesUrl:String, wallTexturesUrl:String, textureSize:Number = 256, merged:Boolean = true, transparentMerged:Boolean = false)
		{
			this.transparentMerged = transparentMerged;
			this.merged = merged;
			this.textureSize = textureSize;
			this.offsetY = offsetY;
			this.offsetX = offsetX;
			this.scene = scene;
			LoaderUtil.loadWithURLLoader(tmxUrl, function (data:*):void {
				if (!data) return;
				var tmx:TmxMap = new TmxMap(new XML(data));
				// Create level
				AssetManager.loadGroup([groundTexturesUrl, wallTexturesUrl], 
										resources_loaded,
										"",
										TmxUtil.CSVtoArray2(tmx.getLayer('ground').toCsv()),
										TmxUtil.CSVtoArray2(tmx.getLayer('walls').toCsv()),
										tmx.properties.tileSize,
										tmx.getTileSet('walls_tileset').firstGID);
			});
		}
		
		protected function resources_loaded(datas:Vector.<AssetData>, groundData:Array, wallsData:Array, tileSize:Number, wallsFirstGID:int):void
		{
			// add ground tiles
			var tileSetBitmap:BitmapSlicer = new BitmapSlicer(datas[0].content.bitmapData, textureSize, textureSize); // slice tile set image map
			var t:TileAlt3D;
			var texture:BitmapData;
			var tileId:uint;
			var numCols:int = groundData.length
			var numRows:int = groundData[0].length
			tiles = new Vector.<TileAlt3D>();
			var c:uint;
			var r:uint;
			
			if (merged) {
				var p:Plane = new Plane(numCols*tileSize, numRows*tileSize, numCols, numRows)
				for(c = 0; c < numCols; c++) {
					//deb(c, tiles.length)
					for (r = 0; r < numRows; r++) {
						tileId = groundData[r][c];
						if (tileId != 0) {
							texture = tileSetBitmap.slices[tileId - 1];
							
						}
					}
				}
				var btr:BitmapTextureResource = new BitmapTextureResource(texture);
				var mat:TextureMaterial = new TextureMaterial(btr);
				if(transparentMerged){
					mat.alphaThreshold = 0.5;
					mat.transparentPass = true
					mat.opaquePass = true;
				}
				Alternativa3DUtil.terrainTiling(p.geometry, numCols, numRows)
				p.setMaterialToAllSurfaces(mat);
				
				scene.addChild(p);
				added.dispatch();
			} else {	
				for(c = 0; c < numCols; c++) {
					//deb(c, tiles.length)
					for (r = 0; r < numRows; r++) {
						tileId = groundData[r][c];
						if (tileId != 0) {
							texture = tileSetBitmap.slices[tileId - 1];						
							t = TileAlt3DFactory.createTile3D(texture, tileSize);
							//t.setPosition(c*tileSize, r*tileSize, 0)
							t.setPosition(c*tileSize+offsetX, r*tileSize+offsetY, 0)
							scene.addChild(t.object3D);
							//deb(c, r, t.matrix.position, tileSize, t.object3D.parent);
							tiles.push(t);						
						}
					}
				}
				// add walls
				// TODO
				// add cell
				// TODO
				added.dispatch();
			}
		}
		
	}
}