package exey.moss.mngr {
	import exey.moss.utils.EventUtil;
	import exey.moss.utils.FileRefUtil;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import leelib.util.flvEncoder.ByteArrayFlvEncoder;
	import leelib.util.flvEncoder.FlvEncoder;
	/**
	 * Encode FLV from BitmapDatas using https://github.com/zeropointnine/leelib
	 * @author Exey Panteleev
	 */
	public class FLVEncodingManager 
	{
		static public var frameRate:int;
		static public var outputWidth:Number;
		static public var outputHeight:Number;
		
		static public var sound:Sound;
		static public var bitmaps:Array;
		
		static private var baFlvEncoder:ByteArrayFlvEncoder;
		
		public function FLVEncodingManager(outputWidth:Number = 640, outputHeight:Number = 360, frameRate:int = 25) 
		{
			FLVEncodingManager.frameRate = frameRate
			FLVEncodingManager.outputWidth = outputWidth
			FLVEncodingManager.outputHeight = outputHeight
			
			FLVEncodingManager.bitmaps = []
			//EncodingManager.sound = new Embed.Soundtrack()
		}
		
		static public function encode(stage:Stage, updateHandler:Function = null, completeHandler:Function = null):void 
		{
			
			// Prepare the audio data
			var baAudio:ByteArray = new ByteArray();
			var seconds:Number = FLVEncodingManager.bitmaps.length / FLVEncodingManager.frameRate;
			FLVEncodingManager.sound.extract(baAudio, seconds * 44000 + 1000); 
			
			// Make FlvEncoder object
			baFlvEncoder = new ByteArrayFlvEncoder(FLVEncodingManager.frameRate);
			baFlvEncoder.setVideoProperties(FLVEncodingManager.outputWidth, FLVEncodingManager.outputHeight);
			baFlvEncoder.setAudioProperties(FlvEncoder.SAMPLERATE_44KHZ, true, true, true);
			baFlvEncoder.start();
			
			// Make FLV:
			var encodeFrameNum:int = 0
			var framesLength:int = FLVEncodingManager.bitmaps.length
			var audioLength:uint = baAudio.length
			var audioOffset:uint
			var audioChunkLength:uint
			EventUtil.onUpdate(stage, function():void {
				if (encodeFrameNum < (framesLength-1)) {
					// encode next frame
					audioOffset = encodeFrameNum * FLVEncodingManager.baFlvEncoder.audioFrameSize
					audioChunkLength = FLVEncodingManager.baFlvEncoder.audioFrameSize
					//trace(encodeFrameNum, framesLength, audioLength, audioOffset, audioChunkLength)
					if ((audioOffset + audioChunkLength) > audioLength)
						audioChunkLength = audioLength - audioOffset
					if(audioChunkLength > 0) {
						var audioChunk:ByteArray = new ByteArray();
						audioChunk.writeBytes(baAudio, audioOffset, audioChunkLength)
					}
					var b:BitmapData = FLVEncodingManager.bitmaps[encodeFrameNum]
					
					FLVEncodingManager.baFlvEncoder.addFrame(b, audioChunk);
					
					if (updateHandler != null)
						updateHandler.apply(null, [encodeFrameNum, framesLength, b])
						
					b.dispose(); // clean up
					encodeFrameNum++					
				}
				else {
					// done					
					stage.removeEventListener(Event.ENTER_FRAME, arguments.callee);
					if (completeHandler != null)
						completeHandler.apply(null, [FLVEncodingManager.baFlvEncoder.byteArray])
					FLVEncodingManager.baFlvEncoder.updateDurationMetadata();					
				}
			})
		}
		
		static public function saveToDisk(fileName:String = "test.flv"):void 
		{
			FileRefUtil.saveBytes(FLVEncodingManager.baFlvEncoder.byteArray, fileName)
			FLVEncodingManager.baFlvEncoder.kill();
		}
		
	}
}