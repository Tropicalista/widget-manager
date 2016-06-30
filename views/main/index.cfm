<cfoutput>
<!---<div class="row">
    <div class="col-md-3">
		<div class="panel panel-primary">
			<div class="panel-heading">
			<h3 class="panel-title"><i class="fa fa-cogs"></i> Sidebar widget</h3>
			<div class="actions pull-right">
			    <a href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/widgets/editorselector', {editorName: 'beforeSidebar', interceptionPoint: 'beforeSidebar'}, 1000, 650 );" class="btn btn-info btn-xs" title="Insert widget"><i class="fa fa-plus"></i></a>
			    <a href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/contentstore/editorselector', {editorName: 'beforeSidebar', interceptionPoint: 'beforeSidebar'}, 1000, 650 );" class="btn btn-info btn-xs" title="Insert contentstore"><i class="fa fa-hdd-o"></i></a>
			</div>			
			</div>
			<div class="panel-body">
				<div class="dd">
				    <ol class="dd-list" id="beforeSidebar">
		        	<cfloop array="#prc.widgets#" index="w">
					        <li class="dd-item" data-id="#w.getWidgetId()#">
								<a class="dd-handle dd3-handle btn" title="Drag to reorder">
									<i class="fa fa-bars fa-lg"></i>
								</a>
								<div class="dd3-content double" data-toggle="context" data-target="##context-menu">
					        		<cfif isJson(w.getWidgetContent())>
					        			<cfset widgetArgs = deserializeJson(w.getWidgetContent())>
										#widgetArgs.widgetName#
									<cfelse>
										#w.getWidgetContent()#
									</cfif>
								</div>
								<a href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/contentstore/editorselector', {editorName: 'beforeSidebar', interceptionPoint: 'beforeSidebar', widgetId: #w.getWidgetId()#}, 1000, 650 );" class="dd3-expand btn" title="Edit Details">
									<i class="fa fa-edit fa-lg"></i>
								</a>
								<a 	class="dd3-delete btn btn-danger confirmIt" 
									title="Delete widget"
									href="javascript:deleteWidget(#w.getWidgetId()#)">
									<i class="fa fa-trash-o fa-lg"></i>
								</a>			
					        </li>
		        	</cfloop>
				    </ol>
				</div>					
			</div>
		</div>
	</div>
</div>--->
<div class="row">
    <div class="col-md-3">
		<div class="panel panel-primary">
			<div class="panel-heading">
			<h3 class="panel-title"><i class="fa fa-cogs"></i> Sidebar widget</h3>
			<div class="actions pull-right">
			    <a href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/widgets/editorselector', {editorName: 'beforeSidebar', interceptionPoint: 'beforeSidebar'}, 1000, 650 );" class="btn btn-info btn-xs" title="Insert widget"><i class="fa fa-plus"></i></a>
			    <a href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/contentstore/editorselector', {editorName: 'beforeSidebar', interceptionPoint: 'beforeSidebar'}, 1000, 650 );" class="btn btn-info btn-xs" title="Insert contentstore"><i class="fa fa-hdd-o"></i></a>
			</div>			
			</div>
			<div class="panel-body">
				<div class="dd">
				    <ol class="dd-list" id="beforeSidebar">
		        	<cfloop array="#prc.widgets#" index="w">
		        		<cfscript>
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
	        				args.editor.attr.interceptionPoint = "beforeSidebar"
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
</div>
</cfoutput>