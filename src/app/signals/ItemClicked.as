package app.signals
{
	import app.model.BoxItem;

	import org.osflash.signals.Signal;

	public class ItemClicked extends Signal
	{
		public function ItemClicked()
		{
			super(BoxItem);
		}



	}
}
