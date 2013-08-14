package
{
	import cz.hotmusic.Main;
	import cz.hotmusic.lib.controller.MyController;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	[SWF(width="1200",height="850",frameRate="60",backgroundColor="#2f2f2f")]
//	[SWF(frameRate="60",backgroundColor="#2f2f2f")]
	public class HotmusicAdmin2 extends Sprite
	{
		public function HotmusicAdmin2()
		{
			super();
			initialize();
		}
		
		private function initialize():void
		{
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			
			addEventListener(Event.ENTER_FRAME, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onAddedToStage);
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			_starling = new Starling(cz.hotmusic.Main, stage);
			_starling.enableErrorChecking = false;
			_starling.showStats = true;
			_starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
			_starling.antiAliasing = 1;
//			_starling.addEventListener("rootCreated", removeSplash);
			_starling.start();
		
			_myController = new MyController();
			_myController.init();
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		private var _myController:MyController;
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