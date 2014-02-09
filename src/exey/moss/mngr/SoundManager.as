package exey.moss.mngr
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Quad;
	import exey.moss.debug.deb;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * Sound manager
	 * @author Exey Panteleev
	 */
	public class SoundManager
	{
		static private var sounds:Vector.<SoundData>;
		static private var ambientSoundData:SoundData;
		
		static public var isAmbient:Boolean = true;
		static public var isSounds:Boolean = true;
		
		public function SoundManager()
		{
			sounds = new Vector.<SoundData>();
		}
		
		static public function addSound(soundName:String, sound:Sound):Boolean 
		{
			for (var i:int = 0; i <sounds.length; i++) {
				if (sounds[i].name == soundName) return false;
			}
			var soundData:SoundData = new SoundData(soundName, sound)
			sounds.push(soundData);
			return true;
		}
		
		static public function removeSound(soundName:String):void
		{
			for (var i:int = 0; i <sounds.length; i++) {
				if (sounds[i].name == soundName) {
					sounds[i] = null;
					sounds.splice(i, 1);
				}
			}
		}
		
		static public function playSound(soundName:String, volume:Number = 1, startTime:Number = 0, loops:int = 0):void
		{
			if (isSounds == false || !sounds) {
				trace("3: CAN'T PLAY "+soundName);
				return;
			}
			var soundData:SoundData; 
			for (var i:int = 0; i < sounds.length; i++) {
				if (sounds[i].name == soundName)
					soundData = sounds[i];
			}
			if (soundData)
				playBySoundData(soundData, volume, startTime, loops)
		}
		
		static public function stopSound(soundName:String, position:Number = NaN):void
		{
			var soundData:SoundData; 
			for (var i:int = 0; i < sounds.length; i++) {
				if (sounds[i].name == soundName) 
					soundData = sounds[i];					
			}
			if (soundData)
				stopBySoundData(soundData, position)
		}
		
		static public function stopAllSounds(stopAmbient:Boolean = false, ambientName:String = ""):void
		{
			for (var i:int = 0; i < sounds.length; i++) { 
				if (!stopAmbient && sounds[i].name == ambientName)
					continue;
				stopBySoundData(sounds[i]);				
			}
		}
		
		static public function playAmbient(soundName:String, volume:Number = 1, fade:Boolean = false):void 
		{			
			var startTime:Number = 0;
			var soundData:SoundData; 
			for (var i:int = 0; i < sounds.length; i++) {
				if (sounds[i].name == soundName) 
					soundData = sounds[i];					
			}
			if (soundData) {
				if (ambientSoundData) {
					stopAmbient();
					ambientSoundData = null;
				}				
				ambientSoundData = soundData;
			} else {
				startTime = ambientSoundData.startTime;
			}
			if (isAmbient == false) return;			
			if (ambientSoundData) {				
				if (fade) {
					playBySoundData(ambientSoundData, 0, startTime, 999999);
					fadeSound(ambientSoundData, volume);
				} else {
					playBySoundData(ambientSoundData, volume, startTime, 999999);
				}
			}
		}
		
		static public function stopAmbient(fade:Boolean = false):void 
		{
			if (fade) fadeSound(ambientSoundData, 0, 1, stopAmbient);
			else stopBySoundData(ambientSoundData);
		}
		
		static public function fadeSound(soundData:SoundData, targetVolume:Number = 0, fadeDuration:Number = 1, onComplete:Function = null):void
		{
			var fadeChannel:SoundChannel = soundData.channel;
			Actuate.tween(fadeChannel.soundTransform, fadeDuration, {volume:targetVolume}).onComplete(onComplete).ease(Quad.easeInOut)
		}
		
		static private function playBySoundData(soundData:SoundData, volume:Number = 1, startTime:Number = 0, loops:int = 0):void 
		{
			soundData.volume = volume;
			soundData.startTime = startTime;
			soundData.loops = loops;
			if (soundData.paused) {
				if(startTime > 0) soundData.position = startTime
				soundData.channel = soundData.sound.play(soundData.position, soundData.loops, new SoundTransform(soundData.volume));
			} else {
				soundData.channel = soundData.sound.play(startTime, soundData.loops, new SoundTransform(soundData.volume));
			}
			soundData.paused = false;
		}
		
		static private function stopBySoundData(soundData:SoundData, position:Number = NaN):void 
		{
			soundData.paused = true;
			if(soundData.channel)
				soundData.channel.stop();
			soundData.position = isNaN(position) ? soundData.channel.position : position;
		}
		
		static public function getSoundChnanel(soundName:String):SoundChannel 
		{
			for (var i:int = 0; i <sounds.length; i++) {
				if (sounds[i].name == soundName) {
					return sounds[i].channel;
				}
			}
			return null;
		}
		
		static public function removeAllSounds():void 
		{
			for (var i:int = 0; i <sounds.length; i++) {
				sounds[i] = null;
				sounds.splice(i, 1);
			}
		}
	}
}
import flash.media.Sound;
import flash.media.SoundChannel;

class SoundData
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