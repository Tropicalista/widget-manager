component {

    // Dependencies
    property name="menuService"     inject="id:menuService@cb";
    property name="menuItemService" inject="id:menuItemService@cb";
    property name="cb"              inject="id:cbHelper@cb";
    property name="HTMLHelper"      inject="HTMLHelper@coldbox";

    property name="widgetService"   inject="id:widgetService@cb";
    property name="widgetManagerService" inject="id:wmWidgetService@WidgetManager";

    // pre handler
    function preHandler( event, action, eventArguments, rc, prc ){
        // Get module root
        prc.moduleRoot = getModuleSettings( "WidgetManager" ).mapping;
        prc.interceptionPoint = [
            "cbui_afterBodyStart","cbui_beforeBodyEnd",
            "cbui_footer","cbui_beforeContent",
            "cbui_afterContent","cbui_beforeSideBar",
            "cbui_afterSideBar","cbui_preEntryDisplay",
            "cbui_postEntryDisplay","cbui_preIndexDisplay",
            "cbui_postIndexDisplay","cbui_preCommentForm",
            "cbui_postCommentForm","cbui_prePageDisplay",
            "cbui_postPageDisplay","cbui_preArchivesDisplay",
            "cbui_postArchivesDisplay"
        ];
    }
    
    // index
    function index( required any event, required struct rc, required struct prc ){
        // view
        prc.widgets = widgetManagerService.list(asQuery=false);
        event.setView( "main/index" );
    }

}