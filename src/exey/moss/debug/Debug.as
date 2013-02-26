package exey.moss.debug 
{
	import exey.moss.mngr.KeyboardManager;
	/**
	 * @see http://code.google.com/p/flash-console/
	 * @author Exey Panteleev
	 */
	public class Debug
	{
		static public var Cc:*
		
		static public function addConsole(key:Number):void 
		{
			CONFIG::debug {
				KeyboardManager.bind(192, runDebug);
				
			}
		}
		
	}
}

import flash.display.ColorCorrectionSupport;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Stage;
import flash.utils.getQualifiedClassName;

public class DebugConsole 
{	
	static protected var prevCountArray:Array = [];
	static protected var prevTotal:uint = 0;
	
	static public function show(gameController:GameController):void {
		var Cc:* = com.junkbyte.console.Cc;
		// SET UP
		Cc.startOnStage(_gameController.topContainer, ""); 
		// "`" - change for password. This will start hidden
		//Cc.remotingPassword = null;
		Cc.visible = true; // show console, because having password hides console.
		//Cc.tracing = true; // trace on flash's normal trace
		Cc.commandLine = true; // enable command line

		Cc.width = 807;
		Cc.height = 180;
		//Cc.maxLines = 5000;
		Cc.fpsMonitor = true;
		Cc.memoryMonitor = true;
		Cc.remoting = true;
		
		// Set key to capture display map, - only works when DisplayRoller (RL) is active.
		Cc.setRollerCaptureKey("c");ColorCorrectionSupport

		//Cc.watch(mainRoot, "MainRoot");
		//Cc.store("d", DebugConsole);
		//Cc.quiet = true;
		
		//
		// garbage collection monitor
		//var aSprite:Sprite = new Sprite();
		//Cc.watch(aSprite, "aSprite");
		//Cc.store("sprite", aSprite);
		//aSprite = null;
		// it will probably won't get garbage collected straight away,
		// but if you have debugger version of flash player installed,
		// you can open memory monitor (M) and then press G in that panel to force garbage collect
		
		//
		//Add graph show the mouse X/Y positions
		//Cc.addGraph("mouse", mainRoot.stage,"mouseX", 0xff3333,"mouseX");
		//Cc.addGraph("mouse", mainRoot.stage,"mouseY", 0x3333ff,"Y", new Rectangle(340,225,80,80), true);
	}
	/*
	static public function hide():void 
	{
		Cc.visible = false;
		////trace("hide Cc.visible", Cc.visible)
	}
	
	static public function get isVisible():Boolean { return Cc.visible; }
	
	static public function get flashvars():String 
	{
		//return ObjectUtil.dumper(Conf.flashVarsParameters);
	}		*/
	
	static public function get help():String 
	{
		var s:String = "";
		
		return s;
	}	
}