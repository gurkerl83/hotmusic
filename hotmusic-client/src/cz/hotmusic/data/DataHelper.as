package cz.hotmusic.data
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.helper.SortHelper;
	import cz.hotmusic.model.Album;
	import cz.hotmusic.model.Artist;
	import cz.hotmusic.model.Genre;
	import cz.hotmusic.model.Song;
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
		public var sorts:Array;
		
		private function init():void {
			createSongs();
			createGenres();
			createSorts();
		}
		
		private function createSongs():void
		{
			var now:Date = new Date();
			
			// artists
			var coldplay:Artist = new Artist("Coldplay");
			var redhot:Artist = new Artist("Red Hot Chilli Peppers");
			var snoop:Artist = new Artist("Snoop");
			var houseofpain:Artist = new Artist("House of Pain");
			var gonzales:Artist = new Artist("Jose Gonzales");
			var portishead:Artist = new Artist("Portishead");
			var mgmt:Artist = new Artist("MGMT");
			var massiveattack:Artist = new Artist("Massive Attack");
			
			// genres
			var rnb:Genre = new Genre("RnB and Soul");
			var hiphop:Genre = new Genre("hip hop, rap");
			var rock:Genre = new Genre("rock / pop / classical");
			
			// albums
			var iamwithyou:Album = new Album("I'm with you");
			
			var songsObj:Array = [
				{ name: "What if", artist: coldplay, genre: rnb, addedDate: now, hotstatus: 3, rateUp:14, rateDown:2, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "The Adventures Of Rain Dance Maggie", artist: redhot,  genre: rock, album: iamwithyou, addedDate: new Date(now.fullYear, now.month,now.date-1), hotstatus: 2, rateUp:84, rateDown:4, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Riders on the storm", artist: snoop, genre: hiphop, addedDate: new Date(now.fullYear, now.month,now.date-1), hotstatus: 1, rateUp:3, rateDown:1, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Jump Around", artist: houseofpain, genre: hiphop, addedDate: new Date(now.fullYear, now.month,now.date-2), hotstatus: 0, rateUp:121, rateDown:4, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Heartbeats", artist: gonzales,  genre: rnb,addedDate: new Date(now.fullYear, now.month,now.date-3), hotstatus: 0, rateUp:13, rateDown:21, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Roads", artist: portishead, genre: rnb, addedDate: new Date(now.fullYear, now.month,now.date-4), hotstatus: 0, rateUp:6, rateDown:6, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},

				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Everything At Once", artist: mgmt, genre: rnb, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ name: "Tear Drop", artist: massiveattack, genre: rock, addedDate: new Date(2013, 5,7), hotstatus: 0, rateUp:33, rateDown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
			];
			
			songs = [];
			for each (var songObj:Object in songsObj)
			{
				var song:Song = new Song();
				song.name = songObj.name;
				song.artist = songObj.artist;
				song.genre = songObj.genre;
				song.addedDate = songObj.addedDate;
				song.hotstatus = songObj.hotstatus;
				song.rateUp = songObj.rateUp;
				song.rateDown = songObj.rateDown;
				song.itunes = songObj.itunes;
				song.amazon = songObj.amazon;
				song.soundcloud = songObj.soundcloud;
				song.youtube = songObj.youtube;
				
				songs.push(song);
			}
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
		
		private function createSorts():void 
		{
			sorts =	[
				{ 
					header: "Interprets sorting",
					children: [
						{ sortby: "A-Z", sortbykey: SortHelper.INTERPRET_AZ},
						{ sortby: "Z-A", sortbykey: SortHelper.INTERPRET_ZA},
						{ sortby: "newest first", sortbykey: SortHelper.INTERPRET_NEWEST},
						{ sortby: "oldest first", sortbykey: SortHelper.INTERPRET_OLDEST}
					]
				},{
					header: "Genres Sorting",
					children: [
						{ sortby: "A-Z", sortbykey: SortHelper.GENRES_AZ},
						{ sortby: "Z-A", sortbykey: SortHelper.GENRES_ZA}
					]	
				},{
					header: "Sort by status",
					children: [
						{ sortby: "View All", sortbykey: SortHelper.STATUS_ALL, rightNormalImg: new Image(Texture.fromBitmap(new FontAssets.HotAll())), rightSelectedImg: new Image(Texture.fromBitmap(new FontAssets.HotAllSelected()))},
						{ sortby: "Hottest", sortbykey: SortHelper.STATUS_HOTTEST, rightNormalImg: new Image(Texture.fromBitmap(new FontAssets.Hottest())), rightSelectedImg: new Image(Texture.fromBitmap(new FontAssets.HottestSelected()))},
						{ sortby: "Hot", sortbykey: SortHelper.STATUS_HOT, rightNormalImg: new Image(Texture.fromBitmap(new FontAssets.Hot())), rightSelectedImg: new Image(Texture.fromBitmap(new FontAssets.HotSelected()))},
						{ sortby: "Warm", sortbykey: SortHelper.STATUS_WARM, rightNormalImg: new Image(Texture.fromBitmap(new FontAssets.Warm())), rightSelectedImg: new Image(Texture.fromBitmap(new FontAssets.WarmSelected()))}
					]
				},{
					header: "Sort by rating",
					children: [
						{leftNormalImg: new Image(Texture.fromBitmap(new FontAssets.RateUpSmall())), leftSelectedImg: new Image(Texture.fromBitmap(new FontAssets.RateUpSmallSelected())), sortby: "Best first", sortbykey: SortHelper.RATING_BEST},
						{leftNormalImg: new Image(Texture.fromBitmap(new FontAssets.RateDownSmall())), leftSelectedImg: new Image(Texture.fromBitmap(new FontAssets.RateDownSmallSelected())), sortby: "Worst first", sortbykey: SortHelper.RATING_WORST}
					]
				}
			];
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