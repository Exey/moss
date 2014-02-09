package exey.moss.starling.gui.comps.media 
{
	import colornamegame.data.Conf;
	import exey.moss.starling.gui.abstract.ComponentAbstract;
	import exey.moss.starling.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.BitmapUtil;
	import exey.moss.utils.DrawUtil;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	
	/**
	 * Display Color Progress
	 * @author Exey Panteleev
	 */
	public class ColorProgressBar extends ComponentAbstract 
	{
		private var colorWidth:Number;
		private var barWidth:Number;
		private var barHeight:Number;
		
		private var addedColorLength:int;
		private var flashShape:Shape;
		//private var texture:Texture;
		private var image:Image;
		
		private var percentTF:TextField;
		private var percentValue:Number;
		
		public function ColorProgressBar(parent:DisplayObjectContainer, xpos:Number, ypos:Number, barWidth:Number, barHeight:Number) 
		{
			super(parent, xpos, ypos);
			this.barWidth = barWidth;
			this.barHeight = barHeight;
			addedColorLength = 0;
		}
		
		public function init(colorLength:int, percentTextFormat:TextFormat = null):void 
		{
			var pixelsPerPhoto:Number = barWidth / colorLength;
			colorWidth = (pixelsPerPhoto < 1) ? pixelsPerPhoto : pixelsPerPhoto;
			flashShape = new Shape();
			DrawUtil.rect(flashShape.graphics, 0, 0, barWidth, barHeight, 0, 0)
			image = new Image(Texture.fromBitmapData(new BitmapData(barWidth, barHeight)));
			addChild(image)
			if (percentTextFormat) {
				percentValue = 0;
				percentTF = new TextFieldLabel(this, 0, 0, percentTextFormat, "0.0%", barHeight * 5, barHeight, HAlign.LEFT);
			}
		}
		
		public function addColorWithAnimation(color:uint, time:Number):void 
		{
			var lastTime:Number = getTimer();
			Conf.stage.addEventListener(Event.ENTER_FRAME, function(e:Event):void {
				var newTime:Number = getTimer();
				var delta:Number = (newTime-lastTime) * 0.001;
				var progressRatio:Number = Math.min(delta / time, 1);
				var progressWidth:Number = colorWidth * progressRatio;
				var previousWidth:Number = colorWidth * addedColorLength
				DrawUtil.rect(flashShape.graphics, previousWidth, 0, progressWidth, barHeight, color);
				if (percentTF) updatePercent(colorWidth * addedColorLength + progressWidth + 2, (previousWidth + progressWidth)/barWidth);
				renderBar();
				if (progressRatio >= 1) {
					Conf.stage.removeEventListener(Event.ENTER_FRAME, arguments.callee);
					addedColorLength++;
				}
				//lastTime = newTime;
			})
			//image.texture = Texture.fromBitmapData(BitmapUtil.rasterize(flashShape));
			//image.texture = texture;
		}
		
		public function updatePercent(posX:Number, value:Number):void 
		{
			percentTF.x = posX;
			percentValue = value*100;
			percentTF.text = percentValue.toFixed(1) + "%";
		}
		
		public function addColor(color:uint):void 
		{
			DrawUtil.rect(flashShape.graphics, colorWidth * addedColorLength, 0, colorWidth, barHeight, color);
			addedColorLength++;
			renderBar();
		}
		
		private function renderBar():void {
			if (image.texture) {
				image.texture.dispose();
				image.dispose();
			}
			//trace(percentValue.toFixed(1), image.texture);
			image.texture = Texture.fromBitmapData(BitmapUtil.rasterize(flashShape));
			//image.texture = texture;
		}
		
	}
}