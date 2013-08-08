package cz.hotmusic
{
	import cz.hotmusic.helper.ButtonHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class SongsList extends Screen implements IActionButtons
	{
		public function SongsList()
		{
			super();
		}
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().addNewButton("song")];
			}
			return _actionButtons;
		}
		
		private var label:Label;
		private var detailBtn:Button;
		
		override protected function initialize():void
		{
			super.initialize();
			label = new Label();
			label.text = "SongsList";
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