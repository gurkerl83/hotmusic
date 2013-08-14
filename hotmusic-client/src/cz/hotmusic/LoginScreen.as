package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.facebook.graph.FacebookMobile;
	import com.facebook.graph.data.FacebookSession;
	
	import cz.hotmusic.helper.LoginHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.model.User;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.SharedObject;
	
	import mx.rpc.events.ResultEvent;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class LoginScreen extends Screen
	{
		public function LoginScreen()
		{
			super();
		}
		
		private var _logo:Image;
		private var _emailTI:TextInput;
		private var _passwordTI:TextInput;
		private var _loginBtn:Button;
		private var _loginFBBtn:Button;
		private var _createAccountBtn:Button;
		private var _forgottenPassword:Label;
		private var _line:Quad;
		
		override protected function initialize():void
		{
			
			_logo = new Image(Texture.fromBitmap(new FontAssets.Logo()));
			
			_emailTI = new TextInput();
			_emailTI.prompt = "e-mail";
			_emailTI.name = "textinputblack";
			
			_passwordTI = new TextInput();
			_passwordTI.prompt = "password";
			_passwordTI.name = "textinputblack";
			
			_loginBtn = new Button();
			_loginBtn.addEventListener(starling.events.Event.TRIGGERED, function (event:starling.events.Event):void {
				LoginHelper.getInstance().login(_emailTI.text, _passwordTI.text, false, function(result:ResultEvent):void
				{
					Model.getInstance().user = User(result.result);
					
					DataHelper.getInstance().addEventListener(DataHelper.INIT_COMPLETE, function ich(e:flash.events.Event):void {
						removeEventListener(DataHelper.INIT_COMPLETE, ich);
						dispatchEventWith("login");
					});
					DataHelper.getInstance().initModel(Model.getInstance());
				})
			});
			_loginBtn.label = "Sign in";
			
			_forgottenPassword = new Label();
			_forgottenPassword.text = "forgotten password?";
			
			_line = new Quad(1,1,0x444444);
			
			_loginFBBtn = new Button();
			_loginFBBtn.label = "Facebook login";
			_loginFBBtn.addEventListener(starling.events.Event.TRIGGERED, loginFBBtn_triggeredHandler);
			
			_createAccountBtn = new Button();
			_createAccountBtn.label = "Create new account";
			_createAccountBtn.addEventListener(starling.events.Event.TRIGGERED, function (event:starling.events.Event):void {
				LoginHelper.getInstance().createAccount(_emailTI.text, _passwordTI.text);
//				dispatchEventWith("login");
			});
			
			addChild(_logo);
			addChild(_emailTI);
			addChild(_passwordTI);
			addChild(_loginBtn);
			addChild(_forgottenPassword);
			addChild(_line);
			addChild(_loginFBBtn);
			addChild(_createAccountBtn);
		}
		
		private function loginFBBtn_triggeredHandler(event:starling.events.Event):void
		{
			LoginHelper.getInstance().facebook(actualWidth, actualHeight, function():void
			{
				dispatchEventWith("login");
			});
		}
		
		override protected function draw():void
		{
			var gap:int = 28;
			var padding:int = 70;
			var btnHeight:int = 70;
			
			_logo.x = actualWidth/2 - _logo.width/2;
			_logo.y = padding;
			
			_emailTI.x = padding;
			_emailTI.y = _logo.y + _logo.height + padding;
			_emailTI.width = actualWidth - 2*padding;
			_emailTI.validate();

			_passwordTI.x = padding;
			_passwordTI.y = _emailTI.y + _emailTI.height + gap;
			_passwordTI.width = actualWidth - 2*padding;
			_passwordTI.validate();
			
			_loginBtn.x = padding;
			_loginBtn.y = _passwordTI.y + _passwordTI.height + gap;
			_loginBtn.width = actualWidth - 2*padding;
			_loginBtn.height = btnHeight;
			
			_forgottenPassword.validate();
			_forgottenPassword.y = _loginBtn.y + _loginBtn.height + gap;
			_forgottenPassword.x = actualWidth - padding - _forgottenPassword.width;
			
			_line.y = _forgottenPassword.y + _forgottenPassword.height + gap;
			_line.x = padding;
			_line.width = actualWidth - 2*padding;
			
			_loginFBBtn.width = actualWidth - 2*padding;
			_loginFBBtn.y = _line.y + _line.height + gap;
			_loginFBBtn.x = padding;
			_loginFBBtn.height = btnHeight;
			
			_createAccountBtn.width = actualWidth - 2*padding;
			_createAccountBtn.y = _loginFBBtn.y + _loginFBBtn.height + gap;
			_createAccountBtn.x = padding;
			_createAccountBtn.height = btnHeight;
		}
		
		
	}
}