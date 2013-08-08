package cz.hotmusic
{
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.helper.ButtonHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class UserDetail extends Screen implements IActionButtons
	{
		public function UserDetail()
		{
			super();
		}
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().saveButton, ButtonHelper.inst().cancelButton, ButtonHelper.inst().clearButton];
			}
			return _actionButtons;
		}
		
		private var firstname:FormItem;
		private var surname:FormItem;
		private var email:FormItem;
		
		override protected function initialize():void
		{
			super.initialize();
			
			firstname = new FormItem();
			firstname.orderNumber = "1.";
			firstname.label = "First name";
			firstname.value = "Thomas";

			surname = new FormItem();
			surname.orderNumber = "2.";
			surname.label = "Surname";

			email = new FormItem();
			email.orderNumber = "3.";
			email.label = "E-mail";
			email.value = "thomas90@seznam.cz";
			
			addChild(firstname);
			addChild(surname);
			addChild(email);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var padding:int = 20;
			var gap:int = 6;
	
			firstname.x = padding;
			firstname.y = padding;
			firstname.width = actualWidth - 2*padding;
			
			surname.x = padding;
			surname.y = firstname.y + firstname.height + gap;
			surname.width = actualWidth - 2*padding;

			email.x = padding;
			email.y = surname.y + surname.height + gap;
			email.width = actualWidth - 2*padding;
		}
	}
}