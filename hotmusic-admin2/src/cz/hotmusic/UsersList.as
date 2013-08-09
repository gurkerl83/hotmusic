package cz.hotmusic
{
	import cz.hotmusic.helper.ButtonHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class UsersList extends Screen implements IActionButtons
	{
		public function UsersList()
		{
			super();
		}
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().addNewButton("user")];
			}
			return _actionButtons;
		}
		
		private var label:Label;
		
		override protected function initialize():void
		{
			super.initialize();
			label = new Label();
			label.text = "UsersList";
			label.name = Theme.SMALL_BOLD_ORANGE;
			
			addChild(label);
		}
		
		override protected function draw():void
		{
			super.draw();
		}
	}
}