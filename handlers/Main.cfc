component {

    // Dependencies
    property name="menuService"     inject="id:menuService@cb";
    property name="menuItemService" inject="id:menuItemService@cb";
    property name="cb"              inject="id:cbHelper@cb";
    property name="HTMLHelper"      inject="HTMLHelper@coldbox";

    property name="widgetService"   inject="id:widgetService@cb";
    property name="widgetManagerService" inject="entityService:wmWidget";

    // Public properties
    this.preHandler_except = "pager";

    // pre handler
    function preHandler( event, action, eventArguments, rc, prc ){
        // Get module root
        prc.moduleRoot = getModuleSettings( "WidgetManager" ).mapping;
    }
    
    // index
    function index( required any event, required struct rc, required struct prc ){
        // view
        prc.widgets = widgetManagerService.getAll(asQuery=true);
        event.setView( "main/index" );
    }

    function viewWidgetInstance( event, rc, prc ) {
        // param data
        event.paramValue( "modal", false )
            .paramValue( "test", false )
            .paramValue( "widgetudf", "renderIt" );

        // get widget
        var widget  = widgetService.getWidget( name=rc.widgetname, type=rc.widgettype );
        prc.md      = widgetService.getWidgetRenderArgs( udf=rc.widgetudf, widget=rc.widgetname, type=rc.widgettype );
        prc.widget = {
            name        = rc.widgetname,
            widgetType  = rc.widgettype,
            widget      = widget,
            udf         = rc.widgetudf,
            module      = find( "@", rc.widgetname ) ? listGetAt( rc.widgetname, 2, '@' ) : "",
            category    = !isNull( widget.getCategory() ) ? 
                            widget.getCategory() : 
                            rc.widgetType=="Core" ?
                                "Miscellaneous" :
                                rc.widgetType,
            icon        = !isNull( widget.getIcon() ) ? widget.getIcon() : ""
        };
        // get its metadata
        prc.metadata = widget.getPublicMethods();
        prc.vals = rc;
        prc.vals[ "widgetUDF" ] = prc.widget.udf;
        if( event.isAjax() ) {
            event.renderData( data=renderView( view="widgets/instance", layout="ajax", module="WidgetManager" ) );
        }
        else {
            event.setView( view="widgets/instance", layout="ajax" );
        }
    }

}