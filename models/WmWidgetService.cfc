/**
* A ColdBox Enabled virtual entity service
*/
component extends="cborm.models.VirtualEntityService" singleton{
	
	/**
	* Constructor
	*/
	function init(){
		
		// init super class
		super.init(entityName="WmWidget");
		// Use Query Caching
	    setUseQueryCaching( true );

	    return this;
	}
	

	public any function filteredWidgets( required string interceptionPoint = "" ) {
		var widgets = findAllWhere( criteria={ interceptionPoint=arguments.interceptionPoint }, sortOrder="wOrder asc" );
		return widgets;
	}

}