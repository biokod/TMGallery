package app.signals
{
	import app.model.BoxItem;
	import org.osflash.signals.Signal;

	public class ItemAdded extends Signal
	{
		public function ItemAdded()
		{
			super(BoxItem);
		}



	}
}
