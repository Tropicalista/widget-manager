component {

    // Dependencies
    property name="widgetService" inject="entityService:wmWidget";   

    // save widget
    function save(event,rc,prc){

        event.paramValue("widgetId", "");
        event.paramValue("interceptionPoint","Core");

        // get it and populate it
        var oWidget = populateModel( widgetService.get(id=rc.widgetID) );
        // validate it
        prc.validationResults = validateModel( oWidget );
        if( !prc.validationResults.hasErrors() ){
            // save content
            widgetService.save( oWidget );

            event.renderData( data=serializeJson( oWidget.getMemento() ), contentType="application/json" );
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
        event.renderData( data="", contentType="application/json" );

    }


}