package exey.moss.stage3d.away3d 
{
	import flash.display.BitmapData;
	/**
	 * Tile Away3D Factory
	 * @author Exey Panteleev
	 */
	public class TileAway3DFactory 
	{
		
		static public function createTile3D(bitmapData:BitmapData, size:Number):TileAway3D 
		{
			var tile:TileAway3D = new TileAway3D(bitmapData, size);
			return tile;
		}
		
	}

}