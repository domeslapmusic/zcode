class tv.zarate.Utils.RightClick extends ContextMenu{

	public function RightClick(){
		
		super();
		
		hideBuiltInItems();
		
	}

	public function addItem(item:ContextMenuItem):Void{
		customItems.push(item);
	}
	
}