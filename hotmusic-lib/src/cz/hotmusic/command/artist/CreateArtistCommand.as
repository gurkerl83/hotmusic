package cz.hotmusic.command.artist
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.controller.MyServiceLocator;
	import cz.hotmusic.event.ArtistServiceEvent;
	import cz.hotmusic.event.GenreServiceEvent;
	import cz.hotmusic.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class CreateArtistCommand implements ICommand, IResponder
	{
		public function CreateArtistCommand()
		{
		}
		
		public var se:ArtistServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = ArtistServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.ARTIST_SERVICE);
			var call:AsyncToken = service.create(se.sid, se.artist);
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