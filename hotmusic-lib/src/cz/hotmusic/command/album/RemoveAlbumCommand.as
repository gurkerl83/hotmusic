package cz.hotmusic.command.album
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.controller.MyServiceLocator;
	import cz.hotmusic.event.AlbumServiceEvent;
	import cz.hotmusic.event.GenreServiceEvent;
	import cz.hotmusic.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class RemoveAlbumCommand implements ICommand, IResponder
	{
		public function RemoveAlbumCommand()
		{
		}
		
		public var se:AlbumServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = AlbumServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.ALBUM_SERVICE);
			var call:AsyncToken = service.remove(se.sid, se.album);
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