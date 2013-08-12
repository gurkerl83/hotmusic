package cz.hotmusic.command.profile
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.controller.MyServiceLocator;
	import cz.hotmusic.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class ListUserCommand implements ICommand, IResponder
	{
		public function ListUserCommand()
		{
		}
		
		public var pse:ProfileServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			pse = ProfileServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.PROFILE_SERVICE);
			var call:AsyncToken = service.list(pse.sid);
			call.addResponder(this);
		}
		
		public function result(data:Object):void {
			pse.resultCallback.call(this, data);
		}
		
		public function fault(info:Object):void {
			pse.faultCallback.call(this, info);
		}
	}
}