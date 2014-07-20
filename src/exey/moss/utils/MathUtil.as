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
			if (round == true) return Math.round(Math.random() * ((to+.5) - (from-.5)) + (from-.5));
			else return Math.random() * (to - from) + from;
		}
		
		static public function randomUintSet(max:Number, num:Number, shuffled:Boolean = false):Vector.<uint>
		{
			if (!max || !num) return null;
			var lookup:Vector.<uint> = new Vector.<uint>(max+1);
			for (var i:uint = 0; i < max+1; i++) lookup[i] = i;
			var result:Vector.<uint> = new Vector.<uint>(num);
			for (var j:int = 0; j < num; j++) result[j] = lookup.splice(random(0, lookup.length), 1)[0];
			if (shuffled) {result.sort(function():Boolean {return Math.floor(Math.random() * 2) ? true : false})}
			return result;
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
		
		/** distance in string */
		static public function levenshtein(s1:String, s2:String):uint
		{
		     const len1:uint = s1.length, len2:uint = s2.length;
		     var d:Vector.<Vector.<uint> >=new Vector.<Vector.<uint> >(len1+1);
		     for(i=0; i<=len1; ++i) 
			d[i] = new Vector.<uint>(len2+1);
 
		     d[0][0]=0;
 
		     var i:int;
		     var j:int;
 
		     for(i=1; i<=len1; ++i) d[i][0]=i; //int faster than uint
		     for(i=1; i<=len2; ++i) d[0][i]=i;
 
		     for(i = 1; i <= len1; ++i)
		          for(j = 1; j <= len2; ++j)
		               d[i][j] = Math.min( Math.min(d[i - 1][j] + 1,d[i][j - 1] + 1),
		                           d[i - 1][j - 1] + (s1.charAt(i - 1) == s2.charAt(j - 1) ? 0 : 1) );
		     return(d[len1][len2]);
		}
		
		/** distance in string */
		static public function hamming(s1:String, s2:String):int
		{
			var distance:int = 0;
			for(var i:int=0; i<s1.length; i++)
				if(s1.charAt(i) != s2.charAt(i))
					distance++;
			return distance;
		}	
		
		static public function gcd( i1:int , i2:int ):int
		{
			if ( i2 == 0 )
			{
				return i1 ;
			}
			else if ( i1 == i2 )
			{
				return i1 ;
			}
			else
			{
				var t:int ;
				while( i2 != 0 )
				{
					t  = i2 ;
					i2 = i1 % i2 ;
					i1 = t ;
				}
				return i1 ;
			}
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