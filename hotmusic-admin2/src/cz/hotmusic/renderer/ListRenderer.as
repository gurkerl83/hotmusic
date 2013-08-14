package cz.hotmusic.renderer
{
	import cz.hotmusic.component.DateField;
	import cz.hotmusic.lib.model.Genre;
	
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Image;

	public class ListRenderer extends DefaultListItemRenderer
	{
		public function ListRenderer()
		{
			super();
		}
		
		private static const GENRE_TYPE		:String = "GENRE_TYPE";
		private static const ARTIST_TYPE	:String = "GENRE_TYPE";
		private static const SONG_TYPE		:String = "GENRE_TYPE";
		private static const ALBUM_TYPE		:String = "GENRE_TYPE";
		
		public var isNumberOrderVisible:Boolean;
		public var isArtistVisible:Boolean;
		public var isAlbumVisible:Boolean;
		public var isCheckVisible:Boolean;
		public var isDateVisible:Boolean;
		public var isCloseVisible:Boolean;
		
		private var _rendererType:String;
		
		private var _numberOrderLabel:Label;
		private var _nameLabel:Label;
		private var _artistLabel:Label;
		private var _artistValue:Label;
		private var _albumLabel:Label;
		private var _albumValue:Label;
		private var _checkImage:Image;
		private var _dateField:DateField;
		private var _closeImage:Image;
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			if (value is Genre) {
				var g:Genre = Genre(value);
				_nameLabel.text = g.name;
			}
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			if (
		}
		
		override protected function layoutContent():void
		{
			super.layoutContent();
		}
		
	}
}