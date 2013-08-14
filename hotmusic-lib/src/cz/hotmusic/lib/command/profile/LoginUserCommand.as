package cz.hotmusic.lib.command.profile
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.controller.MyServiceLocator;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class LoginUserCommand implements ICommand, IResponder
	{
		public function LoginUserCommand()
		{
		}
		
		public var pse:ProfileServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			pse = ProfileServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.PROFILE_SERVICE);
			var call:AsyncToken = service.login(pse.user);
			call.addResponder(this);
		}
		
		public function result(data:Object):void {
			pse.resultCallback.call(this, data);
//			logger(this).debug("got result");
//			var se:SimpleStatusEvent = new SimpleStatusEvent(SimpleStatusEvent.FORGET_PASSWORD_EVENT);
//			se.success = true;
//			GameHelper.getInstance().dispatchEvent(se);
		}
		public function fault(info:Object):void {
			pse.faultCallback.call(this, info);
//			var faultEvent:FaultEvent = info as FaultEvent;
//			var se:SimpleStatusEvent = new SimpleStatusEvent(SimpleStatusEvent.FORGET_PASSWORD_EVENT);
//			se.success = false;
//			se.message = faultEvent.fault.faultString + faultEvent.fault.faultDetail;
//			GameHelper.getInstance().dispatchEvent(se);
			
		}
	}
}