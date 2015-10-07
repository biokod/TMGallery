package app.signals
{
	import app.model.BoxItem;

	import org.osflash.signals.Signal;

	public class ImageLoaded extends Signal
	{
		public function ImageLoaded()
		{
			super(BoxItem);
		}



	}
}
