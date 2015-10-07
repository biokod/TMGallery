package app.model 
{
	import app.dicts.AppConst;
	import app.service.IFactory;
	import app.signals.ItemAdded;

	import flash.display.Sprite;

	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
	
	public class GalleryModel extends Actor
	{
		[Inject]
		public var imageFactory:IFactory;

		[Inject]
		public var itemAddedSignal:ItemAdded;

		public var itemRemoved:Signal = new Signal();
		public var itemClicked:Signal = new Signal();
		public var itemsPacked:Signal = new Signal();
		public var stopRefresh:Signal = new Signal();

		private var _fileList:XML;
		private var rows:Array;
		private var _loadedImages:Array;
		private var _minRowHeight:int;
		private var _maxRowHeight:int;
		private var _rowIndex:int;
		private var parseIndex:int;
		private var _containerView:Sprite;
		private var nextItem:IBox;
		private var lastLoadedImageIndex:int = -1;
		private var currentRow:Array;
		private var rowsHeights:Array;
		private var isRowFinished:Boolean = true;
		private var isLastRow:Boolean = false;
		private var refreshing:Boolean = false;


		public function GalleryModel()
		{
		}

		public function init(listXML:XML, view:Sprite):void
		{
			_fileList = listXML;
			_containerView = view;
			_minRowHeight = Math.floor(_containerView.height/AppConst.ROWSMAX);
			_maxRowHeight = Math.floor(_containerView.height/AppConst.ROWSMIN);
			_loadedImages = new Array();
			rows = new Array();
			rowsHeights = new Array();
			parseIndex = 0;
			getNextItem();
		}

		public function getNextItem():void
		{
			if(refreshing && parseIndex<loadedImages.length){
				nextItem = loadedImages[parseIndex];
				nextItemReady();
			} else {
				refreshing = false;
				if(lastLoadedImageIndex+1 < fileList.children().length()){
					var url:String = fileList.*[lastLoadedImageIndex+1].@src + fileList.*[lastLoadedImageIndex+1].toString();
					nextItem = imageFactory.makeBox(url);
					itemAddedSignal.dispatch(nextItem);
					nextItem.index = lastLoadedImageIndex+1;
				} else {
					stopRefresh.dispatch();
				}
			}
		}

		public function nextItemReady():void
		{
			if(refreshing && parseIndex<loadedImages.length){
				parseIndex++;
			} else {
				refreshing = false;
				lastLoadedImageIndex++;
				loadedImages.push(nextItem);
			}

			if(isRowFinished){
				if(checkTotalHeight()) makeNewRow();
			} else {
				if(checkRowWithNextItem()){
					currentRow.push(nextItem);
					getNextItem();
				} else {
					justifyRow();
					if(!isLastRow && checkTotalHeight()) makeNewRow();
				}
			}
		}

		public function clicked(item:IBox):void
		{
			itemClicked.dispatch(item);
		}


		public function removeItem(item:IBox):void
		{
			containerView.removeChild(item.displayObject);
			loadedImages.splice(loadedImages.indexOf(item), 1);
			itemRemoved.dispatch(item);
			item.destroy();
			refreshView();
		}

		private function refreshView():void
		{
			var i:int;
			var item:IBox;

			refreshing = true;

			for(i=0; i<loadedImages.length; i++){
				item = loadedImages[i];
				//containerView.removeChild(item.displayObject);
				//item.displayObject.visible = false;
				//item.resetSize();
			}
			_loadedImages = shuffleArray(loadedImages);
			parseIndex = 0;
			isRowFinished = true;
			isLastRow = false;
			currentRow = null;
			rows = new Array();
			rowsHeights = new Array();
			getNextItem();
		}

		private function makeNewRow():void
		{
			isRowFinished = false;
			currentRow = new Array();
			rows.push(currentRow);
			currentRow.push(nextItem);
			getNextItem();
		}

		private function justifyRow():void
		{
			var item:IBox;
			var arSum:Number = 0;
			var tH:int = 0;
			var i:int = 0;
			var drawAtX:int = 0;
			var drawAtY:int = 0;

			for each(var rHeight in rowsHeights){
				drawAtY += rHeight;
			}

			for (i=0; i<currentRow.length; i++){
				item = currentRow[i];
				arSum += item.aspectRatio;
			}
			if(isLastRow){
				tH = containerView.height - drawAtY;
			} else {
				tH = int(containerView.width/arSum);
			}

			rowsHeights.push(tH);
			for (i=0; i<currentRow.length; i++){
				item = currentRow[i];
				item.height = tH;
				item.displayObject.x = drawAtX;
				item.displayObject.y = drawAtY;
				containerView.addChild(item.displayObject);
				item.displayObject.visible = true;
				drawAtX += item.width;
			}
			isRowFinished = true;
			if(isLastRow){
				itemsPacked.dispatch();
			}
		}

		private function checkTotalHeight():Boolean
		{
			var tHeight:int = 0;
			for each(var rHeight in rowsHeights){
				tHeight += rHeight;
			}
			if((containerView.height - tHeight >= minRowHeight) && (containerView.height - tHeight < minRowHeight*2)){
				isLastRow = true;
			}
			return (containerView.height - tHeight >= minRowHeight);
		}

		private function checkRowWithNextItem():Boolean
		{
			var item:IBox;
			var arSum:Number = 0;
			var tH:int = 0;

			for each(item in currentRow){
				arSum += item.aspectRatio;
			}
			arSum += nextItem.aspectRatio;
			if(isLastRow){
				var tHeight:int = 0;
				for each(var rHeight in rowsHeights){
					tHeight += rHeight;
				}
				tH = containerView.height - tHeight;
				return (tH * arSum <= containerView.width);
			} else {
				tH = int(containerView.width/arSum);
				return (tH >= minRowHeight);
			}
		}

		private function shuffleArray(array:Array):Array
		{
			var m:int = array.length;
			var i:int;
			var temp:*;

			while (m)
			{
				i = int(Math.random() * m--);

				temp = array[m];
				array[m] = array[i];
				array[i] = temp;
			}

			return array;
		}


		//--------------------------
		//--- getters & setters ----
		//--------------------------

		public function get fileList():XML
		{
			return _fileList;
		}

		public function get loadedImages():Array
		{
			return _loadedImages;
		}

		public function get minRowHeight():int
		{
			return _minRowHeight;
		}

		public function get maxRowHeight():int
		{
			return _maxRowHeight;
		}

		public function get containerView():Sprite
		{
			return _containerView;
		}

		public function set containerView(value:Sprite):void
		{
			_containerView = value;
		}

	}
}