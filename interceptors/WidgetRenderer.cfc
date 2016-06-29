component extends="coldbox.system.Interceptor" {

    property name="mywidgetService" inject="entityService:wmWidget";
	property name="widgetService" inject="id:widgetService@cb";

	public any function cbui_beforeSideBar(event, interceptData) {
		var widgets = mywidgetService.findAllWhere( criteria={ interceptionPoint="beforeSidebar" } );

		var widgetString = "";
		for( w in widgets ){
			if( isJson( w.getWidgetContent() ) ){
				myWidget = deserializeJSON( w.getWidgetContent() );
				widgetContent = evaluate( 'widgetService.getWidget( name=myWidget.widgetName, type=myWidget.widgetType ).#myWidget.renderMethodSelect#( argumentCollection=myWidget )' );
			}else{
				myWidget = w.getWidgetContent();
				var regex = "\'.+\'";
				myWidget = REMatch( regex, myWidget );
				myWidget = Replace( myWidget[1], "'", "", "ALL" );

				widgetContent = evaluate( 'widgetService.getWidget( name="ContentStore", type="Core" ).renderIt( slug="contentbox" )' );
			}
			widgetString &= widgetContent;
		}
		appendToBuffer(widgetString);

	}

}