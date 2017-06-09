<cfoutput>
	<link rel="stylesheet" type="text/css" href="#prc.moduleRoot#/includes/css/style.css">
    <script type="text/javascript" src="#prc.moduleRoot#/includes/js/nestable.js"></script>
<!--- page JS --->
<script type="text/javascript">

$(document).ready(function() {

    $('.dd').nestable({
        maxDepth: 1
    });
    $('.dd').on('change', function() {
        reorder(this.id)
    });

} );

function getWidgetInstanceURL(){ return '#event.buildLink( prc.cbAdminEntryPoint & ".widgets.viewWidgetInstance" )#'; }
//function getContentStoreSelectorURL(){ return '#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.main.viewWidgetInstance" )#'; }
function getWidgetPreviewURL(){ return '#event.buildLink( prc.cbAdminEntryPoint & ".widgets.preview" )#'; }

function insertStore( store, interceptionPoint, id ){ 
    var wList = $( '##' + interceptionPoint ).children();
    if(id){
        $('[data-id="'+id+'"]').replaceWith(store)
    }else{
        wList.append(store);
    }
    reorder(wList.parent().attr('id'));  

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
        $('[data-id="'+id+'"]').remove()
        closeConfirmations();
    })
    .fail(function(data) {
    })
}

function insertEditorContent( interceptionPoint, content ){
    $.ajax({
        type: "POST", 
        url : "#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.widget.save" )#",
        data: {
            widgetContent: content.match(/'(.*?)'/)[1],
            wType: "contentStore",
            interceptionPoint: $remoteModal.data().params.interceptionPoint,
            widgetId: $remoteModal.data().params.widgetId
        }
    })
    .success(function(data) {
        insertStore( data, $remoteModal.data().params.interceptionPoint, $remoteModal.data().params.widgetId )
    })
    .fail(function(data) {
    })
}

function reorder(id){

    var i, arr = $('##'+id).nestable('serialize'), len = arr.length;
    for (i=0; i<len; ++i) {
      if (i in arr) {
        $('[data-id="'+arr[i].id+'"]').attr("data-order", i)
      }
    }
    saveAll();
}

function saveAll(){
    var arr = [];
    $('[data-order]').each(function() {

            arr.push({
                id: $(this).attr('data-id'),
                wOrder: $(this).attr('data-order')
            });
    });
    $.ajax({
        type: "POST", 
        url : "#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.widget.saveOrder" )#",
        data: {data:JSON.stringify(arr)}
    })

}

</script>
</cfoutput>