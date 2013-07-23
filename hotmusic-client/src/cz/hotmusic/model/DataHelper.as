package cz.hotmusic.model
{
	public class DataHelper
	{
		public function DataHelper()
		{
		}
		
		private static var _instance:DataHelper;
		public static function getInstance():DataHelper 
		{
			if (_instance == null) {
				_instance = new DataHelper();
				_instance.init();
			}
			return _instance;
		}
		
		public var songs:Array;
		public var genres:Array;
		
		private function init():void {
			createSongs();
			createGenres();
		}
		
		private function createSongs():void
		{
			songs = [
				{ song: "What if", artist: "Coldplay", genre: "RnB and Soul", added: "TODAY", hotstatus: "3"},
				{ song: "The Adventures Of Rain Dance Maggie", genre: "RnB and Soul", artist: "Red Hot Chilli Peppers", album:"I'm with you", genre:"rock / pop / classical", added: "YESTERDAY", hotstatus: "2"},
				{ song: "Everything At Once", artist: "MGMT", genre: "RnB and Soul", added: "YESTERDAY", hotstatus: "1"},
				{ song: "Jump Around", artist: "House of Pain", genre: "hip hop, rap", added: "2 DAYS AGO", hotstatus: "0"},
				{ song: "Heartbeats", artist: "Jose Gonzales",  genre: "RnB and Soul",added: "23.5.2013", hotstatus: "0"},
				{ song: "Roads", artist: "Portishead", genre: "RnB and Soul", added: "21.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT", genre: "RnB and Soul", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: "7.5.2013", hotstatus: "0"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: "7.5.2013", hotstatus: "0"},
			];
		}
		
		private function createGenres():void
		{
			genres = [
				{ genre: "All genres"},
				{ genre: "RnB and Soul"},
				{ genre: "hip hop, rap"},
				{ genre: "rock"},
				{ genre: "reggae"},
				{ genre: "indian (Indie, bollywood)"},
				{ genre: "house/trance"},
				{ genre: "DnB"},
				{ genre: "Dance (hardcore, garage...)"},
				{ genre: "Techno"},
				{ genre: "dubstep"},
			];
			
			for each (var genre:Object in genres)
			{
				if (genre.genre == "All genres")
					genre.count = songs.length;
				else {
					genre.count = songsCountByGenre(genre.genre);
				}
			}
		}
		
		private function songsCountByGenre(genre:String):int
		{
			var count:int;
			for each (var song:Object in songs)
			{
				if (song.genre == genre)
					count++;
			}
			return count;
		}
		
		
	}
}