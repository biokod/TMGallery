package app.signals
{
	import app.model.BoxItem;
	import org.osflash.signals.Signal;

	public class ImageReady extends Signal
	{
		public function ImageReady()
		{
			super(BoxItem);
		}



	}
}
