component extends="coldbox.system.Interceptor" {

    property name="mywidgetService" inject="entityService:wmWidget";
	property name="widgetService" inject="id:widgetService@cb";

	public any function cbui_beforeSideBar(event, interceptData) {
		var widgets = mywidgetService.findAllWhere( criteria={ interceptionPoint="beforeSidebar" } );

		var widgetString = "";
		for( w in widgets ){
			if( w.getWType() EQ "widget" ) ){
				myWidget = deserializeJSON( w.getWidgetContent() );
				widgetContent = evaluate( 'widgetService.getWidget( name=myWidget.widgetName, type=myWidget.widgetType ).#myWidget.renderMethodSelect#( argumentCollection=myWidget )' );
			}else{

				widgetContent = evaluate( 'widgetService.getWidget( name="ContentStore", type="Core" ).renderIt( slug="#w.getWidgetContent()#" )' );
			}
			widgetString &= widgetContent;
		}
		appendToBuffer(widgetString);

	}

}