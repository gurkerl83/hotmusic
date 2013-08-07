package cz.hotmusic
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	
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
			
			signInBtn = new Button();
			signInBtn.label = "Sign in";
			signInBtn.addEventListener(Event.TRIGGERED, signInBtn_TriggeredHandler);
			
			// adding
			addChild(logo);
			addChild(loginTI);
			addChild(passwordTI);
			addChild(signInBtn);
		}
		
		private function signInBtn_TriggeredHandler(event:Event):void
		{
			if (loginTI.text == "aaa" && passwordTI.text == "aaa")
			{
				dispatchEventWith("login");
			}
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
		
	}
}