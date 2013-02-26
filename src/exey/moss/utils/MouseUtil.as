package exey.moss.utils 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class MouseUtil 
	{
		
		static public function registerAnimatedCursor(bitmapData:BitmapData, cursorName:String, hotSpot:Point = null):void {
			/*// Create a MouseCursorData object
			var cursorData:MouseCursorData = new MouseCursorData();
			// Specify the hotspot
			cursorData.hotSpot = new Point(15,15);
			// Pass the cursor's bitmap to a BitmapData Vector
			var bitmapDatas:Vector.<BitmapData> = new Vector.<BitmapData>(3, true);
			// Create the bitmap cursor frames 
			// Bitmaps must be 32 x 32 pixels or less, due to an OS limitation
			var frame1Bitmap:Bitmap = new frame1();
			var frame2Bitmap:Bitmap = new frame2();
			var frame3Bitmap:Bitmap = new frame3();
			// Pass the values of the bitmap files to the bitmapDatas vector
			bitmapDatas[0] = frame1Bitmap.bitmapData;
			bitmapDatas[1] = frame2Bitmap.bitmapData;
			bitmapDatas[2] = frame3Bitmap.bitmapData;
			// Assign the bitmap data to the MouseCursor object
			cursorData.data = bitmapDatas;
			// Pass the frame rate of the animated cursor (1fps)
			cursorData.frameRate = 1;
			// Register the MouseCursorData to the Mouse object
			Mouse.registerCursor("myAnimatedCursor", cursorData);
			// When needed for display, pass the alias to the existing cursor property
			Mouse.cursor = "myAnimatedCursor";*/
		}
		
		static public function registerStaticCursor(bitmapData:BitmapData, cursorName:String, hotSpot:Point = null):void {
			if (!hotSpot) hotSpot = new Point(15, 15);
			var cursorData:MouseCursorData = new MouseCursorData();
			cursorData.hotSpot = hotSpot;
			var bitmapDatas:Vector.<BitmapData> = new Vector.<BitmapData>(1, true);
			bitmapDatas[0] = bitmapData;
			cursorData.data = bitmapDatas;
			Mouse.registerCursor(cursorName, cursorData);
		}
		
	}
}