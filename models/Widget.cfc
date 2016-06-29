component entityname="wmWidget" persistent="true" accessors="true" table="cb_wm_widget" {
		
	property name="widgetId" fieldtype="id" generator="native" setter="false";
	property name="widgetContent" notnull="true" ormtype="text";
	property name="interceptionPoint" notnull="true";
	property name="order" ormtype="integer" notnull="true" default="0";

	// Validation
	this.constraints = {
	  "widgetContent" = { required=true, requiredMessage="Please insert a widgetContent!" },
	  "interceptionPoint" = { required=true, requiredMessage="Please insert an interception point!" }
	};

	Widget function init(){
		return this;
	}

	/**
	* Get a flat representation of this dashboard
	*/
	public struct function getMemento(string exclude=""){
		var data = {};

        data.widgetObject = isJson( getWidgetContent() ) ? deserializeJson( getWidgetContent() ) : getWidgetContent();
        data.id = getWidgetId();

		return data;
	}

}