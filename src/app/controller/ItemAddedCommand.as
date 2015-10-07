package app.controller 
{
	import app.model.BoxItem;
	import app.signals.ImageReady;
	import app.signals.ItemAdded;
	import app.view.ImageView;

	import flash.display.Bitmap;

	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	import org.robotlegs.mvcs.Command;
	import org.robotlegs.mvcs.SignalCommand;

	public class ItemAddedCommand extends SignalCommand
	{
		public function ItemAddedCommand() { }

		[Inject]
		public var item:BoxItem;

		[Inject]
		public var imageReadySignal:ImageReady;

		private var loader:Loader;
		
		override public function execute():void
		{
			//trace(item.index + " url:" + item.imageURL);
			loadPicture();
		}

		private function loadPicture():void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoadHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.load(new URLRequest(item.imageURL));
		}

		private function imageLoadHandler(event:Event):void
		{
			var image:ImageView = new ImageView((loader.content as Bitmap), item);
			mediatorMap.createMediator(image);
			injector.instantiate(ImageReady);
			item.addImage(image);
			imageReadySignal.dispatch(item);
		}

		private function errorHandler(event:ErrorEvent):void
		{
			throw new Error("bad link or no connection");
		}
	}
}