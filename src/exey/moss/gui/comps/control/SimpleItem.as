package exey.moss.gui.comps.control 
{
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.AlignUtil;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class SimpleItem extends Sprite
	{
		private var _id:String;
		public function get id():String { return _id; }
		private var textField:TextField;
		private var bitmap:Bitmap;
		private var maxWidth:Number;
		private var maxHeight:Number;
		private var format:TextFormat;
		
		public function SimpleItem(id:String, maxWidth:Number, maxHeight:Number, title:String = "", bitmap:Bitmap = null, format:TextFormat = null) 
		{
			maxWidth = maxWidth;
			maxHeight = maxHeight;
			_id = id;
			if (!format) this.format = new TextFormat("Verdana");
			else this.format = format
			this.graphics.drawRect(0, 0, maxWidth, maxHeight);
			if (title.length > 0)
				addTitle(title);
			if (bitmap)
				addIcon(bitmap);
		}

		public function addTitle(value:String):void 
		{
			var format:TextFormat = new TextFormat( "Arial", 16, 0x000000, "bold" );
			format.align = TextFormatAlign.CENTER;
			textField = new TextFieldLabel(this, 0, maxHeight + 5, format, value, false);			
			textField.wordWrap = true;
			textField.multiline = true;
			textField.width = maxWidth;
			AlignUtil.toHorizontalCenter(textField, this);
		}		
		
		public function addIcon(bitmap:Bitmap):void 
		{
			bitmap = bitmap;
			if (bitmap.width > maxWidth)
			{
				bitmap.smoothing = true;
				bitmap.height =  bitmap.height * (maxWidth / bitmap.width);
				bitmap.width = maxWidth;
			}
			if (bitmap.height > maxHeight)
			{
				bitmap.smoothing = true;
				bitmap.width =  bitmap.width * (maxHeight / bitmap.height);
				bitmap.height = maxHeight;
			}			
			addChild(bitmap);
		}
		
	}
}