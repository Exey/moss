package exey.moss.render3d.alternativa3d 
{
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import flash.display.BitmapData;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class TileAlt3D 
	{
		public var resource:BitmapTextureResource;
		protected var _matrix:Matrix3D = new Matrix3D();
		public function get matrix():Matrix3D {return _matrix;}
		protected var _object3D:Plane;
		public function get object3D():Plane {return _object3D;}
		
		public function TileAlt3D(bitmapData:BitmapData, size:Number) 
		{
			_object3D = new Plane(256, 256);
			_object3D.name = "tile";
			resource = new BitmapTextureResource(bitmapData);
			var material:TextureMaterial = new TextureMaterial(resource);
			_object3D.setMaterialToAllSurfaces(material);
		}
		
		public function setPosition(x:Number, y:Number, z:Number):void
		{
			var pos:Vector3D = new Vector3D(x, y, z);
			_matrix.position = pos;
			_object3D.matrix = _matrix;
		}		
	}
}