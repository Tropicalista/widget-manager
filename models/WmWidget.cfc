component entityname="wmWidget" persistent="true" accessors="true" table="cb_wm_widget" {
		
	property name="widgetId" fieldtype="id" generator="native" setter="false";
	property name="widgetContent" notnull="true" ormtype="text";
	property name="wType" notnull="true";
	property name="interceptionPoint" notnull="true";
	property name="wOrder" ormtype="integer" notnull="true" default="0";

	// Non persistent property
	property name="renderedWidget" persistent="false";
	property 	name="settingService"			inject="id:settingService@cb" 		persistent="false";
	property 	name="cachebox" 				inject="cachebox" 					persistent="false";
	property name="widgetService" inject="id:widgetService@cb" persistent="false";

	// Validation
	this.constraints = {
	  "widgetContent" = { required=true, requiredMessage="Please insert a widgetContent!" },
	  "interceptionPoint" = { required=true, requiredMessage="Please insert an interception point!" }
	};

	WmWidget function init(){
		return this;
	}

	/**
	* Get a flat representation of this dashboard
	*/
	public struct function getMemento(string exclude=""){
		var data = {};

        data.widgetObject = isJson( getWidgetContent() ) ? deserializeJson( getWidgetContent() ) : getWidgetContent();
        data.content = renderWidget();
        data.id = getWidgetId();

		return data;
	}

	/**
	* Render widget out using translations, caching, etc.
	*/
	any function renderWidget() profile{
		var settings = settingService.getAllSettings(asStruct=true);

		// caching enabled?
		if( settings.cb_content_caching ){
			// Build Cache Key
			var cacheKey = "cb-content-#cgi.http_host#-widgetManager-#getWidgetID()#";
			// Get appropriate cache provider
			var cache = cacheBox.getCache( settings.cb_content_cacheName );
			// Try to get content?
			var cachedContent = cache.get( cacheKey );
			// Verify it exists, if it does, return it
			if( !isNull( cachedContent ) AND len( cachedContent ) ){ return cachedContent; }
		}

		// Check if we need to translate
		if( NOT len( getRenderedWidget()  ) ){
			lock name="contentbox.widgetrendering.#getWidgetID()#" type="exclusive" throwontimeout="true" timeout="10"{
				if( NOT len( getRenderedWidget()  ) ){
					// save content
					renderedWidget  = renderWidgetSilent();
				}
			}
		}

		// caching enabled?
		if( settings.cb_content_caching ){
			// Store content in cache, of local timeouts are 0 then use global timeouts.
			cache.set(
				cacheKey,
				renderedWidget,
				settings.cb_content_cachingTimeout,
				settings.cb_content_cachingTimeoutIdle
			);
		}

		// renturn translated content
		return renderedWidget ;
	}
	
	/**
	* Renders the content silently so no caching, or extra fluff is done, just content translation rendering.
	* @content The content markup to translate, by default it uses the active content version's content
	*/
	any function renderWidgetSilent(any content=getWidgetContent()) profile{
		// render widget out, prepare builder
		var widgetString = "";

		if( getWType() EQ "widget" ){
			myWidget = deserializeJSON( getWidgetContent() );
			widgetContent = evaluate( 'widgetService.getWidget( name=myWidget.widgetName, type=myWidget.widgetType ).#myWidget.renderMethodSelect#( argumentCollection=myWidget )' );
		}else{
			widgetContent = evaluate( 'widgetService.getWidget( name="ContentStore", type="Core" ).renderIt( slug="#getWidgetContent()#" )' );
		}
		widgetString &= widgetContent;

		return widgetString;
	}	

}