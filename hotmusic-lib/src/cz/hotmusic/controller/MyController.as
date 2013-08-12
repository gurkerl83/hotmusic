package cz.hotmusic.controller
{
	import com.adobe.cairngorm.control.FrontController;
	
	import cz.hotmusic.command.album.CreateAlbumCommand;
	import cz.hotmusic.command.album.ListAlbumCommand;
	import cz.hotmusic.command.album.RemoveAlbumCommand;
	import cz.hotmusic.command.artist.CreateArtistCommand;
	import cz.hotmusic.command.artist.ListArtistCommand;
	import cz.hotmusic.command.artist.RemoveArtistCommand;
	import cz.hotmusic.command.genre.CreateGenreCommand;
	import cz.hotmusic.command.genre.ListGenreCommand;
	import cz.hotmusic.command.genre.RemoveGenreCommand;
	import cz.hotmusic.command.profile.ListUserCommand;
	import cz.hotmusic.command.profile.LoginUserCommand;
	import cz.hotmusic.command.profile.RegisterUserCommand;
	import cz.hotmusic.command.profile.RemoveUserCommand;
	import cz.hotmusic.command.song.CreateSongCommand;
	import cz.hotmusic.command.song.ListSongCommand;
	import cz.hotmusic.command.song.RemoveSongCommand;
	import cz.hotmusic.event.AlbumServiceEvent;
	import cz.hotmusic.event.ArtistServiceEvent;
	import cz.hotmusic.event.GenreServiceEvent;
	import cz.hotmusic.event.ProfileServiceEvent;
	import cz.hotmusic.event.SongServiceEvent;
	import cz.hotmusic.model.Album;
	import cz.hotmusic.model.Artist;
	import cz.hotmusic.model.Genre;
	import cz.hotmusic.model.Song;
	import cz.hotmusic.model.User;
	
	import flash.net.registerClassAlias;
	
	import mx.utils.RpcClassAliasInitializer;
	
	public class MyController extends FrontController
	{
		RpcClassAliasInitializer;
		public function MyController()
		{
			super();
		}
		
		public function init():void {
			RpcClassAliasInitializer.registerClassAliases();
			registerClassAlias("cz.hotmusic.model.Album", Album);
			registerClassAlias("cz.hotmusic.model.Artist", Artist);
			registerClassAlias("cz.hotmusic.model.Genre", Genre);
			registerClassAlias("cz.hotmusic.model.Song", Song);
			registerClassAlias("cz.hotmusic.model.User", User);
			
			// RPC PROFIL SERVICE
			addCommand(ProfileServiceEvent.REGISTER, RegisterUserCommand);
			addCommand(ProfileServiceEvent.LOGIN, LoginUserCommand);
			addCommand(ProfileServiceEvent.LIST, ListUserCommand);
			addCommand(ProfileServiceEvent.REMOVE, RemoveUserCommand);
//			addCommand(ProfileServiceEvent.LIST_COUNT, UpdateProfileCommand);
//			addCommand(ProfileServiceEvent.UPDATE, GetScoreCommand);
//			addCommand(ProfileServiceEvent.DELETE, ValidatePromoCodeCommand);
//			addCommand(ProfileServiceEvent.AUTOCOMPLETE, ValidatePromoCodeCommand);
			
			addCommand(SongServiceEvent.CREATE, CreateSongCommand);
			addCommand(SongServiceEvent.LIST, ListSongCommand);
			addCommand(SongServiceEvent.REMOVE, RemoveSongCommand);
			
			addCommand(ArtistServiceEvent.CREATE, CreateArtistCommand);
			addCommand(ArtistServiceEvent.LIST, ListArtistCommand);
			addCommand(ArtistServiceEvent.REMOVE, RemoveArtistCommand);
			
			addCommand(AlbumServiceEvent.CREATE, CreateAlbumCommand);
			addCommand(AlbumServiceEvent.LIST, ListAlbumCommand);
			addCommand(AlbumServiceEvent.REMOVE, RemoveAlbumCommand);
			
			addCommand(GenreServiceEvent.CREATE, CreateGenreCommand);
			addCommand(GenreServiceEvent.LIST, ListGenreCommand);
			addCommand(GenreServiceEvent.REMOVE, RemoveGenreCommand);
			
		}
	}
}