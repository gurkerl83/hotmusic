package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Alert;
	import cz.hotmusic.component.PageJumper;
	import cz.hotmusic.component.SearchSort;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.helper.ErrorHelper;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.ArtistRenderer;
	
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
	
	public class ArtistsList extends Screen implements IActionButtons, ISearchSort
	{
		public function ArtistsList()
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
			list.dataProvider = new ListCollection(Model.getInstance().artists);
			pageJumper.totalItems = Model.getInstance().artistsTotal;
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
				_actionButtons = [ButtonHelper.inst().addNewButton("artist")];
			}
			return _actionButtons;
		}
		
		// INITIALIZE
		private var list:List;
		private var lastMonthLbl:Label;
		private var lastMonthVal:Label;
		private var totalLbl:Label;
		private var totalVal:Label;
		private var pageJumper:PageJumper;
		private var searchSort:SearchSort;
		
		private var skipOpenDetail:Boolean;
		
		override protected function initialize():void
		{
			super.initialize();
			
			lastMonthLbl = new Label();
			lastMonthLbl.text = "Last month added artists:";
			lastMonthLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			lastMonthVal = new Label();
			lastMonthVal.text = Model.getInstance().albumsLastMonth.toString();
			lastMonthVal.name = Theme.LARGE_BOLD_WHITE;
			
			totalLbl = new Label();
			totalLbl.text = "Total added artists:";
			totalLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			totalVal = new Label();
			totalVal.text = Model.getInstance().albumsTotal.toString();
			totalVal.name = Theme.LARGE_BOLD_WHITE;
			
			list = new List();
			list.itemRendererType = ArtistRenderer;
			list.dataProvider = new ListCollection(Model.getInstance().artists);
			list.itemRendererProperties.labelField = "name";
			list.hasElasticEdges = false;
			list.addEventListener("delete", function onDelete(event:Event):void {
				skipOpenDetail = true;
				var se:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.REMOVE, removeResult, removeFault);
				se.sid = Model.getInstance().user.sid;
				se.artist = Artist(ArtistRenderer(event.target).data);
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
			
			pageJumper = new PageJumper(new ArtistServiceEvent(ArtistServiceEvent.LIST,null, null),list, this);
			pageJumper.totalItems = Model.getInstance().artistsTotal;
			
			searchSort = new SearchSort(new ArtistServiceEvent(ArtistServiceEvent.LIST, null, null),list, this);
			
			addChild(lastMonthLbl);
			addChild(lastMonthVal);
			addChild(totalLbl);
			addChild(totalVal);
			addChild(list);
			addChild(pageJumper);
			addChild(searchSort);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getArtists(function onArtists():void {
				list.selectedIndex = -1;
				list.dataProvider = new ListCollection(Model.getInstance().artists);
				refreshLastNumbers();
				pageJumper.actualPage = 0;
				invalidate();
			},  function onArtistsFault(info:FaultEvent):void {
				Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
			});
		}
		
		private function removeFault(info:Object):void
		{
			Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var gap:int = 20;
			var baseline:int = 4;
			
			lastMonthLbl.validate();
			
			lastMonthVal.x = lastMonthLbl.width;
			lastMonthVal.validate();
			lastMonthVal.y = baseline - lastMonthVal.height + lastMonthLbl.height;
			
			totalLbl.x = lastMonthVal.x + lastMonthVal.width + gap;
			totalLbl.validate();
			
			totalVal.x = totalLbl.x + totalLbl.width;
			totalVal.validate();
			totalVal.y = baseline - totalVal.height + totalLbl.height;
			
			searchSort.y = totalLbl.y + totalLbl.height + gap;
			searchSort.validate();
			
			list.y = searchSort.y + searchSort.height + gap;
			list.width = actualWidth;
			
			pageJumper.validate();
			pageJumper.y = actualHeight - pageJumper.height;
		}
		
		private function refreshLastNumbers():void {
			lastMonthVal.text = Model.getInstance().artistsLastMonth.toString();
			totalVal.text = Model.getInstance().artistsTotal.toString();
		}
		
	}
}