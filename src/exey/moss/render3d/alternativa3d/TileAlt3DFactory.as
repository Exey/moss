package exey.moss.render3d.alternativa3d 
{
	import flash.display.BitmapData;
	/**
	 * Tile Alternativa3D Factory
	 * @author Exey Panteleev
	 */
	public class TileAlt3DFactory 
	{
		
		static public function createTile3D(bitmapData:BitmapData, size:Number):TileAlt3D 
		{
			var tile:TileAlt3D = new TileAlt3D(bitmapData, size);
			return tile;
		}
		
	}
}