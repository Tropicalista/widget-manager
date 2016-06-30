<cfoutput>
	<link rel="stylesheet" type="text/css" href="#prc.moduleRoot#/includes/css/style.css">
    <script type="text/javascript" src="#prc.moduleRoot#/includes/js/nestable.js"></script>
<!--- page JS --->
<script type="text/javascript">

$(document).ready(function() {

	var el = document.getElementById('editable');
	sortable = Sortable.create(el, {
        //handle: '.drag-handle',
        animation: 150,
        filter: '.js-remove',
		onMove: function (evt, sortable) {
            console.log(evt);
			//evt.item.parentNode.removeChild(evt.item);
		},
        // Element is removed from the list into another list
        onFilter: function (evt) {
            var w = sortable.closest( evt.item ); // get dragged item
            w && w.parentNode.removeChild( w );
            deleteStore( $(w).attr('data-id') )
        }
	});

} );

function getWidgetInstanceURL(){ return '#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.main.viewWidgetInstance" )#'; }
//function getContentStoreSelectorURL(){ return '#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.main.viewWidgetInstance" )#'; }
function getWidgetPreviewURL(){ return '#event.buildLink( prc.cbAdminEntryPoint & ".widgets.preview" )#'; }

function insertStore( store ){ 
    var el = document.createElement('li');
    el.innerHTML = store.widgetObject + '<i class="fa fa-times js-remove"></i>';
    $(el).attr('data-store', store.widgetObject );
    $(el).attr('data-id', store.id );

    sortable.el.appendChild(el);
}

function deleteStore( id ){
    $.post('#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.widget.remove" )#',
    {
        widgetId: id
    },
    function(data, status){
        console.log(data)
    }); 
}

function insertEditorContent( store, content ){
    $.post('#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.widget.save" )#',
    {
        widgetContent: content,
        interceptionPoint: store,
        widgetId: ""
    },
    function(data, status){
    })
    .success(function(data) {
        insertStore( data )
    })
    .fail(function() {
        console.log( "error" );
    })
}

</script>
</cfoutput>