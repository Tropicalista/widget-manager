component extends="coldbox.system.Interceptor" {

    property name="mywidgetService" inject="id:wmWidgetService@WidgetManager";
	property name="widgetService" inject="id:widgetService@cb";

	void function configure(){
	}

	public any function renderWidget( interceptionP ) {
		
		var widgets = mywidgetService.getAllWidgets();
		for( w in widgets ){
			if(w.getinterceptionPoint() EQ interceptionP){
				appendToBuffer(w.getMemento().widgetContent)
			}
		}

	}

    function cbui_afterBodyStart(){
		renderWidget( getFunctionCalledName() );
	}

    public function cbui_beforeBodyEnd(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_footer(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_beforeContent(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_afterContent(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_beforeSideBar(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_afterSideBar(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_preEntryDisplay(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_postEntryDisplay(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_preIndexDisplay(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_postIndexDisplay(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_preCommentForm(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_postCommentForm(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_prePageDisplay(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_postPageDisplay(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_preArchivesDisplay(){
		renderWidget( getFunctionCalledName() );    
	}
    
    public function cbui_postArchivesDisplay(){
		renderWidget( getFunctionCalledName() );    
	}

}