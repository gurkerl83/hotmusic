package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Alert;
	import cz.hotmusic.component.PageJumper;
	import cz.hotmusic.component.SearchSort;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.AddArtistServiceEvent;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.helper.ErrorHelper;
	import cz.hotmusic.lib.model.AddArtist;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.AddArtistRenderer;
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
	
	public class AddArtistsList extends Screen implements IActionButtons, ISearchSort
	{
		public function AddArtistsList()
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
			list.dataProvider = new ListCollection(Model.getInstance().addArtists);
			pageJumper.totalItems = Model.getInstance().addArtistsTotal;
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
				_actionButtons = [];
			}
			return _actionButtons;
		}
		
		// INITIALIZE
		private var list:List;
		private var totalLbl:Label;
		private var totalVal:Label;
		private var addedLbl:Label;
		private var addedVal:Label;
		private var rejectedLbl:Label;
		private var rejectedVal:Label;
		private var waitingLbl:Label;
		private var waitingVal:Label;
		private var pageJumper:PageJumper;
		private var searchSort:SearchSort;
		
		private var skipOpenDetail:Boolean;
		
		override protected function initialize():void
		{
			super.initialize();
			
			totalLbl = new Label();
			totalLbl.text = "Total sent artists:";
			totalLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			totalVal = new Label();
			totalVal.text = Model.getInstance().addArtistsTotal.toString();
			totalVal.name = Theme.LARGE_BOLD_WHITE;
			
			addedLbl = new Label();
			addedLbl.text = "Added:";
			addedLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			addedVal = new Label();
			addedVal.text = Model.getInstance().addArtistsAdded.toString();
			addedVal.name = Theme.LARGE_BOLD_GREEN;

			rejectedLbl = new Label();
			rejectedLbl.text = "Rejected:";
			rejectedLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			rejectedVal = new Label();
			rejectedVal.text = Model.getInstance().addArtistsRejected.toString();
			rejectedVal.name = Theme.LARGE_BOLD_RED;
			
			waitingLbl = new Label();
			waitingLbl.text = "Waiting:";
			waitingLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			waitingVal = new Label();
			waitingVal.text = Model.getInstance().addArtistsWaiting.toString();
			waitingVal.name = Theme.LARGE_BOLD_GRAY;
			
			list = new List();
			list.itemRendererType = AddArtistRenderer;
			list.dataProvider = new ListCollection(Model.getInstance().addArtists);
			list.itemRendererProperties.labelField = "name";
			list.hasElasticEdges = false;
			list.addEventListener("reject", function onDelete(event:Event):void {
				var se:AddArtistServiceEvent = new AddArtistServiceEvent(AddArtistServiceEvent.CHANGE_STATE, removeResult, Alert.showError);
				se.sid = Model.getInstance().user.sid;
				se.addArtist = AddArtist(AddArtistRenderer(event.target).data);
				se.addArtist.state = AddArtist.REJECTED_STATE;
				CairngormEventDispatcher.getInstance().dispatchEvent(se);
			});
			
			list.addEventListener("accept", function onDelete(event:Event):void {
				var se:AddArtistServiceEvent = new AddArtistServiceEvent(AddArtistServiceEvent.CHANGE_STATE, removeResult, Alert.showError);
				se.sid = Model.getInstance().user.sid;
				se.addArtist = AddArtist(AddArtistRenderer(event.target).data);
				se.addArtist.state = AddArtist.ADDED_STATE;
				CairngormEventDispatcher.getInstance().dispatchEvent(se);
			});
			
			pageJumper = new PageJumper(new AddArtistServiceEvent(AddArtistServiceEvent.LIST,null, null),list, this);
			pageJumper.totalItems = Model.getInstance().artistsTotal;
			
			searchSort = new SearchSort(new AddArtistServiceEvent(AddArtistServiceEvent.LIST, null, null),list, this);
			
			addChild(totalLbl);
			addChild(totalVal);
			addChild(addedLbl);
			addChild(addedVal);
			addChild(rejectedLbl);
			addChild(rejectedVal);
			addChild(waitingLbl);
			addChild(waitingVal);
			addChild(list);
			addChild(pageJumper);
			addChild(searchSort);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getAddArtists(function onAddArtists():void {
				list.selectedIndex = -1;
				list.dataProvider = new ListCollection(Model.getInstance().addArtists);
				refreshLastNumbers();
				pageJumper.actualPage = 0;
				invalidate();
			},  Alert.showError);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var gap:int = 20;
			var baseline:int = 4;
			
			totalLbl.validate();
			
			totalVal.x = totalLbl.width;
			totalVal.validate();
			totalVal.y = baseline - totalVal.height + totalLbl.height;
			
			addedLbl.x = totalVal.x + totalVal.width + gap;
			addedLbl.validate();
			
			addedVal.x = addedLbl.x + addedLbl.width;
			addedVal.validate();
			addedVal.y = baseline - addedVal.height + addedLbl.height;

			rejectedLbl.x = addedVal.x + addedVal.width + gap;
			rejectedLbl.validate();
			
			rejectedVal.x = rejectedLbl.x + rejectedLbl.width;
			rejectedVal.validate();
			rejectedVal.y = baseline - rejectedVal.height + rejectedLbl.height;

			waitingLbl.x = rejectedVal.x + rejectedVal.width + gap;
			waitingLbl.validate();
			
			waitingVal.x = waitingLbl.x + waitingLbl.width;
			waitingVal.validate();
			waitingVal.y = baseline - waitingVal.height + waitingLbl.height;
			
			searchSort.y = waitingLbl.y + waitingLbl.height + gap;
			searchSort.validate();
			
			list.y = searchSort.y + searchSort.height + gap;
			list.width = actualWidth;
			
			pageJumper.validate();
			pageJumper.y = actualHeight - pageJumper.height;
		}
		
		private function refreshLastNumbers():void {
			totalVal.text = Model.getInstance().addArtistsTotal.toString();
			addedVal.text = Model.getInstance().addArtistsAdded.toString();
			rejectedVal.text = Model.getInstance().addArtistsRejected.toString();
			waitingVal.text = Model.getInstance().addArtistsWaiting.toString();
		}
		
	}
}