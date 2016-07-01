component extends="coldbox.system.Interceptor" {

    property name="mywidgetService" inject="id:wmWidgetService@WidgetManager";
	property name="widgetService" inject="id:widgetService@cb";

	function getWidgetRendered( interceptionPoint ){
		var widgets = mywidgetService.init().filteredWidgets( arguments.interceptionPoint );
		var widgetString = "";
		for( w in widgets ){
			widgetString &= w.getMemento().content;
		}
		appendToBuffer(widgetString);
	}

    public function cbui_afterBodyStart(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_beforeBodyEnd(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_footer(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_beforeContent(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_afterContent(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_beforeSideBar(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_afterSideBar(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_preEntryDisplay(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_postEntryDisplay(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_preIndexDisplay(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_postIndexDisplay(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_preCommentForm(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_postCommentForm(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_prePageDisplay(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_postPageDisplay(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_preArchivesDisplay(){
		getWidgetRendered( getFunctionCalledName() );
    }
    public function cbui_postArchivesDisplay(){
		getWidgetRendered( getFunctionCalledName() );
    }

}