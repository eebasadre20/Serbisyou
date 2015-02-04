app.controller('listServiceCtrl',[
	'$rootScope',
	'$scope', 
	'$http', 
	'listServiceFactory',
	'$location',
	function controller($rootScope,$scope,$http,listServiceFactory,$location) {
		$scope.session_user;
		$scope.session_service;
		$scope.workerinservice;
		$scope.indexServicePanel = true
		$scope.serviceProviderPanel = false;
		$scope.preview_id;


		$scope.sessionUser = function () {
			$http.get(listServiceFactory.url + '/users/get_session_user')
			.success(function onSuccess(response) {
				$scope.session_user = response;
			});
		}

		$scope.setServiceId = function ( service) {		
			$scope.serviceProviderInService(service.id);
			$scope.getCategories(service.id);
			$scope.session_service = service;
			$scope.indexServicePanel = false;

			//location.href = "/users/" + session_user.id + "/home";			
			//$scope.service_name = service.service;
			/*$scope.service_id = service.id;
			$scope.serviceprovider_panel = true;*/
		}	

		$scope.barangayList = function barangayList(id) {
			$http.get(listServiceFactory.url + '/users/get_barangay')
			.success(function onSuccess(response) {	
			    console.log(response);			
				$scope.barangays = response;
				$scope.barangays.unshift(
					{
						"barangay": "All",
						"id": "*"
					}
				);
			});
		}

		$scope.ages = [];
 		for (var i = 18 ; i <= 50; i++) {
 			$scope.ages.push(i);
 		};

 		$scope.genders = ['Male','Female'];

 		$scope.maritalStatus = ['Single','Married','Divorce','Widowed'];

 		$scope.stat = "Show";

 		$scope.filterStat = function () {
 			if($scope.stat == "Show" ) $scope.stat = "Hide";
 			else $scope.stat = "Show";
 		};

		$scope.getServiceProvider = function getServiceProvider(brgy,service_id) {
			console.log($scope.workerinservice);
		}

		$scope.serviceProviderInService = function serviceProviderInService(id) {
			$http.get(listServiceFactory.url + '/users/get_worker_in_service/' + id)
			.success(function onSuccess(response) {
				console.log(response);
				$scope.workerinservice = response;
				$scope.barangayWorker = $scope.workerinservice;
				$rootScope.$broadcast( "service-selected" , id , response );
			});
		}

		$scope.getCategories = function getCategories(id) {
			$http.post(listServiceFactory.url + '/users/get_categories/' + id)
			.success(function onSuccess(response) {
				$scope.categories = response;
				console.log(response);
			});
		}

		$scope.setBrgy = function (id) { 
			$scope.activeId = id;
		}

		$scope.setCtgry = function (id) { 
			$scope.ctgryActiveId = id;
		}

		$scope.setSelected = function setSelected(id) {
			var filtered = $scope.barangayWorker || [];
			if ( id == $scope.activeId ) return "active"; 
			else return "not-active";
		}

		$scope.setSelectedCategory = function setSelectedCategory(id) {
			var filtered = $scope.barangayWorker || [];
			if ( id == $scope.ctgryActiveId ) return "active"; 
			else return "not-active";
		}

		$scope.getNumberOfServiceProvider = function ( id ) {	
			var filtered = $scope.barangayWorker || [];
			if ( id == "*" )
				return filtered.length;
			else {
				return filtered.filter( function ( each ) {
					if ( each.barangay_id == id ) return each;
				} ).length;
			}
		};

		$scope.getNumberOfServiceProviderInCategory = function ( id ) {	
			var filtered = $scope.workerinservice || [];
			if ( id == "*" )
				return filtered.length;
			else {
				return filtered.filter( function ( each ) {
					if ( each.category_id == id ) return each;
				} ).length;
			}

		};

		$scope.filterByCategoryTest = function filterByCategoryTest( id ) {
			var filtered = $scope.workerinservice || [];
			if(id == "*") return filtered;
			else { return filtered.filter ( function (each ) {
						if (each.category_id == id) return each;
					}
				);
			}
		}
		$scope.getServiceList = function getServiceList(service) {
			$http.get(listServiceFactory.url + '/users/get_servicelist')
			.success(function onSuccess(response) {
				$scope.servicelist = response;
			});
		}

		$scope.filterParams = {};
		$scope.setBarangay = function ( barangay ) {
			$scope.filterParams.barangay_id = barangay;
		};
		$scope.setStatus = function ( status ) {
			$scope.filterParams.civil_status = status;
		};
		$scope.setGender = function ( gender ) {
			$scope.filterParams.gender = gender;
		};
		$scope.setAge = function ( age ) {
			var date = new Date();
			$scope.filterParams.birthdate = date.getFullYear() - age;
		};

		$scope.submitFilterQuery = function () {
			$http.post("https://192.168.1.35:3001/")
			console.log($scope.filterParams);
		}
	    $scope.getSkillCategories = function getSkillCategories(skill) {
	    	$http.get(listServiceFactory.url + '/users/get_categorylist/' + skill.id)
			.success(function onSuccess(response) {
				$scope.categorylist = response;
			});
	    }

	    $scope.showServiceProviderPanel = function (session_user, id) {
	    	//$scope.serviceProviderPanel = true;
	    	$scope.preview_id = id
	    	location.href = "/serviceproviders/" + id + "/preview";
	    	$scope.$broadcast( "session-user" , session_user );
	    }

 		$scope.sessionUser();
		$scope.barangayList();
		$scope.getServiceList();
		
	}
]);

app
	.controller( "commentController" , [
		"$scope",
		"$http",
		"$location",
		function controller ( $scope , $http, $location ) {


			$scope.commentSubmit = function ( ) {	
				var userId = $location.absUrl().split( "/" );
				userId = userId[userId.length - 2];	

				$http.post( "/users/" + $scope.sessionUser.id + "/comments" , {"commentor": $scope.sessionUser.firstname, "comment": $scope.commentContent, "sp": userId} )
				.success( function ( response ) {
					$scope.commentContent = '';
					$http.post("/comments/all", { "sp" : userId })
					.success( function ( response ) {
						$scope.comments = response;
					} );
				} );
			};

			$scope.getComment = function () {
				var userId = $location.absUrl().split( "/" );
				userId = userId[userId.length - 2];
				$http.post("/comments/all", { "sp" : userId })
				.success( function ( response ) {
					$scope.comments = response;
				} );
			}
		}
	] );

app
	.controller( "voteController",[
		'$scope',
		'$http',
		'$location',
		function controller( $scope, $http, $location) {

			$scope.voteIt = function ( ) {
				var userId = $location.absUrl().split( "/" );
				userId = userId[userId.length - 1];
				$http.post( "/users/" + $scope.sessionUser.id + "/vote" , {"sp": userId, "current_user" : $scope.sessionUser} )
				.success( function ( response ) {
					
				} );
			};	
		}
    ]);

app
	.controller ( "RegisterServiceProviderCtrl",[
		'$scope',
		'$http',
		'$location',
		//'FileUploader',
		function controller( $scope, $http, $location ) {
			$scope.category_panel = false;
			$scope.genders = [ "Male","Female" ];
			$scope.status = [ "Single","Married", "Deceased" ];
			$scope.sp = { serviceprovider: {},
						  categories: [],
						  clearances: [2] };
			$scope.service;

			$scope.getBarangay = function ( ) {
				$http.get("/users/get_barangay/")
				.success ( function onLink ( response) {
					$scope.barangayList = response;
					console.log( $scope.barangayList );
				});
			}

			$scope.getService = function ( ) {
				$http.get("/users/get_servicelist/")
				.success ( function onLink ( response ) {
					$scope.serviceList = response;
					console.log( $scope.serviceList );
				});
			}

			$scope.selectAction = function() {

			    $http.get('/users/get_categories/' + $scope.sp.serviceprovider.service_id)
			    .success ( function onLink ( response ) {
			    	$scope.categoryList = response;
			    	console.log($scope.categoryList.length)
			    	if($scope.categoryList.length != 0) {
			    		$scope.category_panel = true;
			    	} else {
			    		$scope.category_panel = false;
			    	}
			    });
			};

			$scope.getClearance = function clearance() {
				$http.get('/users/get_clearances/')
				.success ( function onLink ( response) {
					$scope.clearanceList = response;
					console.log(response);
				});
			}

			//$scope.uploader = new FileUploader({url: '/serviceproviders/new_serviceprovider/'});

			$scope.registerProvider = function () {
				console.log($scope.uploader);
				$http.post('/serviceproviders/new_serviceprovider/', $scope.sp )
				.success ( function onLink ( response) {
					location.href = "index";
				})
				.error ( function onLink ( response ) {
					console.log(response)
				});
			}

			$scope.getBarangay();
			$scope.getService();
			$scope.getClearance();

		}
	]);

app
	.controller ( 'PreviewCtrl',[
		'$scope',
		'$http',
		'$location',
		function controller ( $scope, $http, $location ) {
			$scope.session_user;
			$scope.serviceProviderDetails;
			$scope.message = {};

			$scope.previewInformation = function previewInformation () {
		    	var sp_id = $location.absUrl().split( "/" )
		    	sp_id = sp_id[sp_id.length - 2];
		    	$http.get('/users/get_preview/' + sp_id)
		    	.success ( function onLink ( response ) {
		    		$scope.serviceProviderDetails = response;
		    		console.log(response);
		    	});
		    }

		    $scope.sessionUser = function () {
						$http.get('/users/get_session_user')
						.success(function onSuccess(response) {
							$scope.session_user = response;
							console.log($scope.session_user);
						});
					}

		    $scope.setMessage = function setMessage( firstname , lastname, contact_number ) {

					var recipient = firstname + " " + lastname;
						 var from = $scope.session_user.firstname + " " + $scope.session_user.lastname;

						 
					$scope.message = {
						"recipient": recipient,
							 "from": from,
						   "number": contact_number,
						"message": ""
					};
			}

			$scope.sendMessage = function sendMessage ( ) {

				var message = {
					"number": "+639059149307",
					"message": $scope.message.message
				};

				$.post( "http://webnifiedsms.herokuapp.com/sms.php" , message , function ( response ) {
					console.log( response );
				} );
			}

		    
		    $scope.previewInformation();
		    $scope.sessionUser();
		}
	]);

app
	.controller ( "IndexCtrl",[
		"$scope",
		"$http",
		function controller ( $scope, $http ) {
			$scope.getAllServiceProviders = function () {
				$http.get('/brgyadmins/serviceproviders_list/')
				.success ( function onLink ( response ) {
					$scope.serviceproviders = response;
				});
			}

			$scope.getServiceProvider = function ( sp ) {
				$http.get('/brgyadmins/serviceprovider_info/' + sp.id)
				.success ( function onLink ( response ) {
					$scope.sp = response;
				});
			}

			$scope.getAllServiceProviders();
		}
	]);

app
	.directive( "servicePanel" , [
		"$location",
		"$http",
		function directive ( $location, $http ) {
			var filterByBarangay = function ( id , serviceProvider ) {
				var filteredServiceProvider = [];
				filteredServiceProvider = serviceProvider.filter( 
					function ( eachServiceProvider ) {
						if ( eachServiceProvider.barangay_id == id )
							return eachServiceProvider;
					}
				 );
				return filteredServiceProvider;
			};

			var filterByCategory = function (id, serviceProvider ) {
				var filteredServiceProvider = [];
				filteredServiceProvider = serviceProvider.filter(
					function ( eachServiceProvider ) {
						if ( eachServiceProvider.category_id == id)
							return eachServiceProvider;
					}
				);
				return filteredServiceProvider;

			}
			return {
				"restrict": "A",
				"scope": true,
				"controller" : "listServiceCtrl",
				"templateUrl": "/assets/service-panel.html.erb",
				"link": function onLink ( scope , element , attributeSet ) {
					scope.showRepeat = true;
					element.addClass( "hidden" );
					
					var loc = $location.absUrl().split( "/" );

					scope.setServiceId( {
						"id": loc[loc.length - 2],
						"service": "unknown"
					} ); 

					scope.$on( "service-selected" , 
						function ( evt , id , data ) {
							element.removeClass( "hidden" );
							scope.filterByBarangay( "*" );
							scope.setBrgy( "*" );
						} );scope.getComment( );	

					scope.filterByBarangay = function ( id ) {
						if ( id == "*" ) scope.workerinservice = scope.barangayWorker;
						else scope.workerinservice = filterByBarangay( id , scope.barangayWorker );
						scope.showRepeat = true;
					};

					scope.filterByCategory = function ( id ) {
						scope.workerinservicebycat = filterByCategory( id, scope.workerinservice );
						scope.showRepeat = false;
					};
				}
			}			
		}
	] );

app
	.directive( "commentBox" , [
		"$http",
		"listServiceFactory",
		function directive ( $http , listServiceFactory ) {
			return {
				"restrict": "A",
				"scope": true,
				"controller": "commentController",
				"link": function onLink ( scope , element , attributeSet ) {					
					$http.get(listServiceFactory.url + '/users/get_session_user')
					.success(function onSuccess(response) {
						scope.sessionUser = response;
						scope.predicate = '-id';
						scope.getComment( );						
					});

					scope.getComment( );	

				}
			}
		}
	] );

app
	.directive( "voteBox" , [
		'$http',
		'listServiceFactory',
		function directive( $http, listServiceFactory ) {
			return {
				'restrict' : 'A',
				'scope'	: true,
				'controller': 'voteController',
				'templateUrl' : "/assets/vote-panel.html",
				'link': function onLink( scope, element, attributeSet ) {
					$http.get(listServiceFactory.url + '/users/get_session_user')
					.success(function onSuccess(response) {
						scope.sessionUser = response;					
					});
				}
			}
		}
	]);

app
	.directive( "message" , [
		"$http",
		function directive ( $http ) {
			return {
				"restrict": "A",
				"scope": true,
				"controller" : 'PreviewCtrl',
				"link": function onLink ( scope , element , attributeSet ) {
	
					

					


				}
			}
		}
	] );
app
.directive('slideable', function () {
    return {
        restrict:'C',
        compile: function (element, attr) {
            // wrap tag
            var contents = element.html();
            element.html('<div class="slideable_content" style="margin:0 !important; padding:0 !important" >' + contents + '</div>');

            return function postLink(scope, element, attrs) {
                // default properties
                attrs.duration = (!attrs.duration) ? '1s' : attrs.duration;
                attrs.easing = (!attrs.easing) ? 'ease-in-out' : attrs.easing;
                element.css({
                    'overflow': 'hidden',
                    'height': '0px',
                    'transitionProperty': 'height',
                    'transitionDuration': attrs.duration,
                    'transitionTimingFunction': attrs.easing
                });
            };
        }
    };
})
.directive('slideToggle', function() {
    return {
        restrict: 'A',
        link: function(scope, element, attrs) {
            var target = document.querySelector(attrs.slideToggle);
            attrs.expanded = false;
            element.bind('click', function() {
                var content = target.querySelector('.slideable_content');
                if(!attrs.expanded) {
                    content.style.border = '1px solid rgba(0,0,0,0)';
                    var y = content.clientHeight;
                    content.style.border = 0;
                    target.style.height = y + 'px';
                } else {
                    target.style.height = '0px';
                }
                attrs.expanded = !attrs.expanded;
            });
        }
    }
});