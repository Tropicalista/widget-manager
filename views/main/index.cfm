<cfoutput>
<div class="row">
	<div class="col-md-12">
		<div class="hidden alert alert-warning" id="msgWidget">
			<p>Please note that you should click 
			<button class="btn btn-danger btn-xs" id="saveWidget">save</button> button to save the widget order in database. </p>
		</div>
	</div>
</div>
<div class="row">
	<cfloop array="#prc.interceptionPoint#" index="intP">
    <div class="col-md-3">
		<div class="panel panel-primary">
			<div class="panel-heading">
			<h3 class="panel-title"><i class="fa fa-cogs"></i> #intP#</h3>
			<div class="actions pull-right">
			    <a href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/widgets/editorselector', {editorName: 'widget', interceptionPoint: '#intP#'}, 1000, 650 );" class="btn btn-info btn-xs" title="Insert widget"><i class="fa fa-plus"></i></a>
			    <a href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/contentstore/editorselector', {editorName: 'contentStore', interceptionPoint: '#intP#'}, 1000, 650 );" class="btn btn-info btn-xs" title="Insert contentstore"><i class="fa fa-hdd-o"></i></a>
			</div>			
			</div>
			<div class="panel-body">
				<div class="dd" id="#intP#">
				    <ol class="dd-list">
		        	<cfloop array="#prc.widgets#" index="w">
		        		<cfscript>
		        			if( w.getInterceptionPoint() NEQ "#intP#" ){
		        				continue;
		        			}
				            var args = {
				                widgetItem  = w,
				            };		        			
		        			if( w.getWType() EQ "widget" ){
		        				args.editor.url = "#event.buildLink( prc.cbAdminEntryPoint & ".module.WidgetManager.main.viewWidgetInstance" )#";
		        				args.editor.attr = deserializeJSON(w.getWidgetContent());
		        				args.editor.attr.mode = "Edit";
		        				args.editor.attr.modal = true;		        				
		        				args.editor.attr.editorName = "widget";		        				
		        			}else{
		        				args.editor.url = "#event.buildLink( prc.cbAdminEntryPoint )#/contentstore/editorselector";
		        				args.editor.attr.editorName = "contentStore";		        				
		        			}
	        				args.editor.attr.widgetId = w.getWidgetId();
	        				args.editor.attr.interceptionPoint = "#intP#"
		        		</cfscript>

		        		#renderView( 
		                    view="widgetItem", 
		                    args = args,
		                    module="WidgetManager"
		                )#
		        	</cfloop>
				    </ol>
				</div>					
			</div>
		</div>
	</div>
	</cfloop>
</div>
</cfoutput>