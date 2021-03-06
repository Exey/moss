﻿package exey.moss.utils
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	/**
	 * Helpers for working with isometric view
	 * @author Exey Panteleev
	 */
	public class IsoUtil
	{
		/**
		 * 
		 * @param	x screen X
		 * @param	y screen Y
		 * @param	z screen Z
		 * @return space coords
		 */
		static public function screenToSpace(x:Number, y:Number, z:Number = 0, v3d:Vector3D = null):Vector3D 
		{
			var r:Number = 2; // ratio
			if (!v3d) v3d = new Vector3D();
			v3d.x = x / r + y + z;
			v3d.y = y - x / r + z;
			v3d.z = z;
			return v3d;
		}
		
		/**
		 * 
		 * @param	x space X
		 * @param	y space Y
		 * @param	z space Z
		 * @return screen coords
		 */
		static public function spaceToScreen(x:Number, y:Number, z:Number = 0, v3d:Vector3D = null):Vector3D 
		{
			var r:Number = 2; // ratio
			if (!v3d) v3d = new Vector3D();
			v3d.x = x - y;
			v3d.y = (x + y) / r - z;
			v3d.z = z;
			return v3d;
		}
		
		/**
		 * Draw isometric tile on Grpahics, need predefined linesStyle or fill on Grpahics
		 * @param	g Graphics
		 * @param	x top left X
		 * @param	y top left Y
		 * @param	w Width
		 * @param	h Height
		 */
		static public function drawIsometricCell(g:Graphics, x:Number, y:Number, w:Number, h:Number):void 
		{
			var r:Number = 0.5; // ratio
			g.moveTo(x + w * r, y);
			g.lineTo(x + w, 	y + h * r);
			g.lineTo(x + w * r, y + h);
			g.lineTo(x, 		y + h * r);
			g.lineTo(x + w * r, y);
		}
		
		static private const angle:Number = Math.PI/3; // 120 degrees
		static private const xVec:Point = Point.polar(-Math.PI*0.5 + angle, 1);
		static private const yVec:Point = Point.polar(-Math.PI*0.5 - angle, 1);
		static private const zVec:Point = new Point(0, -1);		
		
		static public function project3DtoIsometry(x:Number, y:Number, z:Number):Point 
		{
			return new Point(x*xVec.x + y*yVec.x + z*zVec.x, x*xVec.y + y*yVec.y + z*zVec.y);
		}
	}
}