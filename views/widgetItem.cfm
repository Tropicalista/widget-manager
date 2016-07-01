<cfoutput>
<li class="dd-item" id="w_#args.widgetItem.getWidgetId()#" data-id="#args.widgetItem.getWidgetId()#" data-order="#args.widgetItem.getWOrder()#">
	<a class="dd-handle dd3-handle btn" title="Drag to reorder">
		<i class="fa fa-bars fa-lg"></i>
	</a>
	<div class="dd3-content double">
		<cfif isJson(args.widgetItem.getWidgetContent())>
			<cfset widgetArgs = deserializeJson(args.widgetItem.getWidgetContent())>
			#widgetArgs.widgetName#
		<cfelse>
			#args.widgetItem.getWidgetContent()#
		</cfif>
	</div>
	<a href='javascript:openRemoteModal( "#args.editor.url#", #serializeJson(args.editor.attr)#, 1000, 650 );' class="dd3-expand btn" title="Edit Details">
		<i class="fa fa-edit fa-lg"></i>
	</a>
	<a 	class="dd3-delete btn btn-danger confirmIt" 
		title="Delete widget"
		href="javascript:deleteWidget(#args.widgetItem.getWidgetId()#)">
		<i class="fa fa-trash-o fa-lg"></i>
	</a>		
</li>
</cfoutput>