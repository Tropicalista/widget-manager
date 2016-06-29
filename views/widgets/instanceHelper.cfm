<cfset event.paramValue( "editorName", "" )> 
<style>
    .widget-preview {margin-left:340px;}
    .widget-preview-refresh {font-size:12px;float: right;margin-top:-25px;}
    .widget-arguments {width:300px;margin-top:5px;float:left;}
    .widget-preview-content {padding:20px;border:dashed 4px #eaeaea;border-radius:4px;margin-top:20px;}
    .widget-preview .well h4 {margin:0px;}
</style>
<cfoutput>
<!--- Custom Javascript --->
<script type="text/javascript">
$( document ).ready( function() {
    // register listeners
    $( '##widget-button-insert' ).off( 'click.inWidget' ).on( 'click.inWidget', insertCBWidget );
    $( '##widget-button-update' ).off( 'click.upWidget' ).on( 'click.upWidget', updateCBWidget );
    $( '.widget-preview-refresh' ).off( 'click.refWidget' ).on( 'click.refWidget', updatePreview );
    $( '.widget-arguments' ).delegate( 'input,select', 'change', function(){
        if( !$( this ).hasClass( 'renderMethodSelect' ) ) {
            updatePreview();
        }
        else {
            updateArgs( $( this ) );
        }
    } );
    updatePreview();
} );

/*
 * Gets form values from arguments form
 * return {Array}
 */
function getFormValues() {
    var form = $( '##widget-arguments' ).find( 'form' ).serializeArray(),
        vals = {};
    // loop over form fields, and add form field values to struct
    $.each( form, function(){
        vals[ this.name ] = this.value;
    } );
    return vals;
}

/*
 * Updates arguments div with new form based on render method selection
 * @select {HTMLSelect} the select box
 * return void
 */
function updateArgs( select ) {
    var vals = getFormValues();
    $.ajax( {
        type: 'GET',
        url: getWidgetInstanceURL(),
        data: {
            widgetName: vals.widgetName,
            widgetType: vals.widgetType,
            widgetDisplayName: vals.widgetDisplayName,
            widgetUDF: select.val(),
            editorName: '#rc.editorName#',
            modal: false
        },
        success: function( data ) {
            // update content
            $( '##widget-preview-wrapper' ).parent().html( data );
        }
    } );
}

/*
 * Simple, common method to update preview div based on form parameters
 */
function updatePreview() {
    // get form
    var vals = getFormValues(),
        me = this;
        // make ajax request for preview content
        $.ajax( {
            type: 'GET',
            url: getWidgetPreviewURL(),
            data: vals,
            success: function( data, status, xhr ) {
                // if we have content, update it
                if( !data.length ) {
                    $( '##widget-preview-content' ).html( '<div class="widget-no-preview">No preview available!</div>' ); 
                }
                // otherwise, show error message
                else {
                    $( '##widget-preview-content' ).html( data );
                }
            },
            error: function( e ) {
                $( '##widget-preview-content' ).html( '<div class="widget-no-preview">No preview available!</div>' );
            }
        } );
}


/*
 * Creates widget for CKEDITOR instance editor
 */
function insertCBWidget(){
    // conditional selector for different kinds of widgets
    var form = $( '##widget-arguments' ).find( 'form' ),
        widgetContent,widgetInfobar,widgetInfobarImage,
        args = form.serializeArray(),
        vals = getFormValues(),
    // apply form validator
    form.validate();
    // choose form based on selector
    var $widgetForm = form;
    // validate form
    if( !$widgetForm.valid() ){
        return;
    }
    // add selector to args form
    args = form.serializeArray();
    vals = getFormValues();
    // create new widget element
    saveWidget( vals );
}

/*
 * Updates widget in CKEditor with new values from form
 * return void
 */
function updateCBWidget() {
    var editor = $( "###rc.editorName#" ).ckeditorGet(),
        element = editor.widgetSelection,
        textel = element.getChild( 0 ).getChild( 1 ),
        form = $( '##widget-arguments' ).find( 'form' ),
        args = form.serializeArray(),
        vals=getFormValues(),
    // apply form validator
    form.validate();
    // choose form based on selector
    var $widgetForm = form;
    // validate
    if( !$widgetForm.valid() ){
        return;
    }
    textel.setText( infobarText );
    // update element attributes and text
    element.setAttributes( vals );
    closeRemoteModal();
}

/*
 * Pushes new element into CKEDITOR instance editor
 * @element {CKEDITOR.dom.element} The CKEDITOR element to insert into the editor
 */
function addWidgetToList( widget ){
    console.log(widget)
    var el = document.createElement('li');
    el.innerHTML = widgetDisplayName + '<i class="fa fa-times js-remove"></i>';
    $(el).attr('data-widget', JSON.stringify(widget) );
    $(el).attr('data-id', widget.id );

    sortable.el.appendChild(el);

    // call via editor interface to insert
    closeRemoteModal();
}

function saveWidget(widget){
    $.post('#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.widget.save" )#',
    {
        widgetContent:JSON.stringify(widget),
        widgetId: ""
    },
    function(data, status){
        addWidgetToList(data)
    });     
}
</script>
</cfoutput>