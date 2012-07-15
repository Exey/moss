package exey.moss.utils 
{
	/**
	 * ...
	 * @author 
	 */
	public class TimeUtil
	{
		static private const EXACT_SECONDS_IN_YEAR:uint = 	31556926; 	// according to Google
		static private const EXACT_SECONDS_IN_MONTH:Number =	2629743.83;	// according to Google
		static private const EXACT_SECONDS_IN_DAY:uint =		86400;		// according to Google
		
		static private const SECONDS_IN_MONTH:Number =		60 * 60 * 24 * 30.4167;// non leap year
		static private const SECONDS_IN_DAY:uint = 			60 * 60 * 24;//	86400;
		static private const SECONDS_IN_YEAR:uint = 			SECONDS_IN_DAY * 365;
		
		static private const MILLISECONDS_IN_MINUTE:int = 	1000 * 60;
		static private const MILLISECONDS_IN_HOUR:int = 		1000 * 60 * 60;
		static private const MILLISECONDS_IN_DAY:int = 		1000 * 60 * 60 * 24;		
		
        /** 
		 * returns time in hh:mm:ss format from seconds
		 * @author andrewwright
		 * */
		static public  function formatTime ( time:Number ):String
		{
			var remainder:Number;
			var hours:Number = time / ( 60 * 60 );			
			remainder = hours - (Math.floor ( hours ));			
			hours = Math.floor ( hours );			
			var minutes:Number = remainder * 60;			
			remainder = minutes - (Math.floor ( minutes ));			
			minutes = Math.floor ( minutes );			
			var seconds:Number = remainder * 60;			
			remainder = seconds - (Math.floor ( seconds ));			
			seconds = Math.floor ( seconds );			
			var hString:String = hours < 10 ? "0" + hours : "" + hours;	
			var mString:String = minutes < 10 ? "0" + minutes : "" + minutes;
			var sString:String = seconds < 10 ? "0" + seconds : "" + seconds;						
			if ( time < 0 || isNaN(time)) return "00:00";									
			if ( hours > 0 )
			{			
				return hString + ":" + mString + ":" + sString;
			}else
			{
				return mString + ":" + sString;
			}
		}
		
		/**
		 * Converting seconds to English readable time duration
		 * @author Dan Florio, aka: polyGeek
		 * http://polygeek.com/flex/513_ConvertSecondsToEnglish/srcview/index.html
		 */
		static public function convertSeconds( n:Number ):String 
		{
			n *= 1000;
			
			var d:String = "";
			var and:String;
			var time:Date = new Date( n );
			
			var years:uint = time.fullYearUTC - 1970;
			var months:uint = time.monthUTC;
			var days:uint = time.dateUTC - 1;
			var hours:uint = time.hoursUTC;
			var mins:uint = time.minutesUTC;
			var secs:uint = time.secondsUTC;
			
			// years	
			if( years > 0 && ( months > 0 || days > 0 || hours > 0 || mins > 0 || secs > 0 ) ) {
				d = ( years > 1 ) ? 
										String( years ) + " years" : 
										"1 year";
			} else if( years > 0 ){
				d = ( years > 1 ) ? 
										String( years ) + " years." : 
										"1 year.";
			}
			
			// months
			if( months > 0 && ( days > 0 || hours > 0 || mins > 0 || secs > 0 ) ) {	
				d = insertEndSpace( d );
				d += ( months > 1 ) ?
										String( months ) + " months" :
										"1 month";
			} else if( months > 0 ) {
				and = ( d.length > 0 ) ? " and " : "";
				d += ( months > 1 ) ?
										and + String( months ) + " months" :
										and + "1 month.";
				
			}
			
			// days
			if( days > 0 && ( hours > 0 || mins > 0 || secs > 0 ) ) {
				d = insertEndSpace( d );
				d += ( days > 1 ) ?
										String( days ) + " дн." :
										"1 день";
			} else if( days > 0 ) {
				and = ( d.length > 0 ) ? " и " : "";
				d += ( days > 1 ) ?
										and + String( days ) + " дн." :
										and + "1 день";
			}
			
			// hours
			if( hours > 0 && ( mins > 0 || secs > 0 ) ) {
				d = insertEndSpace( d );
				d += ( hours > 1 ) ?
										String( hours ) + " час." :
										"1 час";
			} else if( hours > 0 ) {
				and = ( d.length > 0 ) ? " и " : "";
				d += ( hours > 1 ) ?
										and + String( hours ) + " час." :
										and + "1 час";				
			}
			
			// minutes
			if( mins > 0 && secs > 0 ) {
				d = insertEndSpace( d );
				d += ( mins > 1 ) ?
										String( mins ) + " мин." :
										"1 минута";
			} else if( mins > 0 ) {
				and = ( d.length > 0 ) ? " и " : "";
				d += ( mins > 1 ) ?
										and + String( mins ) + " мин." :
										and + "1 минута";
			}
			
			// seconds	
			if( secs > 0 && d.length > 0 ) {
				d += ( secs > 1 ) ?
										" и " + String( secs ) + " сек." :
										" и 1 секунда";
			} else if( secs > 0 ) {
				d = insertEndSpace( d );
				d += ( secs > 1 ) ?
										String( secs ) + " сек." :
										"1 секунда";
			}		 
			return d;
		}
		
		private static function insertEndSpace( s:String ):String
		{
			s += ( s.length > 0 ) ? " " : "";
			return s;
		}
		
	}
}