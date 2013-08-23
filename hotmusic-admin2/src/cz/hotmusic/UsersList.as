package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Alert;
	import cz.hotmusic.component.PageJumper;
	import cz.hotmusic.component.SearchSort;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.helper.ErrorHelper;
	import cz.hotmusic.lib.model.User;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.UserRenderer;
	
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
	
	public class UsersList extends Screen implements IActionButtons, ISearchSort
	{
		public function UsersList()
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
			list.dataProvider = new ListCollection(Model.getInstance().users);
			pageJumper.totalItems = Model.getInstance().usersTotal;
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
				_actionButtons = [ButtonHelper.inst().addNewButton("user")];
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
			list.itemRendererType = UserRenderer;
			list.dataProvider = new ListCollection(Model.getInstance().users);
			list.itemRendererProperties.labelFunction = function (user:User):String {
				return user.firstname + " " + user.surname;
			}
			list.hasElasticEdges = false;
			list.addEventListener("delete", function onDelete(event:Event):void {
				skipOpenDetail = true;
				var se:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.REMOVE, removeResult, removeFault);
				se.sid = Model.getInstance().user.sid;
				se.user = User(UserRenderer(event.target).data);
				CairngormEventDispatcher.getInstance().dispatchEvent(se);
			});
			list.addEventListener(starling.events.Event.CHANGE, function onChange(event:Event):void {
				if (!skipOpenDetail && list.selectedIndex >= 0)
					dispatchEventWith("showDetail", false, List(event.target).selectedItem);
				skipOpenDetail = false;
				if (list.selectedIndex > -1)
					list.selectedIndex = -1;
			});
			
			pageJumper = new PageJumper(new ProfileServiceEvent(ProfileServiceEvent.LIST,null, null),list, this);
			pageJumper.totalItems = Model.getInstance().songsTotal;
			
			searchSort = new SearchSort(new ProfileServiceEvent(ProfileServiceEvent.LIST, null, null),list, this);
			
			addChild(list);
			addChild(pageJumper);
			addChild(searchSort);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getUsers(function onData():void {
				list.selectedIndex = -1;
				list.dataProvider = new ListCollection(Model.getInstance().users);
				pageJumper.actualPage = 0;
				invalidate();
			},  function onUsersFault(info:FaultEvent):void {
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
			
			searchSort.validate();
			
			list.y = searchSort.y + searchSort.height + gap;
			list.width = actualWidth;
			
			pageJumper.validate();
			pageJumper.y = actualHeight - pageJumper.height;
		}
	}
}