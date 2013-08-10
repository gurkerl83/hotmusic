package cz.hotmusic.helper
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.model.Album;
	import cz.hotmusic.model.Artist;
	import cz.hotmusic.model.Genre;
	import cz.hotmusic.model.Song;
	import cz.hotmusic.model.User;
	import cz.zc.mylib.event.GenericEvent;
	import cz.zc.mylib.helper.DateHelper;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
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
		public var artists:Array;
		public var albums:Array;
		public var users:Array;
		
		private function init():void {
			createGenres();
			createArtists();
			createAlbums();
			createSongs();
			createUsers();
		}
		
		private function createSongs():void
		{
			var now:Date = new Date();
			
			var songsObj:Array = [
				{ name: "What if", artist: coldplay, album: xy, genre: rock, addedDate: new Date(2013, 5, 26), hotstatus: 3, rateUp:14, rateDown:2, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "The Adventures Of Rain Dance Maggie", artist: redhot, album: iamwithyou, genre: rock, addedDate: new Date(now.fullYear, now.month,now.date-1), hotstatus: 2, rateUp:84, rateDown:4, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, album: coolalbum, genre: pop, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Jump Around", artist: houseofpain, album:highsky, genre: hiphop, addedDate: new Date(now.fullYear, now.month,now.date-2), hotstatus: 0, rateUp:121, rateDown:4, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Heartbeats", artist: gonzales, album: slash, genre: house, addedDate: new Date(now.fullYear, now.month,now.date-3), hotstatus: 0, rateUp:13, rateDown:21, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Roads", artist: portishead, album: fallout, genre: blues, addedDate: new Date(now.fullYear, now.month,now.date-4), hotstatus: 0, rateUp:6, rateDown:6, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, album: getone, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
			];
			
			songs = [];
			for each (var songObj:Object in songsObj)
			{
				var song:Song = new Song();
				song.name = songObj.name;
				song.artist = songObj.artist;
				song.album = songObj.album;
				song.genre = songObj.genre;
				song.addedDate = songObj.addedDate;
				song.hotstatus = songObj.hotstatus;
				song.rateUp = songObj.rateUp;
				song.rateDown = songObj.rateDown;
				song.itunesURL = songObj.itunes;
				song.amazonURL = songObj.amazon;
				song.soundcloudURL = songObj.soundcloud;
				song.youtubeURL = songObj.youtube;
				
				songs.push(song);
			}
		}
		
		private var blues:Genre;
		private var classis:Genre;
		private var country:Genre;
		private var dance:Genre;
		private var electro:Genre;
		private var folk:Genre;
		private var house:Genre;
		private var hiphop:Genre;
		private var rock:Genre;
		private var pop:Genre;
		
		private function createGenres():void
		{
			genres = [
				blues = new Genre("Blues"),
				classis = new Genre("Classis"),
				country = new Genre("Country"),
				dance = new Genre("Dance"),
				electro = new Genre("Electro"),
				folk = new Genre("Folk"),
				house = new Genre("House"),
				hiphop = new Genre("HipHop"),
				rock = new Genre("Rock"),
				pop = new Genre("Pop")
			];
		}

		
		private var coldplay:Artist;
		private var redhot:Artist;
		private var mgmt:Artist;
		private var houseofpain:Artist;
		private var gonzales:Artist;
		private var portishead:Artist;
		private var massiveattack:Artist;
		
		private function createArtists():void
		{
			artists = [
				coldplay = new Artist("Coldplay", new Date(2013, 5, 26)),
				redhot = new Artist("Red Hot Chili Peppers", new Date(2013, 5, 25)),
				mgmt = new Artist("MGMT", new Date(2013, 5, 24)),
				houseofpain = new Artist("House of Pain", new Date(2013, 5, 5)),
				gonzales = new Artist("Jose Gonzales", new Date(2012, 10, 29)),
				portishead = new Artist("Portishead", new Date(2013, 9, 27)),
				massiveattack = new Artist("Massive Attack", new Date(2013, 9, 25)),
			];
		}

		private var xy:Album;
		private var iamwithyou:Album;
		private var coolalbum:Album;
		private var highsky:Album;
		private var slash:Album;
		private var fallout:Album;
		private var getone:Album;
		
		private function createAlbums():void
		{
			albums = [
				xy = new Album("X & Y", coldplay, new Date(2013, 5, 26)),
				iamwithyou = new Album("I'm with you", redhot, new Date(2013, 5, 25)),
				coolalbum = new Album("Cool Album", mgmt, new Date(2013, 5, 24)),
				highsky = new Album("High Sky", houseofpain, new Date(2013, 5, 5)),
				slash = new Album("Slash", gonzales, new Date(2012, 10, 29)),
				fallout = new Album("Fall Out", portishead,  new Date(2013, 9, 27)),
				getone = new Album("Get one", massiveattack, new Date(2013, 9, 25)),
			];
		}

		private function createUsers():void
		{
			users = [
				new User("Jan", "Novák"),
				new User("Tomáš", "Nejedlý"),
				new User("Eva", "Procházková"),
				new User("Jana", "Skokanová"),
				new User("Hana", "Hrubá"),
				new User("Radomír", "Velký"),
				new User("Theodor", "Falk"),
			];
		}
		
	}
}