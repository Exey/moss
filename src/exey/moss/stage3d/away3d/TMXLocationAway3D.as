package exey.moss.stage3d.away3d {
	import away3d.containers.View3D;
	import exey.moss.helpers.BitmapSlicer;
	import exey.moss.mngr.AssetManager;
	import exey.moss.mngr.data.AssetData;
	import exey.moss.utils.LoaderUtil;
	import exey.moss.utils.TmxUtil;
	import flash.display.BitmapData;
	import net.pixelpracht.tmx.TmxMap;
	/**
	 * TMX Room-like 2D-3D Location for Away3D
	 * tmx must have: ground, walls and cell layers
	 * @example <code>
	 * new TMXLocationAway3D(viewport.view, -1024, -1024, "home/tmx/map01.tmx", "home/tmx/grounds256.png", "home/tmx/walls256.png");
	 * </code>
	 * @author Exey Panteleev
	 */
	public class TMXLocationAway3D {
		private var view:View3D;
		private var tiles:Vector.<TileAway3D>
		private var offsetX:Number;
		private var offsetY:Number;
		private var textureSize:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function TMXLocationAway3D(view:View3D, offsetX:Number, offsetY:Number, tmxUrl:String, groundTexturesUrl:String, wallTexturesUrl:String, textureSize:Number = 256) {
			this.textureSize = textureSize;
			this.offsetY = offsetY;
			this.offsetX = offsetX;
			this.view = view;
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
		
		public function resources_loaded(datas:Vector.<AssetData>, groundData:Array, wallsData:Array, tileSize:Number, wallsFirstGID:int):void {
			// add ground tiles
			var tileSetBitmap:BitmapSlicer = new BitmapSlicer(datas[0].content.bitmapData, textureSize, textureSize); // slice tile set image map
			var t:TileAway3D;
			var texture:BitmapData;
			var tileId:uint;
			var numCols:int = groundData.length
			var numRows:int = groundData[0].length
			tiles = new Vector.<TileAway3D>();
			var c:uint;
			var r:uint;
			for(c = 0; c < numCols; c++) {
				for (r = 0; r < numRows; r++) {
					tileId = groundData[r][c];
					if (tileId != 0) {
						texture = tileSetBitmap.slices[tileId - 1];						
						t = TileAway3DFactory.createTile3D(texture, tileSize);
						//t.setPosition(c*tileSize, r*tileSize, 0)
						t.setPosition(c*tileSize+offsetX, 0, r*tileSize+offsetY)
						view.scene.addChild(t.object3D);
						//deb(c, r, t.matrix.position);
						tiles.push(t);						
					}
				}
			}
			// add walls
			// TODO
			// add cell
			// TODO
		}
		
	}
}