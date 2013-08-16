package cz.hotmusic.lib.controller
{
	import com.adobe.cairngorm.control.FrontController;
	
	import cz.hotmusic.lib.command.album.AutocompleteAlbumCommand;
	import cz.hotmusic.lib.command.album.CreateAlbumCommand;
	import cz.hotmusic.lib.command.album.ListAlbumCommand;
	import cz.hotmusic.lib.command.album.RemoveAlbumCommand;
	import cz.hotmusic.lib.command.album.UpdateAlbumCommand;
	import cz.hotmusic.lib.command.artist.AutocompleteArtistCommand;
	import cz.hotmusic.lib.command.artist.CreateArtistCommand;
	import cz.hotmusic.lib.command.artist.ListArtistCommand;
	import cz.hotmusic.lib.command.artist.RemoveArtistCommand;
	import cz.hotmusic.lib.command.artist.UpdateArtistCommand;
	import cz.hotmusic.lib.command.genre.AutocompleteGenreCommand;
	import cz.hotmusic.lib.command.genre.CreateGenreCommand;
	import cz.hotmusic.lib.command.genre.ListGenreCommand;
	import cz.hotmusic.lib.command.genre.RemoveGenreCommand;
	import cz.hotmusic.lib.command.genre.UpdateGenreCommand;
	import cz.hotmusic.lib.command.profile.ListUserCommand;
	import cz.hotmusic.lib.command.profile.LoginUserCommand;
	import cz.hotmusic.lib.command.profile.RegisterUserCommand;
	import cz.hotmusic.lib.command.profile.RemoveUserCommand;
	import cz.hotmusic.lib.command.profile.UpdateUserCommand;
	import cz.hotmusic.lib.command.song.AutocompleteSongCommand;
	import cz.hotmusic.lib.command.song.CreateSongCommand;
	import cz.hotmusic.lib.command.song.ListSongCommand;
	import cz.hotmusic.lib.command.song.RemoveSongCommand;
	import cz.hotmusic.lib.command.song.UpdateSongCommand;
	import cz.hotmusic.lib.event.AlbumServiceEvent;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.event.SongServiceEvent;
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.lib.model.User;
	
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
			addCommand(ProfileServiceEvent.UPDATE, UpdateUserCommand);
//			addCommand(ProfileServiceEvent.UPDATE, GetScoreCommand);
//			addCommand(ProfileServiceEvent.LIST_COUNT, UpdateProfileCommand);
//			addCommand(ProfileServiceEvent.DELETE, ValidatePromoCodeCommand);
//			addCommand(ProfileServiceEvent.AUTOCOMPLETE, ValidatePromoCodeCommand);
			
			addCommand(SongServiceEvent.AUTOCOMPLETE, AutocompleteSongCommand);
			addCommand(SongServiceEvent.CREATE, CreateSongCommand);
			addCommand(SongServiceEvent.LIST, ListSongCommand);
			addCommand(SongServiceEvent.REMOVE, RemoveSongCommand);
			addCommand(SongServiceEvent.UPDATE, UpdateSongCommand);
			
			addCommand(ArtistServiceEvent.AUTOCOMPLETE, AutocompleteArtistCommand);
			addCommand(ArtistServiceEvent.CREATE, CreateArtistCommand);
			addCommand(ArtistServiceEvent.LIST, ListArtistCommand);
			addCommand(ArtistServiceEvent.REMOVE, RemoveArtistCommand);
			addCommand(ArtistServiceEvent.UPDATE, UpdateArtistCommand);
			
			addCommand(AlbumServiceEvent.AUTOCOMPLETE, AutocompleteAlbumCommand);
			addCommand(AlbumServiceEvent.CREATE, CreateAlbumCommand);
			addCommand(AlbumServiceEvent.LIST, ListAlbumCommand);
			addCommand(AlbumServiceEvent.REMOVE, RemoveAlbumCommand);
			addCommand(AlbumServiceEvent.UPDATE, UpdateAlbumCommand);
			
			addCommand(GenreServiceEvent.AUTOCOMPLETE, AutocompleteGenreCommand);
			addCommand(GenreServiceEvent.CREATE, CreateGenreCommand);
			addCommand(GenreServiceEvent.LIST, ListGenreCommand);
			addCommand(GenreServiceEvent.REMOVE, RemoveGenreCommand);
			addCommand(GenreServiceEvent.UPDATE, UpdateGenreCommand);
			
		}
	}
}