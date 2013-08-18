package exey.moss.render3d.away3d {
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.PlaneGeometry;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	/**
	 * View template with orbital hover camera
	 * @author Exey Panteleev
	 */
	public class OrbitalViewAway3D extends Sprite
	{
		protected var view:View3D;
		protected var cameraController:HoverController;
		//light objects
		protected var pointLight:PointLight;
		protected var lightPicker:StaticLightPicker;
		//navigation variables
		protected var move:Boolean = false;
		protected var lastPanAngle:Number;
		protected var lastTiltAngle:Number;
		protected var lastMouseX:Number;
		protected var lastMouseY:Number;
		protected var tiltIncrement:Number = 0;
		protected var panIncrement:Number = 0;
		protected var distanceIncrement:Number = 0;
        public const tiltSpeed:Number = 2;
        public const panSpeed:Number = 2;
        public const distanceSpeed:Number = 2;		
		
		public function OrbitalViewAway3D()
		{
			prepareAway3D();
			initLights();
			initListeners();
			//addPlane();
		}
		
		//--------------------------------------------------------------------------
		//
		//  API
		//
		//--------------------------------------------------------------------------
		
		protected function addPlane():void
		{
			var plane:Mesh = new Mesh(new PlaneGeometry(1000, 1000, 10, 10), new ColorMaterial(0xFF8080))
			view.scene.addChild(plane);
			view.camera.lookAt(plane.position)	
		}
		
		protected function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, update);
			view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKey);
		}		
		
		protected function initLights():void
		{
			pointLight = new PointLight();
			view.scene.addChild(pointLight);
            // In version 4, you'll need a lightpicker. Materials must then be registered with it (see initObject)
			lightPicker = new StaticLightPicker([pointLight]);
		}		
		
		protected function prepareAway3D():void
		{
			view = new View3D();
			view.forceMouseMove = true;
			addChild(view);
			cameraController = new HoverController(view.camera, null, 45, 30, 520, 5);
			addChild(new AwayStats(view));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Update
		//
		//--------------------------------------------------------------------------
		
		protected function update(e:Event):void
		{
			if (move) {
				cameraController.panAngle = 0.3*(stage.mouseX - lastMouseX) + lastPanAngle;
				cameraController.tiltAngle = 0.3*(stage.mouseY - lastMouseY) + lastTiltAngle;
			}

			cameraController.panAngle += panIncrement;
			cameraController.tiltAngle += tiltIncrement;
			cameraController.distance += distanceIncrement;

			pointLight.position = view.camera.position;	
			
			cameraController.update()
			view.render();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function onMouseDown(event:MouseEvent):void
		{
			move = true;
			lastPanAngle = cameraController.panAngle;
			lastTiltAngle = cameraController.tiltAngle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
			stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			move = false;
			stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		protected function onStageMouseLeave(event:Event):void { move = false; }
		
		protected function onKey(e:KeyboardEvent):void
		{
			var isDown:Boolean = e.type == KeyboardEvent.KEY_DOWN;
			if (isDown) {
				switch (e.keyCode) {
					case Keyboard.UP: 	 case Keyboard.W: tiltIncrement = tiltSpeed; break;
					case Keyboard.DOWN:  case Keyboard.S: tiltIncrement = -tiltSpeed; break;
					case Keyboard.LEFT:  case Keyboard.A: panIncrement = panSpeed; break;
					case Keyboard.RIGHT: case Keyboard.D: panIncrement = -panSpeed; break;
					case Keyboard.Z: distanceIncrement = distanceSpeed; break;
					case Keyboard.X: distanceIncrement = -distanceSpeed; break;
				}
			} else {
				switch (e.keyCode) {
					case Keyboard.UP: 	case Keyboard.W: case Keyboard.DOWN:  case Keyboard.S: tiltIncrement = 0; break;
					case Keyboard.LEFT: case Keyboard.A: case Keyboard.RIGHT: case Keyboard.D: panIncrement = 0; break;
					case Keyboard.Z:	case Keyboard.X: distanceIncrement = 0; break;
				}
			}
		}
		
	}
}