package cz.hotmusic.helper
{
	import cz.hotmusic.component.ActionButton;
	
	import feathers.controls.Button;
	import feathers.themes.Theme;

	public class ButtonHelper
	{
		public function ButtonHelper()
		{
		}
		
		private static var _instance:ButtonHelper;
		public static function inst():ButtonHelper
		{
			if (_instance == null)
				_instance = new ButtonHelper();
			return _instance;
		}
		
		public function reset():void
		{
			_instance = null;
		}
		
		private var _saveButton:ActionButton;
		private var _cancelButton:ActionButton;
		private var _clearButton:ActionButton;
		private var _addNewButton:ActionButton;
		
		public function get saveButton():ActionButton
		{
			if (_saveButton == null)
			{
				_saveButton = new ActionButton(ActionButton.SAVE_BUTTON);
				_saveButton.label = "Save";
			}
			return _saveButton;
		}

		public function get cancelButton():ActionButton
		{
			if (_cancelButton == null)
			{
				_cancelButton = new ActionButton(ActionButton.CANCEL_BUTTON);
				_cancelButton.label = "Cancel";
				_cancelButton.name = Theme.SMALL_BOLD_RED
			}
			return _cancelButton;
		}

		public function get clearButton():ActionButton
		{
			if (_clearButton == null)
			{
				_clearButton = new ActionButton(ActionButton.CLEAR_BUTTON);
				_clearButton.label = "Clear";
				_clearButton.name = Theme.SMALL_BOLD_BLUE
			}
			return _clearButton;
		}

		public function addNewButton(label:String):ActionButton
		{
			if (_addNewButton == null)
			{
				_addNewButton = new ActionButton(ActionButton.ADD_NEW_BUTTON);
			}
			_addNewButton.label = "Add new " + label;
			return _addNewButton;
		}
	}
}