package cz.hotmusic.model
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.helper.SortHelper;
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
			songs = [
				{ song: "What if", artist: "Coldplay", genre: "RnB and Soul", added: now, hotstatus: 3, rateup:14, ratedown:2, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "The Adventures Of Rain Dance Maggie", genre: "RnB and Soul", artist: "Red Hot Chilli Peppers", album:"I'm with you", genre:"rock / pop / classical", added: new Date(now.fullYear, now.month,now.date-1), hotstatus: 2, rateup:84, ratedown:4, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Riders on the storm", artist: "Snoop", genre: "hip hop, rap", added: new Date(now.fullYear, now.month,now.date-1), hotstatus: 1, rateup:3, ratedown:1, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Jump Around", artist: "House of Pain", genre: "hip hop, rap", added: new Date(now.fullYear, now.month,now.date-2), hotstatus: 0, rateup:121, ratedown:4, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Heartbeats", artist: "Jose Gonzales",  genre: "RnB and Soul",added: new Date(now.fullYear, now.month,now.date-3), hotstatus: 0, rateup:13, ratedown:21, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Roads", artist: "Portishead", genre: "RnB and Soul", added: new Date(now.fullYear, now.month,now.date-4), hotstatus: 0, rateup:6, ratedown:6, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT", genre: "RnB and Soul", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:33, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Tear Drop", artist: "Massive Attack", genre: "rock", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
				{ song: "Everything At Once", artist: "MGMT",genre: "dubstep", added: new Date(2013, 5,7), hotstatus: 0, rateup:33, ratedown:3, itunes: "https://itunes.apple.com/us/album/californication/id130244757#", amazon: "http://www.amazon.com/gp/product/B00973902K/ref=dm_mu_dp_trk3", beatport: "http://www.beatport.com/track/like-home-original-mix/3907632", youtube: "https://www.youtube.com/watch?v=fWNaR-rxAic"},
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