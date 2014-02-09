package exey.moss.utils 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * Comfortable work with time
	 * @author Exey Panteleev
	 */
	public class TimeUtil
	{
		static private const EXACT_SECONDS_IN_YEAR:uint = 		31556926; 
		static private const EXACT_SECONDS_IN_MONTH:Number =	2629743.83;	
		static private const EXACT_SECONDS_IN_DAY:uint =		86400;		
		
		static private const SECONDS_IN_MONTH:Number =			60 * 60 * 24 * 30.4167;// non leap year
		static private const SECONDS_IN_DAY:uint = 				60 * 60 * 24;//	86400;
		static private const SECONDS_IN_YEAR:uint = 			SECONDS_IN_DAY * 365;
		
		static private const MILLISECONDS_IN_MINUTE:int = 		1000 * 60;
		static private const MILLISECONDS_IN_HOUR:int = 		1000 * 60 * 60;
		static private const MILLISECONDS_IN_DAY:int = 			1000 * 60 * 60 * 24;		
		
        /** 
		 * returns time in hh:mm:ss format from seconds
		 * @author andrewwright
		 * */
		static public function formatTime(sec:int, delimeter:String = ':'):String
		{
			var hrs:String = (sec > 3600 ? Math.floor(sec / 3600) + delimeter : '');
			var mins:String = (hrs && sec % 3600 < 600 ? '0' : '') + Math.floor(sec % 3600 / 60) + delimeter;
			var secs:String = (sec % 60 < 10 ? '0' : '') + sec % 60;
			return hrs+mins+secs;
		}
		
		static public function formatDate(value:Number, digits:uint = 2):String
		{
			var result:String = "";
			while (result.length == digits - value.toString().length - 1) result += "0";
			return result + value.toString();
		}
		
		static public function timestamp(d:Date):String {
			var s:String = d.fullYear + '-';
			s += prependZero( d.month + 1 ) + '-';
			s += prependZero( d.day ) + '_';
			s += prependZero( d.hours ) + '-';
			s += prependZero( d.minutes ) + '-';
			s += prependZero( d.seconds );			
			function prependZero( n:Number ):String {
				return ( n < 10 ) ? '0' + n : n.toString();
			}			
			return s;
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
				d += ( secs > 1 ) ? String( secs ) + " сек." : "1 секунда";
			}		 
			return d;
		}
		
		private static function insertEndSpace( s:String ):String
		{
			s += ( s.length > 0 ) ? " " : "";
			return s;
		}
		
		static public function delay(func:Function, params:Array, delay:int = 350, repeat:int = 1):void
		{
			var f:Function;
			var timer:Timer = new Timer(delay, repeat);
			timer.addEventListener(TimerEvent.TIMER, f = function():void {
				func.apply(null, params);
				if (timer.currentCount == repeat) {
					timer.removeEventListener(TimerEvent.TIMER, f);
					timer = null;
				}
			});
			timer.start();
		}
		
	}
}