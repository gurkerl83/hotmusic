package
{
	import com.distriqt.extension.facebookutils.FacebookUtils;
	import com.thejustinwalsh.ane.TestFlight;
	
	import cz.hotmusic.Main;
	import cz.hotmusic.model.Model;
	import cz.zc.mylib.helper.LogHelper;
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	[SWF(width="960",height="640",frameRate="60",backgroundColor="#2f2f2f")]
	public class Hotmusic extends Sprite
	{
		[Embed (source="assets/1-loading.png")]
		private var Splash:Class;
		private var splash:Bitmap;
		
		public function Hotmusic()
		{
			super();
			splash = new Splash();
			splash.addEventListener(Event.ENTER_FRAME, onAddedToStage);
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, function (event:Event):void {
				startTestFlight();
			});
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, function (event:Event):void {
				startTestFlight();
			});
			addChild(splash);
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.mouseEnabled = this.mouseChildren = false;
//			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			
		}
		
		private function startTestFlight():void
		{
			try {
				LogHelper.getInstance(this).log("TestFlight.setDeviceIdentifier() starting");
				TestFlight.setDeviceIdentifier();
				LogHelper.getInstance(this).log("TestFlight.setDeviceIdentifier() ended");
			} catch (err:Error) {
				LogHelper.getInstance(this).log(err.getStackTrace());
			}
			try {
				LogHelper.getInstance(this).log("TestFlight.takeOff() starting");
				var takeOffRes:Boolean = TestFlight.takeOff('b16b34e9-e1bb-46d6-a0e0-afc27f2d134c');
				LogHelper.getInstance(this).log("TestFlight.takeOff() ended with result: " + takeOffRes);
			} catch (err:Error) {
				LogHelper.getInstance(this).log(err.getStackTrace());
			}
		}
		
		//Call this once your first Starling view has rendered
		public function removeSplash():void
		{
			if (splash && splash.parent)
			{
				removeChild(splash);
			}
		}
		
		private function onAddedToStage(event:Event):void
		{
			splash.removeEventListener(Event.ENTER_FRAME, onAddedToStage);
			
			Model.getInstance().resetModel();
			// distriqt
			FacebookUtils.init("a95cb5c9288dceac783021d52ed24107c45e48f0BndL53Ei3PQ5uK7LWqJNT1mb6aUE0KiH/cHQIeDcT2xGDoBiDhIEnOO7HfMc8RpyECrdJKhMopbk+O9Pecv3lw==");
//			TestFlightSDK.init("a95cb5c9288dceac783021d52ed24107c45e48f0BndL53Ei3PQ5uK7LWqJNT1mb6aUE0KiH/cHQIeDcT2xGDoBiDhIEnOO7HfMc8RpyECrdJKhMopbk+O9Pecv3lw==");
//			TestFlightSDK.service.startTestFlight("b16b34e9-e1bb-46d6-a0e0-afc27f2d134c");
			
//			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, function (event:InvokeEvent):void {
//				TestFlightSDK.service.startTestFlight("b16b34e9-e1bb-46d6-a0e0-afc27f2d134c");
//			});
			
			//Init Starling
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;

			_starling = new Starling(cz.hotmusic.Main, stage);
			_starling.enableErrorChecking = false;
			_starling.showStats = true;
			_starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
			_starling.antiAliasing = 1;
			_starling.addEventListener("rootCreated", removeSplash);
			_starling.start();
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		private var _starling:Starling;
		
		private function stage_resizeHandler(event:Event):void
		{
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
			
			const viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this._starling.viewPort = viewPort;
			}
			catch(error:Error) {}
			//this._starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
		}
		
		private function stage_deactivateHandler(event:Event):void
		{
			this._starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		private function stage_activateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			this._starling.start();
		}
		
		
	}
}