package
{
	import cz.hotmusic.Main;
	import cz.hotmusic.model.Model;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
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
			addChild(splash);
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.mouseEnabled = this.mouseChildren = false;
//			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			
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