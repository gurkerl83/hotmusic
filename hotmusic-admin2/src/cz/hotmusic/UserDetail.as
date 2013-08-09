package cz.hotmusic
{
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.helper.ButtonHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
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
		private var adminRightCB:Check;
		private var userRightCB:Check;
		private var genresCB:Check;
		private var usersCB:Check;
		private var addArtistCB:Check;
		
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
			
			adminRightCB = new Check();
			adminRightCB.label = "Admin";
			
			userRightCB = new Check();
			userRightCB.label = "User";
			
			genresCB = new Check();
			genresCB.label = "Authorize item \"Genres\"";
			
			usersCB = new Check();
			usersCB.label = "Authorize item \"Users\"";
			
			addArtistCB = new Check();
			addArtistCB.label = "Authorize item \"+Artist\"";
			
			addChild(firstname);
			addChild(surname);
			addChild(email);
			addChild(adminRightCB);
			addChild(userRightCB);
			addChild(genresCB);
			addChild(usersCB);
			addChild(addArtistCB);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var padding:int = 0;
			var formgap:int = 4;
			var gap:int = 20;
	
			firstname.x = padding;
			firstname.y = padding;
			firstname.width = actualWidth - 2*padding;
			
			surname.x = padding;
			surname.y = firstname.y + firstname.height + formgap;
			surname.width = actualWidth - 2*padding;

			email.x = padding;
			email.y = surname.y + surname.height + formgap;
			email.width = actualWidth - 2*padding;
			
			adminRightCB.x = padding;
			adminRightCB.y = email.y + email.height + 20;
			adminRightCB.validate();
			
			userRightCB.x = adminRightCB.x + adminRightCB.width + 20;
			userRightCB.y = adminRightCB.y;
			userRightCB.validate();
			
			genresCB.x = padding;
			genresCB.y = adminRightCB.y + adminRightCB.height + 20;
			genresCB.validate();
			
			usersCB.x = genresCB.x + genresCB.width + 20;
			usersCB.y = genresCB.y;
			usersCB.validate();

			addArtistCB.x = usersCB.x + usersCB.width + 20;
			addArtistCB.y = genresCB.y;
			addArtistCB.validate();
			
			
		}
	}
}