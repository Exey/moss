package exey.moss.render3d.utils 
{
	import alternativa.engine3d.alternativa3d;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.VertexAttributes;
	import alternativa.engine3d.resources.Geometry;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class Alternativa3DUtil 
	{
		//use alternativa3d
		//
		//static public function copyGeometry(source:Object3D, target:Object3D):void 
		//{
			//for  (var i:int = 0; i< p.numSurfaces; i++)
				//target.addSurface(null, p.getSurface(i).indexBegin, p.getSurface(i).numTriangles);
		//}
		static public function terrainTiling(geometry:Geometry, multiplierX:Number, multiplierY:Number):void
		{
			var uvs:Vector.<Number> = geometry.getAttributeValues(VertexAttributes.TEXCOORDS[0]);
			var j:String;
			for (j in uvs) {
				if (Number(j) % 2 == 0) uvs[j] *= multiplierX
				else if (Number(j) % 2 == 1) uvs[j] *= multiplierY;
			}
			geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0], uvs);	
		}
		
	}
}