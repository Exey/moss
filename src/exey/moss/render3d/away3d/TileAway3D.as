package exey.moss.render3d.away3d 
{
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	import flash.display.BitmapData;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class TileAway3D 
	{		
		protected var _matrix:Matrix3D = new Matrix3D();
		protected var _object3D:Mesh;		
		
		public function TileAway3D(bitmapData:BitmapData, size:Number) 
		{
			var geo:PlaneGeometry = new PlaneGeometry(); 
			geo.width = size;
			geo.height = size;
			var mat:TextureMaterial = new TextureMaterial(new BitmapTexture(bitmapData));
			_object3D = new Mesh(geo, mat);			
		}
		
		public function setPosition(x:Number, y:Number, z:Number):void
		{
			var pos:Vector3D = new Vector3D(x, y, z);
			_matrix.position = pos;
			object3D.position = pos;
		}		
		
		public function get object3D():Mesh 
		{
			return _object3D;
		}
		
		public function get matrix():Matrix3D 
		{
			return _matrix;
		}
		
	}

}