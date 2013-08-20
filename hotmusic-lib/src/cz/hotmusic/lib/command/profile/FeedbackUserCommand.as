package cz.hotmusic.lib.command.profile
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.controller.MyServiceLocator;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class FeedbackUserCommand implements ICommand, IResponder
	{
		public function FeedbackUserCommand()
		{
		}
		
		public var pse:ProfileServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			pse = ProfileServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.PROFILE_SERVICE);
			var call:AsyncToken = service.feedback(pse.sid, pse.sedata);
			call.addResponder(this);
		}
		
		public function result(data:Object):void {
			if (pse.resultCallback) 
				pse.resultCallback.call(this, data);
		}
		
		public function fault(info:Object):void {
			if (pse.faultCallback)
				pse.faultCallback.call(this, info);
		}
	}
}