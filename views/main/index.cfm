<cfoutput>
<div class="row">
    <div class="col-md-3">
		<div class="panel panel-primary">
			<div class="panel-heading">
			<h3 class="panel-title"><i class="fa fa-cogs"></i> Sidebar widget</h3>
			</div>
			<div class="panel-body">
		        <ul id="editable" class="" data-interception="leftSidebar">
		        	<cfloop array="#prc.widgets#" index="w">
		        		<cfif isJson(w.getWidgetContent())>
		        			<cfset widgetArgs = deserializeJson(w.getWidgetContent())>
		        		<li data-id="#w.getWidgetId()#">#widgetArgs.widgetName#<i class="fa fa-times js-remove"></i></li>
		        			<cfelse>
		        		<li data-id="#w.getWidgetId()#">#w.getWidgetContent()#<i class="fa fa-times js-remove"></i></li>
		        		</cfif>
		        	</cfloop>
		        </ul>
		        <a id="addUser" class="js-add-item-button button blue bg-white" href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/widgets/editorselector', {editorName: 'content'}, 1000, 650 );">Add widget</a>
			</div>
		</div>
	</div>
    <div class="col-md-6">
        <ul id="editable" data-interception="leftSidebar">
        </ul>
        <a id="addUser" class="js-add-item-button button blue bg-white" href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/widgets/editorselector', {editorName: 'content'}, 1000, 650 );">Add widget</a>
        <a id="addUser" class="js-add-item-button button blue bg-white" href="javascript:openRemoteModal( '#event.buildLink( prc.cbAdminEntryPoint )#/contentstore/editorselector', {editorName: 'beforeSidebar'}, 1000, 650 );">Add contentstore</a>
    </div>
</div>
</cfoutput>