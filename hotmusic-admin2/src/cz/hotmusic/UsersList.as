package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.PageJumper;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.model.User;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.UserRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import mx.rpc.events.ResultEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class UsersList extends Screen implements IActionButtons
	{
		public function UsersList()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			// reload data
			list.dataProvider = new ListCollection(Model.getInstance().users);
			pageJumper.totalItems = Model.getInstance().usersTotal;
			pageJumper.actualPage = 0;
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
			
			pageJumper = new PageJumper();
			pageJumper.totalItems = Model.getInstance().songsTotal;
			pageJumper.addEventListener(PageJumper.PAGE_JUMP, function onPageJump(event:Event):void {
				DataHelper.getInstance().getUsers(function onUsers():void {
					list.dataProvider = new ListCollection(Model.getInstance().users);
				}
					, false, event.data);
			});
			
			addChild(list);
			addChild(pageJumper);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getUsers(function onData():void {
				list.selectedIndex = -1;
				list.dataProvider = new ListCollection(Model.getInstance().users);
				pageJumper.actualPage = 0;
				invalidate();
			});
		}
		
		private function removeFault(info:Object):void
		{
			
		}
		
		override protected function draw():void
		{
			super.draw();
			
			list.width = actualWidth;
			
			pageJumper.validate();
			pageJumper.y = actualHeight - pageJumper.height;
		}
	}
}