package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.lib.controller.MyServiceLocator;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.model.User;
	import cz.hotmusic.model.Model;
	import cz.zc.mylib.helper.DateHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	
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
		}
		
		private function signInBtn_TriggeredHandler(event:starling.events.Event):void
		{
			var pse:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.LOGIN, loginResult, loginFault);
			pse.user = new User();
			pse.user.email = loginTI.text;
			pse.user.password = passwordTI.text;
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
			
		}
		
		private function loginResult(result:ResultEvent):void
		{
			if (result.result == null || !User(result.result).adminRights)
				return;
			
			Model.getInstance().user = User(result.result);
			
			DataHelper.getInstance().addEventListener(DataHelper.INIT_COMPLETE, function ich(e:flash.events.Event):void {
				removeEventListener(DataHelper.INIT_COMPLETE, ich);
				dispatchEventWith("login");
			});
			DataHelper.getInstance().initModel(Model.getInstance());
			
		}
		
		private function loginFault(info:Object):void
		{
			
		}
		
	}
}