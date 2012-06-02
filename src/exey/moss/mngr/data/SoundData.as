package exey.moss.mngr.data
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class SoundData
	{	
		public var name:String;
		public var sound:Sound;
		public var channel:SoundChannel;
		public var position:Number;
		public var paused:Boolean;
		public var volume:Number;
		public var startTime:Number;
		public var loops:int;
		public var pausedByAll:Boolean;
		
		public function SoundData(name:String, sound:Sound) 
		{
			this.name = name;
			this.sound = sound;
			this.channel = new SoundChannel();
			this.position = 0;
			this.paused = true;
			this.volume = 1;
			this.startTime = 0;
			this.loops = 0;
			this.pausedByAll = false;
		}
		
	}
}