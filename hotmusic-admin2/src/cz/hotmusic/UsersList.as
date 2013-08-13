package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.event.ProfileServiceEvent;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.DataHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.model.User;
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
				var se:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.REMOVE, removeResult, removeFault);
				se.sid = Model.getInstance().user.session;
				se.user = User(UserRenderer(event.target).data);
				CairngormEventDispatcher.getInstance().dispatchEvent(se);
			});
			
			addChild(list);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getUsers(function onData():void {
				list.selectedIndex = -1;
				list.dataProvider = new ListCollection(Model.getInstance().users);
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
		}
	}
}