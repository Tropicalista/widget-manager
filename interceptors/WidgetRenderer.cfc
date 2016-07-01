component extends="coldbox.system.Interceptor" {

    property name="mywidgetService" inject="entityService:wmWidget";
	property name="widgetService" inject="id:widgetService@cb";

	public any function cbui_beforeSideBar(event, interceptData) {
		var widgets = mywidgetService.findAllWhere( criteria={ interceptionPoint="cbui_beforeSidebar" } );

		var widgetString = "";
		for( w in widgets ){
			widgetString &= w.getMemento().content;
		}
		appendToBuffer(widgetString);

	}

	public any function cbui_afterSideBar(event, interceptData) {
		appendToBuffer("arguments.interceptData");
	}

}