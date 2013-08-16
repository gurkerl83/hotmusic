package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.model.User;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import mx.rpc.events.ResultEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class UserDetail extends Screen implements IActionButtons, IActions
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
		
		private var _data:Object;
		public function get data():Object
		{
			return _data;
		}
		public function set data(value:Object):void
		{
			_data = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function save():void
		{
			if (!firstname.value || !surname.value || !email.value)
				return;
			
			var user:User = new User();
			user.firstname = firstname.value;
			user.surname = surname.value;
			user.email = email.value;
			user.adminRights = adminRightCB.isSelected;
			user.genresAuthorized = genresCB.isSelected;
			user.usersAuthorized = usersCB.isSelected;
			user.addArtistAuthorized = addArtistCB.isSelected;
			
			var se:ProfileServiceEvent = new ProfileServiceEvent(data == null ? ProfileServiceEvent.REGISTER:ProfileServiceEvent.UPDATE, registerResult, registerFault);
			if (data != null) // modify
				user.id = data.id;
			se.user = user;
			se.sid = Model.getInstance().user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
		}
		
		public function clear():void
		{
			firstname.value = "";
			surname.value = "";
			email.value = "";
			adminRightCB.isSelected = false;
			userRightCB.isSelected = true;
			genresCB.isSelected = true;
			usersCB.isSelected = true;
			addArtistCB.isSelected = true;
		}
		
		public function remove():void
		{
			
		}
		
		private function registerResult(result:Object):void
		{
			trace("got result");
			var pse:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.LIST, listResult, listFault);
			pse.sid = Model.getInstance().user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(pse);
		}
		
		private function registerFault(info:Object):void
		{
			trace("got error");
		}
		
		private function listResult(result:ResultEvent):void
		{
			var users:Array = Model.getInstance().users;
			users.splice(0, users.length); // erase array
			
			for each (var u:User in result.result) 
			{
				users.push(u);
			}
			dispatchEventWith("closeDetail");
			
		}
		
		private function listFault(info:Object):void
		{
			trace("got error");
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
//			firstname.value = "Thomas";

			surname = new FormItem();
			surname.orderNumber = "2.";
			surname.label = "Surname";

			email = new FormItem();
			email.orderNumber = "3.";
			email.label = "E-mail";
//			email.value = "thomas90@seznam.cz";
			
			adminRightCB = new Check();
			adminRightCB.label = "Admin";
			adminRightCB.addEventListener(Event.CHANGE, function (event:Event):void {
				if (!adminRightCB.isSelected)
					return;
				adminRightCB.isEnabled = false;
				userRightCB.isEnabled = true;
				userRightCB.isSelected = false;
			});
			
			userRightCB = new Check();
			userRightCB.label = "User";
			userRightCB.isSelected = true;
			userRightCB.addEventListener(Event.CHANGE, function (event:Event):void {
				if (!userRightCB.isSelected)
					return;
				userRightCB.isEnabled = false;
				adminRightCB.isEnabled = true;
				adminRightCB.isSelected = false;
			});
			
			genresCB = new Check();
			genresCB.label = "Authorize item \"Genres\"";
			genresCB.isSelected = true;
			
			usersCB = new Check();
			usersCB.label = "Authorize item \"Users\"";
			usersCB.isSelected = true;
			
			addArtistCB = new Check();
			addArtistCB.label = "Authorize item \"+Artist\"";
			addArtistCB.isSelected = true;
			
			addChild(firstname);
			addChild(surname);
			addChild(email);
			addChild(adminRightCB);
			addChild(userRightCB);
			addChild(genresCB);
			addChild(usersCB);
			addChild(addArtistCB);
			
			firstname.textinput.focusManager.focus = firstname.textinput;
			
//			firstname.nextTabFocus = surname.textinput;
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
			
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				if (data && data.firstname)
					firstname.value = data.firstname;
				if (data && data.surname)
					surname.value = data.surname;
				if (data && data.email)
					email.value = data.email;
				if (data) {
					adminRightCB.isSelected = User(data).adminRights;
					userRightCB.isSelected = !User(data).adminRights;
					genresCB.isSelected = User(data).genresAuthorized;
					usersCB.isSelected = User(data).usersAuthorized;
					addArtistCB.isSelected = User(data).addArtistAuthorized;
				}
			}
		}
	}
}