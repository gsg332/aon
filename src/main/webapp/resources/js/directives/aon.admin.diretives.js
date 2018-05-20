angular
		.module('aon.admin.diretives', [])
 		.directive('leftMenu', function($location) {
			return function(scope) {
				var locationUrl = $location.absUrl();
				locationUrl = locationUrl.substring(locationUrl.indexOf('supervisor/') + 11);
				locationUrl = locationUrl.substring(0, locationUrl.indexOf('/'));
				if(locationUrl == 'index.aon#'){ locationUrl = ''; }
				scope.leftMenu = locationUrl;
			};
		});
