package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Alert;
	import cz.hotmusic.component.PageJumper;
	import cz.hotmusic.component.SearchSort;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.helper.ErrorHelper;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.GenreRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GenresList extends Screen implements IActionButtons, ISearchSort
	{
		public function GenresList()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		// ----------------------------------------
		//
		// GETTERS SETTERS
		//
		// ----------------------------------------
		
		private var _sort:String;
		private var _page:int;
		private var _search:String;
		
		public function get sort():String
		{
			return _sort;
		}
		
		public function set sort(value:String):void
		{
			_sort = value;
		}
		
		public function get page():int
		{
			return _page;
		}
		
		public function set page(value:int):void
		{
			_page = value;
		}
		
		public function get search():String
		{
			return _search;
		}
		
		public function set search(value:String):void
		{
			_search = value;
		}
		
		private function onAddedToStage(event:Event):void {
			// reload data
			list.dataProvider = new ListCollection(Model.getInstance().genres);
			pageJumper.totalItems = Model.getInstance().genresTotal;
			pageJumper.actualPage = 0;
			
			// reset search ti
			searchSort.clear();
		}

		// ACTION BUTTONS
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().addNewButton("genre")];
			}
			return _actionButtons;
		}
		
		// INITIALIZE
		private var list:List;
		private var pageJumper:PageJumper;
		private var skipOpenDetail:Boolean;
		private var searchSort:SearchSort;
		
		override protected function initialize():void
		{
			super.initialize();
			
			list = new List();
			list.itemRendererType = GenreRenderer;
			list.dataProvider = new ListCollection(Model.getInstance().genres);
			list.itemRendererProperties.labelField = "name";
			list.hasElasticEdges = false;
			list.addEventListener("delete", function onDelete(event:Event):void {
				skipOpenDetail = true;
				var se:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.REMOVE, removeResult, removeFault);
				se.sid = Model.getInstance().user.sid;
				se.genre = Genre(GenreRenderer(event.target).data);
				Alert.show("Do you really want to delete the item?", Alert.WARN, function onYes():void {
					CairngormEventDispatcher.getInstance().dispatchEvent(se);
				});
			});
			list.addEventListener(starling.events.Event.CHANGE, function onChange(event:Event):void {
				if (!skipOpenDetail && list.selectedIndex >= 0)
					dispatchEventWith("showDetail", false, List(event.target).selectedItem);
				skipOpenDetail = false;
				if (list.selectedIndex > -1)
					list.selectedIndex = -1;
			});
			
			pageJumper = new PageJumper(new GenreServiceEvent(GenreServiceEvent.LIST,null, null),list, this);
			pageJumper.totalItems = Model.getInstance().genresTotal;
			
			searchSort = new SearchSort(new GenreServiceEvent(GenreServiceEvent.LIST, null, null),list, this);
			
			addChild(list);
			addChild(pageJumper);
			addChild(searchSort);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getGenres(function onGenres():void {
				list.selectedIndex = -1;
				list.dataProvider = new ListCollection(Model.getInstance().genres);
				pageJumper.actualPage = 0;
				invalidate();
			},  function onGenresFault(info:FaultEvent):void {
				Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
			});
		}
		
		private function removeFault(info:FaultEvent):void
		{
			Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
		}
		
		// DRAW
		
		override protected function draw():void
		{
			super.draw();
			
			var gap:int = 20;
			
			searchSort.validate();
			
			list.y = searchSort.y + searchSort.height + gap;
			list.width = actualWidth;
			
			pageJumper.validate();
			pageJumper.y = actualHeight - pageJumper.height;
		}
		
	}
}