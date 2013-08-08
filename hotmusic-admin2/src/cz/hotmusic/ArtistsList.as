package cz.hotmusic
{
	import cz.hotmusic.helper.ButtonHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ArtistsList extends Screen implements IActionButtons
	{
		public function ArtistsList()
		{
			super();
		}
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().addNewButton("artist")];
			}
			return _actionButtons;
		}
		
		private var label:Label;
		private var detailBtn:Button;
		
		override protected function initialize():void
		{
			super.initialize();
			label = new Label();
			label.text = "ArtistsList";
			label.name = Theme.SMALL_BOLD_ORANGE;
			
			detailBtn = new Button();
			detailBtn.label = "Detail";
			detailBtn.addEventListener(Event.TRIGGERED, detailBtnTriggeredHandler);
			
			addChild(label);
			addChild(detailBtn);
		}
		
		override protected function draw():void
		{
			super.draw();
			detailBtn.y = 100;
		}
		
		private function detailBtnTriggeredHandler(event:Event):void
		{
			dispatchEventWith("showDetail");
		}
	}
}