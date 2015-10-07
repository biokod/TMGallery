package app.view 
{
	import app.model.BoxItem;
	import app.model.GalleryModel;
	import app.model.IBox;

	import com.greensock.TweenLite;

	import flash.events.MouseEvent;

	import org.robotlegs.mvcs.Mediator;

	public class GalleryMediator extends Mediator
	{
		public function GalleryMediator() { }
		
		[Inject]
		public var view:GalleryView;
		
		[Inject]
		public var model:GalleryModel;
		
		override public function onRegister():void
		{
			model.itemClicked.add(onItemClicked);
			model.itemsPacked.add(onItemsPacked);
			model.stopRefresh.add(onItemsEnd);
			view.drawBackground();
			view.width = contextView.stage.stageWidth;
			view.height = contextView.stage.stageHeight;
		}

		private function onItemsPacked():void
		{
			view.mouseChildren = true;
			view.mouseEnabled = true;
		}

		private function onItemClicked(item:IBox):void
		{
			view.mouseChildren = false;
			view.mouseEnabled = false;
			TweenLite.to(item.displayObject, 0.5, {alpha:0, onComplete:model.removeItem, onCompleteParams:[item]});
		}

		private function onItemsEnd():void
		{
			view.mouseChildren = false;
			view.mouseEnabled = false;
		}

		override public function onRemove():void
		{
			//view.destroy();
			view = null;
		}
		

	}
}