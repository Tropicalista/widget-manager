component {

    // Dependencies
    property name="widgetService" inject="entityService:wmWidget";   

    // save widget
    function save(event,rc,prc){

        event.paramValue("widgetId", "");
        event.paramValue("wType","widget");

        // get it and populate it
        var oWidget = populateModel( widgetService.get(id=rc.widgetID) );
        // validate it
        prc.validationResults = validateModel( oWidget );
        if( !prc.validationResults.hasErrors() ){
            // save content
            widgetService.save( oWidget );

            var args = {
                widgetItem  = oWidget,
            };                          
            if( oWidget.getWType() EQ "widget" ){
                args.editor.url = "#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.main.viewWidgetInstance" )#";
                args.editor.attr = deserializeJSON(oWidget.getWidgetContent());
                args.editor.attr.mode = "Edit";
                args.editor.attr.modal = true;                              
                args.editor.attr.editorName = "widget";                             
            }else{
                args.editor.url = "#event.buildLink( prc.cbAdminEntryPoint )#/contentstore/editorselector";
                args.editor.attr.editorName = "contentStore";                               
            }
            args.editor.attr.interceptionPoint = "beforeSidebar"
            args.editor.attr.widgetId = oWidget.getWidgetId();
            savecontent variable="menuItem" {
                writeoutput(renderView( 
                    view="widgetItem", 
                    args = args,
                    module="WidgetManager"
                ));
            };
            event.renderData( data=menuItem, type="text" );

        }else{
            event.renderData( data=prc.validationResults.getAllErrorsAsJSON(), contentType="application/json", statusCode="500" );
        }

    }

    function remove(event,rc,prc){
        var oWidget   = widgetService.get( rc.widgetId );

        if( !isNull(oWidget) ){
            // remove
            widgetService.delete( oWidget );
        }
        event.renderData( data="ok", contentType="text" );

    }


}