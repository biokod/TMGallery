package app.view 
{
	import app.signals.ItemClicked;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;

	public class ImageMediator extends Mediator
	{
		public function ImageMediator() { }
		
		[Inject]
		public var view:ImageView;
		
		[Inject]
		public var itemClickedSignal:ItemClicked;

		override public function onRegister():void
		{
			eventMap.mapListener(view, MouseEvent.CLICK, clickHandler);
			//view.mouseEnabled = false;
			//view.visible = false;
		}

		override public function onRemove():void
		{
			eventMap.unmapListeners();
			view.destroy();
			view = null;
		}

		private function clickHandler(event:MouseEvent):void
		{
			itemClickedSignal.dispatch(view.itemModel);
		}

	}
}