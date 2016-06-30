<cfoutput>
	<link rel="stylesheet" type="text/css" href="#prc.moduleRoot#/includes/css/style.css">
    <script type="text/javascript" src="#prc.moduleRoot#/includes/js/nestable.js"></script>
<!--- page JS --->
<script type="text/javascript">

$(document).ready(function() {

    $('.dd').nestable({
        maxDepth: 1
    });

} );

function getWidgetInstanceURL(){ return '#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.main.viewWidgetInstance" )#'; }
//function getContentStoreSelectorURL(){ return '#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.main.viewWidgetInstance" )#'; }
function getWidgetPreviewURL(){ return '#event.buildLink( prc.cbAdminEntryPoint & ".widgets.preview" )#'; }

function insertStore( store, interceptionPoint, id ){ 
    if(id){
        $('[data-id="'+id+'"]').remove()
    }
    $( '##' + interceptionPoint ).append( store );   

}

function deleteWidget( id ){
    $.ajax({
        type: "POST", 
        url : "#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.widget.remove" )#",
        data: {
            widgetId: id
        }
    })
    .success(function(){
        console.log(12)
        $('[data-id="'+id+'"]').remove()
        closeConfirmations();
    })
    .fail(function(data) {
        console.log( data );
    })
}

function insertEditorContent( interceptionPoint, content ){
    $.ajax({
        type: "POST", 
        url : "#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.widget.save" )#",
        data: {
            widgetContent: content.match(/'(.*?)'/)[1],
            wType: "contentStore",
            interceptionPoint: interceptionPoint,
            widgetId: $remoteModal.data().params.widgetId
        }
    })
    .success(function(data) {
        insertStore( data, interceptionPoint, $remoteModal.data().params.widgetId )
    })
    .fail(function(data) {
        console.log( data );
    })
}

</script>
</cfoutput>