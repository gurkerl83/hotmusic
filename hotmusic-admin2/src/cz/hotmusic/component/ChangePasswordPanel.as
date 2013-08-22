package cz.hotmusic.component
{
	import cz.hotmusic.lib.model.User;
	
	import feathers.controls.Button;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.layout.VerticalLayout;
	
	import org.osmf.layout.HorizontalAlign;
	
	import starling.events.Event;
	
	[Event(name="changePassword", type="starling.events.Event")]
	public class ChangePasswordPanel extends Panel
	{
		
		private var password1TI:TextInput;
		private var password2TI:TextInput;
		private var button:Button;
		
		private var _user:User;
		
		public function ChangePasswordPanel()
		{
			super();
		}
		
		public function get user():User
		{
			return _user;
		}

		public function set user(value:User):void
		{
			_user = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}

		override protected function initialize():void {
			super.initialize();
			
			minWidth = 400;
			
			updateHeader(); 
			
			password1TI = new TextInput();
			password1TI.prompt = "new password";
			password1TI.displayAsPassword = true;
			
			password2TI = new TextInput();
			password2TI.prompt = "re-enter password";
			password2TI.displayAsPassword = true;
			
			button = new Button();
			button.label = "Enter";
			button.addEventListener(Event.TRIGGERED, function onTrigger(event:Event):void {
				if (password1TI.text.length >= 3 && password1TI.text == password2TI.text)
					dispatchEventWith("changePassword", false, password1TI.text);
			});
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 20;
			layout.padding = 20;
			layout.horizontalAlign = HorizontalAlign.CENTER;
			this.layout = layout;
			
			addChild(password1TI);
			addChild(password2TI);
			addChild(button);
		}
		
		override protected function draw():void {
			super.draw();
			
			if (isInvalid(INVALIDATION_FLAG_DATA))
				updateHeader();
		}
		
		private function updateHeader():void {
			if (user)
				headerProperties.title = "Welcome " + user.firstname + " " + user.surname;
		}
	}
}