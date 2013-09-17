package cz.hotmusic.components
{
	import feathers.core.PopUpManager;

	public function showBusy(msg:String=null):void
	{
		if (PopUpManager.isPopUp(BusyIndicator.getInstance()))
			return;

		if (msg != null)
			BusyIndicator.getInstance().loading.text = msg;
		PopUpManager.addPopUp(BusyIndicator.getInstance(), true);
	}
}