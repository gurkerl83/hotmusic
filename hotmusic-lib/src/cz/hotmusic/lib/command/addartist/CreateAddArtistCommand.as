package cz.hotmusic.lib.command.addartist
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.controller.MyServiceLocator;
	import cz.hotmusic.lib.event.AddArtistServiceEvent;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class CreateAddArtistCommand implements ICommand, IResponder
	{
		public function CreateAddArtistCommand()
		{
		}
		
		public var se:AddArtistServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = AddArtistServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.ADDARTIST_SERVICE);
			var call:AsyncToken = service.create(se.sid, se.addArtist);
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