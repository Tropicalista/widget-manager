/**
* A ColdBox Enabled virtual entity service
*/
component extends="cborm.models.VirtualEntityService" singleton{
	
	property 	name="settingService"			inject="id:settingService@cb" 		persistent="false";
	property 	name="cachebox" 				inject="cachebox" 					persistent="false";

	/**
	* Constructor
	*/
	function init(){
		
		// init super class
		super.init( entityName="WmWidget", useQueryCaching=true );

	    return this;
	}
	
	public any function getAllWidgets() {

		var settings = settingService.getAllSettings(asStruct=true);

		// caching enabled?
		if( settings.cb_content_caching ){

			// Build Cache Key
			var cacheKey = "cb-content-#cgi.http_host#-widgetManager";
			// Get appropriate cache provider
			var cache = cacheBox.getCache( settings.cb_content_cacheName );
			// Try to get content?
			var cachedContent = cache.get( cacheKey );
			// Verify it exists, if it does, return it
			if( !isNull( cachedContent ) AND len( cachedContent ) ){ return cachedContent; }

		}

		var renderedWidgets = list( asQuery="false", sortOrder="wOrder" );

		// caching enabled?
		if( settings.cb_content_caching ){
			// Store content in cache, of local timeouts are 0 then use global timeouts.
			cache.set(
				cacheKey,
				renderedWidgets,
				settings.cb_content_cachingTimeout,
				settings.cb_content_cachingTimeoutIdle
			);
		}

		// renturn translated content
		return renderedWidgets;

	}

	public any function deleteWidgetListFromCache() {

		var settings = settingService.getAllSettings(asStruct=true);

		// caching enabled?
		if( settings.cb_content_caching ){

			// Build Cache Key
			var cacheKey = "cb-content-#cgi.http_host#-widgetManager";
			// Get appropriate cache provider
			var cache = cacheBox.getCache( settings.cb_content_cacheName );
			// Try to get content?
			var cachedContent = cache.clearKey( cacheKey );

		}

		//getAllWidgets();

	}

}