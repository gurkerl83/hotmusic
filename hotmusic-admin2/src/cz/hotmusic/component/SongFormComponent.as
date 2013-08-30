package cz.hotmusic.component
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.model.Model;
	
	import feathers.core.FeathersControl;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;

	[Event(name="songDelete", type="starling.events.Event")]
	public class SongFormComponent extends FormItem
	{
		public function SongFormComponent()
		{
			super();
		}
		public static const SONG_DELETE_EVENT:String = "songDelete";
		private var _song:Song;
		
		protected var plus:Button;
		protected var remove:Button;
		private var genre:SongFormItem;
		private var soundcloud:SongFormItem;
		private var youtube:SongFormItem;
		
		private var gap:int = 4;
		
		public function get song():Song
		{
			if (_song == null)
				_song = new Song();
			
			_song.name = value;
			_song.genre = Genre(genre.selectedItem);
			_song.soundcloud = soundcloud.value;
			_song.youtube = youtube.value;
			
			return _song;
		}

		public function set song(value:Song):void
		{
			_song = value;
			if (_song == null)
				return;
			this.value = _song.name;
			genre.selectedItem = _song.genre;
			soundcloud.value = _song.soundcloud;
			youtube.value = _song.youtube;
		}

		override protected function initialize():void
		{
			super.initialize();
			
			plus = new Button(Texture.fromBitmap(new FontAssets.Plus()));
			plus.addEventListener(Event.TRIGGERED, function onPlus(event:Event):void {
				genre.visible = soundcloud.visible = youtube.visible = !youtube.visible;
				invalidate();
			});
			remove = new Button(Texture.fromBitmap(new FontAssets.Delete()));
			remove.addEventListener(Event.TRIGGERED, function onClick(event:Event):void {
				event.stopImmediatePropagation();
				dispatchEventWith(SONG_DELETE_EVENT,true, song);
			});
			
			label = "Song name";
			
			var gse:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.AUTOCOMPLETE, null, null);
			gse.sid = Model.getInstance().user.sid;
			genre = new SongFormItem();
			genre.orderNumber = "1.";
			genre.label = "Genre";
			genre.isAutocomplete = true;
			genre.serviceEvent = gse;
			
			soundcloud = new SongFormItem();
			soundcloud.orderNumber = "2.";
			soundcloud.label = "Soundcloud listen link";
			
			youtube = new SongFormItem();
			youtube.orderNumber = "3.";
			youtube.label = "YouTube watch link";
			
			addChild(plus);
			addChild(remove);
			
			addChild(genre);
			addChild(soundcloud);
			addChild(youtube);
		
		}
		
//		override protected function setSizeInternal(width:Number, height:Number, canInvalidate:Boolean):Boolean
//		{
//			if (youtube == null)
//				return super.setSizeInternal(width, height, canInvalidate);
////			setSize(actualWidth, youtube.visible ? (4*COLAPSED_HEIGHT + 3*gap): COLAPSED_HEIGHT);
//			return super.setSizeInternal(actualWidth, youtube.visible ? (4*COLAPSED_HEIGHT + 3*gap): COLAPSED_HEIGHT, canInvalidate);
//		}
		
		override protected function draw():void
		{
			super.draw();
			
//			if (isInvalid(INVALIDATION_FLAG_SIZE))
			setSize(actualWidth, youtube.visible ? (4*COLAPSED_HEIGHT + 3*gap): COLAPSED_HEIGHT);
			
			orderNumberLbl.y = COLAPSED_HEIGHT/2 - orderNumberLbl.height/2;
			labelLbl.y = COLAPSED_HEIGHT/2 - labelLbl.height/2;
			
			plus.x = 200;
			plus.y = bg.height/2 - plus.height/2;
			
			if (isAutocomplete) {
				autocomplete.y = COLAPSED_HEIGHT/2 - autocomplete.height/2;
				autocomplete.width = actualWidth - autocomplete.x - autocomplete.y - 50;
			} else {
				textinput.y = COLAPSED_HEIGHT/2 - textinput.height/2;
				textinput.width = actualWidth - textinput.x - textinput.y - 50;
			}
			
			remove.x = actualWidth - remove.width/2 - 50/2;
			remove.y = bg.height/2 - remove.height/2;
			
			genre.y = bg.height + gap;
			genre.width = actualWidth;
			
			soundcloud.y = genre.y + genre.height + gap;
			soundcloud.width = actualWidth;
			
			youtube.y = soundcloud.y + soundcloud.height + gap;
			youtube.width = actualWidth;
		}
	}
}