package cz.hotmusic.command.genre
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.controller.MyServiceLocator;
	import cz.hotmusic.event.GenreServiceEvent;
	import cz.hotmusic.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class RemoveGenreCommand implements ICommand, IResponder
	{
		public function RemoveGenreCommand()
		{
		}
		
		public var se:GenreServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = GenreServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.GENRE_SERVICE);
			var call:AsyncToken = service.remove(se.sid, se.genre);
			call.addResponder(this);
		}
		
		public function result(data:Object):void {
			se.resultCallback.call(this, data);
		}
		
		public function fault(info:Object):void {
			se.faultCallback.call(this, info);
		}
	}
}