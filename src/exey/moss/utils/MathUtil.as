package exey.moss.utils 
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class MathUtil 
	{
		
		/**degrees to radians*/
		static public function deg2rad(deg:Number):Number
		{
			return deg * Math.PI / 180;
		}

		/**radians to degrees*/
		static public function rad2deg(rad:Number):Number
		{
			return rad * 180 / Math.PI;
		}

		/**random in range*/
		static public function random(from:Number, to:Number, round:Boolean = false):Number
		{
			if (round == true) {
			 return Math.round(Math.random() * ((to+.5) - (from-.5)) + (from-.5));
			} else {
			 return Math.random() * (to - from) + from;
			}
		}

		/**angle betwenn 2 points*/
		static public function angle(fromX:Number, fromY:Number, toX:Number, toY:Number):Number
		{
			return rad2deg(Math.atan2(toY - fromY, toX - fromX))
		}
		
		/**point from angle and distance*/
		static public function pointFromAngle(angle:Number, dist:Number):Point
		{
			var point:Point = new Point();
			var angleRad:Number = deg2rad(angle);
			point.x = dist * Math.sin(-angleRad);
			point.y = dist * Math.cos(angleRad);
			return point;
		}
		
		/**distance between 2 points*/
		static public function distance(fromX:Number, fromY:Number, toX:Number, toY:Number):Number
		{
			var dX:Number = toX - fromX;
			var dY:Number = toY - fromY;
			return Math.sqrt(dX*dX + dY*dY);
		}
		
		static public function distance3d(from:Vector3D, to:Vector3D):void 
		{
			
		}
		
		private function nearRatio(min:Number, max:Number, value:Number):Number
		{
			var length:Number = Math.abs(max - min);
			var nearness:Number = Math.abs(max - value);
			return nearness/length
		}		
		
	}
}