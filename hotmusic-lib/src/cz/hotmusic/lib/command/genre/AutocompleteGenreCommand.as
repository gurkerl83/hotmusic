package cz.hotmusic.lib.command.genre
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.controller.MyServiceLocator;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class AutocompleteGenreCommand implements ICommand, IResponder
	{
		public function AutocompleteGenreCommand()
		{
		}
		
		public var se:GenreServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = GenreServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.GENRE_SERVICE);
			var call:AsyncToken = service.autocomplete(se.sid, se.sedata);
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