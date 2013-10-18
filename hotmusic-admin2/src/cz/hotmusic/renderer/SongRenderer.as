package cz.hotmusic.renderer
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.component.DateField;
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.themes.Theme;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class SongRenderer extends DefaultListItemRenderer
	{
		public function SongRenderer()
		{
			super();
		}
		
		private var _deleteButton:Button;
		private var _dateField:DateField;
		private var _artistLabel:Label;
		private var _artistValue:Label;
		private var _albumLabel:Label;
		private var _albumValue:Label;
		
		private var song:Song;
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			song = Song(value);
			if (_dateField && song)
				_dateField.date = song.releaseDate;
			
			if (_artistValue && song && song.artist)
				_artistValue.text = song.artist.name;

			if (_albumValue && song && song.album)
				_albumValue.text = song.album.name;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_deleteButton = new Button(Texture.fromBitmap(new FontAssets.Delete()));
			_deleteButton.addEventListener(Event.TRIGGERED, function (e:Event):void {
				e.stopImmediatePropagation();
				dispatchEventWith("delete", true);
			});
			
			_artistLabel = new Label();
			_artistLabel.name = Theme.SMALL_NORMAL_ORANGE;
			_artistLabel.text = "artist:";
			
			_artistValue = new Label();
			_artistValue.name = Theme.SMALL_NORMAL_BLACK;

			_albumLabel = new Label();
			_albumLabel.name = Theme.SMALL_NORMAL_ORANGE;
			_albumLabel.text = "album:";
			
			_albumValue = new Label();
			_albumValue.name = Theme.SMALL_NORMAL_BLACK;
			
			_dateField = new DateField();
			
			addChild(_deleteButton);
			addChild(_artistLabel);
			addChild(_artistValue);
			addChild(_albumLabel);
			addChild(_albumValue);
			addChild(_dateField);
		}
		
		override protected function layoutContent():void
		{
			super.layoutContent();
			
			// vyhodil jsem, protoze se Songy natahuji jako prvni a actualWidth byla vyssi, tudiz 
			// ikony se zobrazovaly prilis v pravo a pri prerendrovani a zmeny actualWidth na korektni 
			// hodnotu se uz poloha neopravi. Vyhozeni ma za nasledek nepatrny posun ikony, pokud 
			// drzim klik
//			if (_deleteButton.y == 0) {
				_deleteButton.y = actualHeight/2 - _deleteButton.height/2;
//				trace("deleteButton.y = " + _deleteButton.y);
//			}
//			if (_deleteButton.x == 0) {
				_deleteButton.x = actualWidth - _deleteButton.width - _deleteButton.y ;
//				trace("deleteButton.x = " + _deleteButton.x);
//			}
				
			_artistLabel.validate();
			_artistLabel.y = actualHeight/2 - _artistLabel.height/2;
			_artistLabel.x = 300;
			
			_artistValue.validate();
			_artistValue.y = actualHeight/2 - _artistValue.height/2;
			_artistValue.x = _artistLabel.x + _artistLabel.width;
			
			_albumLabel.validate();
			_albumLabel.y = actualHeight/2 - _albumLabel.height/2;
			_albumLabel.x = 600;
			
			_albumValue.validate();
			_albumValue.y = actualHeight/2 - _albumValue.height/2;
			_albumValue.x = _albumLabel.x + _albumLabel.width;
			
			_dateField.validate();
			_dateField.x = _deleteButton.x - gap - _dateField.width;
			_dateField.y = actualHeight/2 - _dateField.height/2;
		}
		
		override protected function draw():void
		{
			super.draw();
		}
	}
}