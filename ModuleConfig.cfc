/**
* 
*/
component {

	// Module Properties
	this.title 				= "WidgetManager";
	this.author 			= "Francesco Pepe";
	this.webURL 			= "http://www.tropicalseo.net";
	this.description 		= "A module to manage widget and contentstore with drag&drop";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= false;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "WidgetManager";
	this.modelNamespace		= "WidgetManager";
	this.aliases = [ "WidgetManager" ];

	function configure(){

  		settings = {
			mapping = moduleMapping
		};

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Interceptors
		interceptors = [
			{ class="#moduleMapping#.interceptors.WidgetRenderer", properties={ entryPoint="cbadmin" }, name="WidgetRenderer@WidgetManager" }
		];

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// Let's add ourselves to the main menu in the Modules section
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		// Add Menu Contribution
		menuService.addSubMenu(topMenu=menuService.LOOK_FEEL,name="WidgetManager",label="Widgets Manager",href="#menuService.buildModuleLink('WidgetManager','main')#");
	}

	function onActivate() {
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		// Let's remove ourselves to the main menu in the Modules section
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		// Remove Menu Contribution
		menuService.removeSubMenu(topMenu=menuService.LOOK_FEEL,name="WidgetManager");
	}

}
