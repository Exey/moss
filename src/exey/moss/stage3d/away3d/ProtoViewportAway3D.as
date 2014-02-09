package exey.moss.stage3d.away3d
{
	import away3d.cameras.Camera3D;
	import away3d.containers.View3D;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ProtoViewportAway3D 
	{
		public var view:View3D;
		public var camera:Camera3D;
		
		public function ProtoViewportAway3D(container:DisplayObjectContainer, viewWidth:Number, viewHeight:Number, backgroundColor:uint, xPos:Number = 0, yPos:Number = 0) 
		{
			view = new View3D();
			view.width = viewWidth
			view.height = viewHeight
			view.backgroundColor = backgroundColor;
			view.x = xPos;
			view.y = yPos;
			container.addChild(view);
			
			camera = view.camera;
		}
		
		public function update():void 
		{
			view.render();
		}
		
	}

}