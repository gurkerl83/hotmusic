package cz.hotmusic.lib.controller
{
	import mx.resources.ResourceManager;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.URLUtil;

	/**
	 * ServiceLocator factory
	 * In this application is used only one service...
	 * 
	 * @author Michal Kolesár <michal@zeleny-ctverec.cz>  
	 */	
	public class MyServiceLocator
	{
		private static var serviceLocator 				:MyServiceLocator;
//		public static const AMF_ENDPOINT				:String = "http://" + URLUtil.SERVER_NAME_TOKEN +":"+ URLUtil.SERVER_PORT_TOKEN +"/envi-war/messagebroker/amf";
		
//		public static const AMF_ENDPOINT				:String = "http://www.hotmusic-app.com:8080/hotmusic-war/messagebroker/amf";
		public static const AMF_ENDPOINT				:String = "http://localhost:8080/hotmusic-war/messagebroker/amf";
		public static const version						:String = "0.0.27";

		public static const PROFILE_SERVICE				:String = "profileService";
		public static const GENRE_SERVICE				:String = "genreService";
		public static const SONG_SERVICE				:String = "songService";
		public static const ARTIST_SERVICE				:String = "artistService";
		public static const ALBUM_SERVICE				:String = "albumService";
		public static const ADDARTIST_SERVICE			:String = "addArtistService";
		
		public static function getInstance() : MyServiceLocator 
		{
			if ( serviceLocator == null )
				serviceLocator = new MyServiceLocator();
			
			return serviceLocator;
		}
		
		public function getService(value:String):RemoteObject {
			switch (value) {
				case PROFILE_SERVICE:
				case GENRE_SERVICE:
				case SONG_SERVICE:
				case ARTIST_SERVICE:
				case ALBUM_SERVICE:
				case ADDARTIST_SERVICE:
					break;
				default:
					throw new Error("nemohu nalezt sluzbu '" + value + "'");
			}
			
			var ro:RemoteObject = new RemoteObject();
			ro.destination = value;
			ro.endpoint = AMF_ENDPOINT;
			
			return ro;
		}
	}
}