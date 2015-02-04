app.directive('bannerPanel',[
	function directive() {
		return {
			"restrict" : "A",
			"scope"	   : true,
			"controller" : "listServiceCtrl",
			"templateUrl": "/serbisyou-v.1/app/assets/template/banner_panel.html",
			"link"	: function onLink(scope, element, attribute) {

			}
		}
	}
])

