package cz.hotmusic.lib.command.profile
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.controller.MyServiceLocator;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class ResetPasswordUserCommand implements ICommand, IResponder
	{
		public function ResetPasswordUserCommand()
		{
		}
		
		public var se:ProfileServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = ProfileServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.PROFILE_SERVICE);
			var call:AsyncToken = service.resetPassword(se.sid, se.user);
			call.addResponder(this);
		}
		
		public function result(data:Object):void {
			if (se.resultCallback != null)
				se.resultCallback.call(this, data);
		}
		
		public function fault(info:Object):void {
			if (se.faultCallback != null)
				se.faultCallback.call(this, info);
		}
	}
}