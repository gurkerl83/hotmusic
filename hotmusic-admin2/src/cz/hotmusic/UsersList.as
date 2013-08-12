package cz.hotmusic
{
	import cz.hotmusic.helper.ButtonHelper;
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
			
			addChild(list);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			list.width = actualWidth;
		}
	}
}