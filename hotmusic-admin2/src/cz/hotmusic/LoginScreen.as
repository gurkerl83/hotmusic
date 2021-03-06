package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Alert;
	import cz.hotmusic.component.ChangePasswordPanel;
	import cz.hotmusic.component.SongFormComponent;
	import cz.hotmusic.lib.controller.MyServiceLocator;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.helper.ErrorHelper;
	import cz.hotmusic.lib.model.User;
	import cz.hotmusic.model.Model;
	import cz.zc.mylib.helper.DateHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.PickerList;
	import feathers.controls.Screen;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class LoginScreen extends Screen
	{
		public function LoginScreen()
		{
			super();
		}
		
		private var logo:Image;
		private var loginTI:TextInput;
		private var passwordTI:TextInput;
		private var signInBtn:Button;
		private var version:Label;
		
		// testing
//		private var songc:SongFormComponent;
		
		override protected function initialize():void {
			super.initialize();
			
			// initialize
			logo = new Image(Texture.fromBitmap(new FontAssets.LogoSmall()));
			
			loginTI = new TextInput();
			loginTI.prompt = "login";
			loginTI.name = "textinputblack";
			
			passwordTI = new TextInput();
			passwordTI.prompt = "password";
			passwordTI.name = "textinputblack";
			passwordTI.displayAsPassword = true;
			
			signInBtn = new Button();
			signInBtn.label = "Sign in";
			signInBtn.addEventListener(starling.events.Event.TRIGGERED, signInBtn_TriggeredHandler);
			
			version = new Label();
			version.name = Theme.TINY_NORMAL_WHITE;
			version.text = MyServiceLocator.version;
			
			// adding
			addChild(logo);
			addChild(loginTI);
			addChild(passwordTI);
			addChild(signInBtn);
			addChild(version);
			// testing
//			songc = new SongFormComponent();
//			songc.orderNumber = "1.";
//			songc.label = "Song name";
//			addChild(songc);
		}
		
		private var firstTimeLogin:Boolean;
		private function signInBtn_TriggeredHandler(event:starling.events.Event):void
		{
			var pse:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.LOGIN, loginResult, loginFault);
			pse.user = new User();
			pse.user.email = loginTI.text;
			pse.user.password = passwordTI.text;
			pse.sedata = ProfileServiceEvent.ADMIN_TYPE;
			
			if (pse.user.password == "hotmusic")
				firstTimeLogin = true;
			
			CairngormEventDispatcher.getInstance().dispatchEvent(pse);
			
//			if (loginTI.text == "aaa" && passwordTI.text == "aaa")
//			{
//				dispatchEventWith("login");
//			}
		}

		override protected function draw():void {
			super.draw();
			var gap:int = 10;
			var myheight:int = 40;
			var mywidth:int = 200;
			
			logo.x = actualWidth/2 - logo.width/2;
			logo.y = gap*8;
			
			loginTI.height = myheight;
			loginTI.width = mywidth;
			loginTI.x = actualWidth/2 - loginTI.width/2;
			loginTI.y = logo.y + logo.height + 4*gap;
			
			passwordTI.height = myheight;
			passwordTI.width = mywidth;
			passwordTI.x = actualWidth/2 - passwordTI.width/2;
			passwordTI.y = loginTI.y + loginTI.height + gap;
			
			signInBtn.height = myheight;
			signInBtn.width = mywidth;
			signInBtn.x = actualWidth/2 - signInBtn.width/2;
			signInBtn.y = passwordTI.y + passwordTI.height + 2*gap;
			
			// testing
//			songc.y = signInBtn.y + signInBtn.height;
//			songc.width = actualWidth;
		}
		
		private function loginResult(result:ResultEvent):void
		{
			if (result.result == null) {
				Alert.show("Login incorrect!",Alert.ERROR);
				return;
			}
				
			if (!User(result.result).adminRights) {
				Alert.show("You don't have admin rights!",Alert.ERROR);
				return;
			}
			
			Model.getInstance().user = User(result.result);
			
			DataHelper.getInstance().addEventListener(DataHelper.INIT_COMPLETE, function ich(e:flash.events.Event):void {
				removeEventListener(DataHelper.INIT_COMPLETE, ich);
				
				if (!firstTimeLogin)
					dispatchEventWith("login");
			});
			
			// stahni vsechna data
			
			DataHelper.getInstance().initModel(null,  function onInitFault(info:FaultEvent):void {
				Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
			}, Model.getInstance());
			
			// zobraz popup na zmenu hesla
			
			if (firstTimeLogin) {
				var cpp:ChangePasswordPanel = new ChangePasswordPanel();
				cpp.user = Model.getInstance().user;
				cpp.addEventListener("changePassword", function onPasswordChange(event:starling.events.Event):void {
					var se:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.RESET_PASSWORD);
					se.sid = Model.getInstance().user.sid;
					se.user = Model.getInstance().user;
					se.user.password = String(event.data);
					CairngormEventDispatcher.getInstance().dispatchEvent(se);
					
					dispatchEventWith("login");
					PopUpManager.removePopUp(cpp);
				});
				PopUpManager.addPopUp(cpp);
			}
			
		}
		
		private function loginFault(info:FaultEvent):void
		{
			Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString),Alert.ERROR);
		}
		
	}
}