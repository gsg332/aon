angular.module('aon.input.directives', [ 'ngCookies' ]); 

angular.module('aon.input.directives')
		.directive(
				'aonInputText',
				function($compile, $rootScope) {
					return {
						template : '<div class="has-feedback" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }">\
							<input type="text" class="form-control" placeholder="{{placeholder}}" ng-model="value" ng-required="{{required}}" \
							name="{{fieldName}}" id="{{fieldId}}" ng-keypress="keypress" data-toggle="tooltip" title="{{alertMessage}}">\
							<span class="glyphicon glyphicon-ok form-control-feedback"></span>\
							</div>',
						restrict : "AE",
						require : '^form',
						scope : {
							value : '=ngModel',
							fieldName : '@',
							fieldId : '@',
							keypress : '=aonKeypress',
							placeholder : '@',
							required : '=ngRequired',
							alertMessage : '@'
						},
						link : {
							post : function($scope, $element, $attrs, $formCtrl) {
								$element.ready(function(){
									if($attrs.fnChk){
										/*if($element.find('input').val() != ''){
											$element.addClass('has-success');
										}*/
										$element.find('span').remove();
										
										if($element.find('input').val() == ''){
											$element.find('div').removeClass('has-success').removeClass('has-error');
										}
									}
								});
							
								$scope.chkStatus = true;
								$rootScope.chkStatus = true;
								$scope.alertData = {};
								if($attrs.required) 
									$scope.alertData.content = $attrs.alertMessage;
								if($attrs.lengthCheck)
									$scope.alertData.length = $attrs.lengthMessage;
								if($attrs.exchanged)
									$scope.alertData.duplicate = $attrs.duplicatedMessage;
								if($attrs.mixCheck) $scope.alertData.mixCheck = $attrs.mixMessage;
								
								$element.off().on('focusout', function(){
									if($element.find('input').val() == ''){
										$element.find('input').attr('title', $scope.alertData.content);
										$element.find('input').attr('data-original-title', $scope.alertData.content);
										$($element).find('[data-toggle="tooltip"]').tooltip('show');
										$scope.chkStatus = false;
									} else {
										$scope.chkStatus = true;
									}
									
									if($attrs.lengthCheck && $scope.chkStatus && $element.find('input').val() != ''){
										var tmpVal = $element.find('input').val();
										if($attrs.min && $attrs.max){
											if(tmpVal.length < $attrs.min){
												$element.find('input').attr('title', $scope.alertData.length);
												$element.find('input').attr('data-original-title', $scope.alertData.length);
												$(this).find('[data-toggle="tooltip"]').tooltip('show');
												$($element).find('[data-toggle="tooltip"]').tooltip('show');
												var tmp = $($element[0]).find('div')[0];
												$(tmp).removeClass('has-success').addClass('has-error');
												$scope.chkStatus = false;
												if($attrs.exchanged){
													$rootScope.chkStatus = false;
												}
											} else if(tmpVal.length > $attrs.max){
												$element.find('input').attr('title', $scope.alertData.length);
												$element.find('input').attr('data-original-title', $scope.alertData.length);
												$(this).find('[data-toggle="tooltip"]').tooltip('show');
												$($element).find('[data-toggle="tooltip"]').tooltip('show');
												var tmp = $($element[0]).find('div')[0];
												$(tmp).removeClass('has-success').addClass('has-error');
												$scope.chkStatus = false;
												if($attrs.exchanged){
													$rootScope.chkStatus = false;
												}
											} else {
												$($element).find('[data-toggle="tooltip"]').tooltip('hide');
												var tmp = $($element[0]).find('div')[0];
												$(tmp).removeClass('has-error').addClass('has-success');
												$scope.chkStatus = true;
												if($attrs.exchanged){
													$rootScope.chkStatus = true;
												}
											}
										}
									}
									
									if($attrs.exchanged && $scope.chkStatus && $element.find('input').val() != ''){
										var nickChk = $rootScope.chkDuplicate($element.find('input').val(), $attrs.exchangedType);
										if(!nickChk){
											$element.find('input').attr('title', $scope.alertData.duplicate);
											$element.find('input').attr('data-original-title', $scope.alertData.duplicate);
											setTimeout(function(){
												$($element).find('[data-toggle="tooltip"]').tooltip('show');
											},200)
											//$(this).find('[data-toggle="tooltip"]').tooltip('show');
												
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-success').addClass('has-error');
											$scope.chkStatus = false;
											$rootScope.chkStatus = false;
										} else {
											$($element).find('[data-toggle="tooltip"]').tooltip('hide');
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-error').addClass('has-success');
											$scope.chkStatus = true;
											$rootScope.chkStatus = true;
										}
										
										if($element.find('input').val() != '' && $attrs.mixCheck){
											var chk = 0;
									        if($element.find('input').val().search(/[!@#$%^&*()?_~]/g)  != -1  ) chk ++;
									        
									        if(chk > 0){
									        	$element.find('input').attr('title', $scope.alertData.mixCheck);
												$element.find('input').attr('data-original-title', $scope.alertData.mixCheck);
												setTimeout(function(){
													$($element).find('[data-toggle="tooltip"]').tooltip('show');
												},200)
												var tmp = $($element[0]).find('div')[0];
												$(tmp).removeClass('has-success').addClass('has-error');
												
												$scope.$apply(function(){
													$formCtrl.$invalid = true;
													$formCtrl.$valid = false;
												});
									        } else {
									        	var tmp = $($element[0]).find('div')[0];
												$(tmp).removeClass('has-error').addClass('has-success');
									        }
										}
										
									}
									/*if($attrs.fnChk){
										fnChk($attrs.fnChk);
									}*/
								}).on('focusin', function(){
									$(this).find('[data-toggle="tooltip"]').tooltip('hide');
								}).on('keypress', function(){
									/*$scope.$watch('value', function(){
										if($attrs.fnChk){
											fnChk($attrs.fnChk);
										}
									});*/
								});
								
								$scope.form = $formCtrl;
								if (!$attrs.required) {
									$element.find('span').remove();
									$element.find('input').remove();
									var input = '<input type="text" name="{{fieldName}}" placeholder="{{placeholder}}" class="form-control" ng-model="value">';
									var ln = $compile(input);
									var content = ln($scope);
									$element.append(content);
								}
							}

						}
					}
				})
		.directive(
				'aonInputPrice',
				function($compile) {
					return {
						template : '<div class="has-feedback" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }">\
							<input type="text" class="form-control" placeholder="{{placeholder}}" ng-model="value" ng-required="{{required}}" \
							name="{{fieldName}}" data-toggle="tooltip" title="{{alertMessage}}" ng-pattern="onlyNumbers">\
							<span class="glyphicon glyphicon-ok form-control-feedback"></span>\
							</div>',
						restrict : "AE",
						require : '^form',
						scope : {
							value : '=ngModel',
							fieldName : '@',
							placeholder : '@',
							required : '=ngRequired',
							alertMessage : '@'
						},
						link : {
							post : function($scope, $element, $attrs, $formCtrl) {
//								console.log($($element[0]).find('div')[0]);
								$scope.onlyNumbers = /^\d+$/;
								$scope.formatChk = true;
								$scope.minPrice = true;
								$scope.termPrice = true;
								$scope.limitPrice = true;
								$scope.alertData = {};
								if($attrs.required) 
									$scope.alertData.content = $attrs.alertMessage;
								if($attrs.priceCheck){
									$scope.alertData.min_price = $attrs.minMessage;
									$scope.alertData.term_price = $attrs.termMessage;
									$scope.alertData.limit_price = $attrs.limitMessage;
								}
								$scope.alertData.format = $attrs.formatMessage;
								
								$element.off().on('focusout', function(){
									if ($attrs.required) {
										if($element.find('input').val() == ''){
											$element.find('input').attr('title', $scope.alertData.content);
											$element.find('input').attr('data-original-title', $scope.alertData.content);
											$($element).find('[data-toggle="tooltip"]').tooltip('show');
										} else {
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-error').addClass('has-success');
										}
									}
									
									if($element.find('input').val() != '' && !$scope.formatChk){
										if(!$scope.formatChk){
											$element.find('input').attr('title', $scope.alertData.format);
											$element.find('input').attr('data-original-title', $scope.alertData.format);
											$($element).find('[data-toggle="tooltip"]').tooltip('show');
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-success').addClass('has-error');
											$scope.$apply(function(){
												$formCtrl.$invalid = true;
												$formCtrl.$valid = false;
											});
										} else {
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-error').addClass('has-success');
										}
									}
									
									if($element.find('input').val() != '' && $scope.formatChk){
										if(!$scope.minPrice){
											$element.find('input').attr('title', $scope.alertData.min_price);
											$element.find('input').attr('data-original-title', $scope.alertData.min_price);
											$($element).find('[data-toggle="tooltip"]').tooltip('show');
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-success').addClass('has-error');
											$scope.$apply(function(){
												$formCtrl.$invalid = true;
												$formCtrl.$valid = false;
											});
										} else if(!$scope.termPrice){
											$element.find('input').attr('title', $scope.alertData.term_price);
											$element.find('input').attr('data-original-title', $scope.alertData.term_price);
											$($element).find('[data-toggle="tooltip"]').tooltip('show');
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-success').addClass('has-error');
											$scope.$apply(function(){
												$formCtrl.$invalid = true;
												$formCtrl.$valid = false;
											});
										} else if(!$scope.limitPrice){
											$element.find('input').attr('title', $scope.alertData.limit_price);
											$element.find('input').attr('data-original-title', $scope.alertData.limit_price);
											$($element).find('[data-toggle="tooltip"]').tooltip('show');
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-success').addClass('has-error');
											$scope.$apply(function(){
												$formCtrl.$invalid = true;
												$formCtrl.$valid = false;
											});
										} else {
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-error').addClass('has-success');
										}
									}
								}).on('focusin', function(){
									$(this).find('[data-toggle="tooltip"]').tooltip('hide');
								}).on('keypress', function(){
									$scope.$watch('value', function(){
										/*if($attrs.formated){
											var chkeck = /^[0-9]*$/;
											if(!chkeck.test($element.find('input').val())){
												$scope.formatChk = false;
											} else {
												$scope.formatChk = true;
											}
											console.log($scope.formatChk);
										}*/
										var check = /^[0-9]*$/;
										if(!check.test($element.find('input').val())){
											$scope.formatChk = false;
										} else {
											$scope.formatChk = true;
										}
										
//										console.log('value : '+$element.find('input').val());
										if($element.find('input').val() < 50000){
											$scope.minPrice = false;
										} else if((($element.find('input').val() *1) % 10000) != 0){
											$scope.termPrice = false;
										} else if($element.find('input').val() *1 > 10000000){
											$scope.limitPrice = false;
										} else {
											$scope.minPrice = true;
											$scope.termPrice = true;
											$scope.limitPrice = true;
										}
//										console.log('minPrice : '+$scope.minPrice);
									});
								});
								
								$scope.form = $formCtrl;
								if (!$attrs.required) {
									$element.find('span').remove();
									$element.find('input').remove();
									var input = '<input type="text" name="{{fieldName}}" placeholder="{{placeholder}}" class="form-control" ng-model="value">';
									var ln = $compile(input);
									var content = ln($scope);
									$element.append(content);
								}
							}

						}
					}
				})
		.directive(
				'aonInputEmail',
				function($compile, $rootScope) {
					return {
						template : '<div class="has-feedback" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }">\
							<input type="email" class="form-control" placeholder="{{placeholder}}" ng-model="value" ng-required="{{required}}" \
							name="{{fieldName}}" data-toggle="tooltip" title="{{alertMessage}}" ng-pattern="chkEmail" >\
							<span class="glyphicon glyphicon-ok form-control-feedback"></span>\
							</div>',
						restrict : "AE",
						require : '^form',
						scope : {
							value : '=ngModel',
							fieldName : '@',
							placeholder : '@',
							required : '=ngRequired',
							alertMessage : '@'
						},
						link : {
							post : function($scope, $element, $attrs, $formCtrl) {
								$scope.alertData = {};
								$scope.alertData.content = $attrs.alertMessage;
								$scope.alertData.format = $attrs.formatMessage;
								$scope.alertData.duplicate = $attrs.duplicatedMessage;
								$scope.emailChk = true;
								$scope.chkEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
								$scope.responsePromise = '';

								$element.off().on('focusout', function(){
									if($element.find('input').val() == ''){
										$element.find('input').attr('title', $scope.alertData.content);
										$element.find('input').attr('data-original-title', $scope.alertData.content);
										$(this).find('[data-toggle="tooltip"]').tooltip('show');
									} else if($element.find('input').val() != ''){
										if($attrs.formated){
											if(!$scope.chkEmail.test($element.find('input').val())){
												$element.find('input').attr('title', $scope.alertData.format);
												$element.find('input').attr('data-original-title', $scope.alertData.format);
												$(this).find('[data-toggle="tooltip"]').tooltip('show');
												var tmp = $($element[0]).find('div')[0];
												$(tmp).removeClass('has-success').addClass('has-error');
												$scope.emailChk = false;
											}
										}
										if($attrs.exchanged && $scope.emailChk){
											//if(!$rootScope.chkDuplicate($element.find('input').val(), $attrs.exchangedType)){
											$rootScope.chkDuplicate($element.find('input').val(), $attrs.exchangedType);
											$rootScope.responsePromise.success(function(data){
												if(data.emailCnt != 0){
													$element.find('input').attr('title', $scope.alertData.duplicate);
													$element.find('input').attr('data-original-title', $scope.alertData.duplicate);
													//$(this).find('[data-toggle="tooltip"]').tooltip('show');
													$($element).find('[data-toggle="tooltip"]').tooltip('show');
													var tmp = $($element[0]).find('div')[0];
													$(tmp).removeClass('has-success').addClass('has-error');
												}
											});
											/*console.log($scope.dup);
											if(!$scope.dup || $scope.dup == undefined){
												$element.find('input').attr('title', $scope.alertData.duplicate);
												$element.find('input').attr('data-original-title', $scope.alertData.duplicate);
												//$(this).find('[data-toggle="tooltip"]').tooltip('show');
												$($element).find('[data-toggle="tooltip"]').tooltip('show');
												var tmp = $($element[0]).find('div')[0];
												$(tmp).removeClass('has-success').addClass('has-error');
											}*/
										}
									}
								}).on('focusin', function(){
									$(this).find('[data-toggle="tooltip"]').tooltip('hide');
								}).on('keypress', function(){
									/*$scope.$watch('value', function(){
										if($element.find('input').val().length > 5){
											chkDuplicate($element.find('input').val(), $attrs.exchangedType);
										}
									});*/
									/*$scope.$watch('value', function(){
										if(!$scope.chkEmail.test($element.find('input').val())){
											$scope.emailChk = false;
										} else {
											$scope.emailChk = true;
										}
									});*/
								});
								
								function chkDuplicate(value, type){
									$scope.responsePromise = $http({
										method : 'POST',
										url : jcontext.getCsrfPath('/sys/member/duplicateEmailCheck.json'),
										data : $.param({email : value}),
										headers: {'Content-Type': 'application/x-www-form-urlencoded'}
									});
									/*.success(function(data){
										console.log(data);
										return function(data){
											console.log('emailCnt : ' + data.emailCnt);
											if(data.emailCnt == 0){
												console.log('1');
												$scope.dup = true;
											}else{
												console.log('0');
												$scope.dup = false;
											}
										}
									});*/
								}
								
								$scope.form = $formCtrl;
								if (!$attrs.required) {
									element.find('span').remove();
									element.find('input').remove();
									var input = '<input type="email" name="{{fieldName}}" placeholder="{{placeholder}}" class="form-control" ng-model="value">';
									var ln = $compile(input);
									var content = ln(scope);
									element.append(content);
								}
							}

						}
					}
				})
		.directive(
				'aonInputPhone',
				function($compile, $rootScope) {
					return {
						template : '<div class="has-feedback" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }">\
							<input type="text" class="form-control" placeholder="{{placeholder}}" ng-model="value" ng-required="{{required}}" \
							name="{{fieldName}}" data-toggle="tooltip" title="{{alertMessage}}" ng-maxlength="{{maxlength}}" ng-pattern="onlyNumbers">\
							<span class="glyphicon glyphicon-ok form-control-feedback"></span>\
							</div>',
						restrict : "AE",
						require : '^form',
						scope : {
							value : '=ngModel',
							fieldName : '@',
							placeholder : '@',
							required : '=ngRequired',
							alertMessage : '@'
						},
						link : {
							post : function($scope, $element, $attrs, $formCtrl) {
								$scope.form = $formCtrl;
								if (!$attrs.required) {
									$element.find('span').remove();
									$element.find('input').remove();
									var input = '<input type="text" name="{{fieldName}}" data-toggle="tooltip" title="{{alertMessage}}" placeholder="{{placeholder}}" class="form-control" ng-model="value">';
									var ln = $compile(input);
									var content = ln($scope);
									$element.append(content);
								}
								
								//$scope.onlyNumbers = /^\d+$/;
								$scope.onlyNumbers = /^[0-9]*$/;
								$scope.alertData = {};
								$scope.formatChk = true;
								if($attrs.required) 
									$scope.alertData.content = $attrs.alertMessage;
								if($attrs.formated) 
									$scope.alertData.format = $attrs.formatMessage;
								if($attrs.exchanged){
									$scope.alertData.duplicate = $attrs.duplicatedMessage;
								}
								
								$element.off().on('focusout', function(){
									if ($attrs.required) {
										if($element.find('input').val() == ''){
											$element.find('input').attr('title', $scope.alertData.content);
											$element.find('input').attr('data-original-title', $scope.alertData.content);
											$(this).find('[data-toggle="tooltip"]').tooltip('show');
										}
									}
									
									if($element.find('input').val() != ''){
										if(!$scope.formatChk){
											$element.find('input').attr('title', $scope.alertData.format);
											$element.find('input').attr('data-original-title', $scope.alertData.format);
											$(this).find('[data-toggle="tooltip"]').tooltip('show');
										}
									}
										
									if($element.find('input').val() != '' && $scope.formatChk && $attrs.exchanged){
										if(!$rootScope.chkDuplicate($element.find('input').val(), $attrs.exchangedType)){
											$element.find('input').attr('title', $scope.alertData.duplicate);
											$element.find('input').attr('data-original-title', $scope.alertData.duplicate);
											$(this).find('[data-toggle="tooltip"]').tooltip('show');
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-success').addClass('has-error');
										}
									}
								}).on('focusin', function(){
									$(this).find('[data-toggle="tooltip"]').tooltip('hide');
								}).on('keypress', function(){
									$scope.$watch('value', function(){
										var check = /^[0-9]*$/;
										if(!check.test($element.find('input').val())){
											$scope.formatChk = false;
										} else {
											$scope.formatChk = true;
										}
									});
								});
							}
						}
					}
				})
		.directive(
				'aonImageFile',[ '$timeout',  
				function($timeout) {
					return {
						template : '<input type="file" name="imgfile" class="file" data-show-preview="false" data-show-upload="false">',
						restrict : "AE",
						require : '^form',
						scope : {
							value : '=ngModel',
							fieldName : '@'
						},
						link : {
							post : function($scope, $element, $attrs, $formCtrl) {
								$scope.form = $formCtrl;
								$scope.$on('SUBMIT', function(e) {
									if($element.find('input').val()){
										$element.append('<input type="hidden" name="'+$attrs.fieldName+'.filename" value="'+jcontext.getFileName($element.find('input').val()) +'">');
										$element.append('<input type="hidden" name="'+$attrs.fieldName+'.path" value="imgfile">');	
										$element.append('<input type="hidden" name="'+$attrs.fieldName+'.type" value="1">');						
										$element.append('<input type="hidden" name="'+$attrs.fieldName+'.method" value="copy">');
									}

								}); 
								
								//$rootScope.file.filename = jcontext.getFileName($element.find('input').val());
								//$rootScope.file.path = 'imgfile';
								//$rootScope.file.type = '1';
								//$rootScope.file.method = 'copy';
								//// 그려진 후에 호출되어야한다.
								/*$timeout(function() {
										
								}, 0);*/
								$element.ready(function(){
									var $input = $('input.file[type=file]');
							        if ($input.length) {
							            $input.fileinput();
							        }
								});
							}

						}
					}
				}])
		.directive(
				'aonDatePicker',[ '$cookies','$filter','$timeout',
				function($cookies,$filter,$timeout) {
					return {
						template : '<div class="input-group date datetimepicker fm_type200 has-feedback" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }" id="datepicker">\
									<input type="text" ng-required="{{required}}" class="form-control" data-toggle="tooltip" title="" readonly>\
									<span class="input-group-addon">\
										<button type="button" class="btn default btn_calendar">\
                               <span class="glyphicon glyphicon-calendar"></span>\
                            </button>\
                        </span>\
                    </div><input type="hidden" name="{{fieldName}}" value="{{date}}"/>',
						restrict : "AE",
						require :  [ '^form', 'ngModel' ],
						scope : {
							value : '=ngModel',
							fieldName : '@',
							date : '@',
							required: '=ngRequired'
						},
						link : {
							post : function($scope, $element, $attrs, $required) {
								$scope.form = $required[0];
								var format =  jcontext.dateFormat($cookies);
								var model = $required[1];
								
								$scope.alertData = {};
								$scope.alertData.contentMessage = i18n.getLang('common', 'dateNullMent');
								//angularjs와 datepicker 의 표현식이 다름 
								//MMM dd yyyy
								var picker= $($element).find('#datepicker').datetimepicker({
							        format: format.toUpperCase() ,
							        minDate : 'now',
							        ignoreReadonly : true,
							        widgetPositioning: {
							            horizontal: 'right',
							            vertical: 'auto'
							        }
						    	}).on("dp.change",function (e) {
						    		model.$setViewValue(new Date(e.date).getTime());
						    		if($attrs.required){
						    			$($element).find('[data-toggle="tooltip"]').tooltip('hide');
						    			$($element.find('div')[0]).removeClass('has-error').addClass('has-success');
									}
						    	});
								
								if($attrs.date) {
									var _date = $filter('date')(new Date(parseInt($attrs.date)), format);
									$($element).find('#datepicker').data({date:_date});
									$($element).find('#datepicker').datetimepicker('change').children("input").val(_date);
									picker.data('DateTimePicker').date(_date);
								}
								
								$scope.$watch('value', function(newValue, oldValue) {
									if (newValue) {
										var _date = $filter('date')(new Date(newValue), format);
										$timeout(function() {
											picker.data('DateTimePicker').date(_date);
					                    });
									} else {
										$timeout(function() {
											picker.data('DateTimePicker').date(null);
											if($attrs.required){
												$($element).find('[data-toggle="tooltip"]').tooltip('hide');
												$($element.find('div')[0]).removeClass('has-success').addClass('has-error');
											}
					                    });
									}
								}, true);
								
								//init
								if($attrs.required){
									if($($element.find('input')[0]).val() == ''){
										$($element.find('input')[0]).attr('title', $scope.alertData.contentMessage);
						        		$($element.find('input')[0]).attr('data-original-title', $scope.alertData.contentMessage);
										$($element).find('[data-toggle="tooltip"]').tooltip('show');
										$($element.find('div')[0]).removeClass('has-success').addClass('has-error');
										$required[0].$invalid = true;
										$required[0].$valid = false;
									} else {
										$($element).find('[data-toggle="tooltip"]').tooltip('hide');
										$($element.find('div')[0]).removeClass('has-error').addClass('has-success');
									}
								}
							}
						}
					}
				}])
	.directive(
				'aonDatetermPicker',[ '$cookies','$filter','$timeout',
				function($cookies,$filter,$timeout) {
					return {
						template : '<div class="ads_ib">\
		                             	<div class="input-group date datetimepicker fm_type127 has-feedback" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }" id="datepicker">\
											<input type="text" ng-required="{{required}}" class="form-control no_icon" readonly id="startPicker">\
										</div>\
										<span class="cal_left">to</span>\
						                <div class="input-group date datetimepicker fm_type127 has-feedback" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }" id="datepicker">\
											<input type="text" ng-required="{{required}}" class="form-control no_icon" readonly id="endPicker" >\
										</div>\
										<input type="hidden" id="startField" name="{{startFieldName}}" ng-model="start">\
										<input type="hidden" id="endField" name="{{endFieldName}}" ng-model="end">\
									</div>',
						restrict : "AE",
						require :  [ '^form' ],
						scope : {
							startFieldName : '@',
							endFieldName : '@',
							start : '=startNgModel',
							end : '=endNgModel',
							required: '=ngRequired'
						},
						link : {
							post : function($scope, $element, $attrs, $form) {
								$scope.form = $form;
								var format =  jcontext.dateFormat($cookies);
								//var model = $required[1];
								//angularjs와 datepicker 의 표현식이 다름 
								//MMM dd yyyy
								var startPicker= $($element).find('#startPicker').datetimepicker({
							        format: format.toUpperCase() ,
							        ignoreReadonly : true,
							        widgetPositioning: {
							            horizontal: 'right',
							            vertical: 'auto'
							        }
							    }).on("dp.change",function (e) {
							    	//$($element).find('#startField').val(new Date(e.date).getTime());
							    	$scope.$apply(function () {
							    		$scope.start = new Date(e.date).getTime() == 0 ? '' : new Date(e.date).getTime();
			                        });
							    	if($scope.required){
							    		$($element.find('div')[1]).removeClass('has-error').addClass('has-success');
							    	}
							    });
								
								var endPicker = $($element).find('#endPicker').datetimepicker({
							        format: format.toUpperCase() ,
							        ignoreReadonly : true,
							        widgetPositioning: {
							            horizontal: 'right',
							            vertical: 'auto'
							        }
							    }).on("dp.change",function (e) {
							    	//$($element).find('#endField').val(new Date(e.date).getTime());
							    	$scope.$apply(function () {
							    		$scope.end = new Date(e.date).getTime() == 0 ? '' : new Date(e.date).getTime();
			                        });
							    	if($scope.required){
							    		$($element.find('div')[2]).removeClass('has-error').addClass('has-success');
							    	}
							    });

								//init
								if($scope.required){
									if($($element.find('input')[0]).val() == ''){
										$($element.find('div')[1]).removeClass('has-success').addClass('has-error');
										$($form[0]).$invalid = true;
										$($form[0]).$valid = false;
									} else {
										$($element.find('div')[1]).removeClass('has-error').addClass('has-success');
									}
									
									if($($element.find('input')[1]).val() == ''){
										$($element.find('div')[2]).removeClass('has-success').addClass('has-error');
										$($form[0]).$invalid = true;
										$($form[0]).$valid = false;
									} else {
										$($element.find('div')[2]).removeClass('has-error').addClass('has-success');
									}
								}
								
								$scope.$watch('start', function(newValue, oldValue) {
									if (newValue) {
										var _date = $filter('date')(new Date(newValue), format);
										$timeout(function() {
											startPicker.data('DateTimePicker').date(_date);
					                    });
									} else {
										$timeout(function() {
											startPicker.data('DateTimePicker').date(null);
					                    });
									}
								}, true);
								
								$scope.$watch('end', function(newValue, oldValue) {
									if (newValue) {
										var _date = $filter('date')(new Date(newValue), format);
										$timeout(function() {
											endPicker.data('DateTimePicker').date(_date);
					                    });
									} else {
										$timeout(function() {
											endPicker.data('DateTimePicker').date(null);
					                    });
									}
								}, true);
							}
						}
					}
				}])
		.directive(
				'aonPassword',
				function($compile) {
					return {
						template : '<div class="has-feedback" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }">\
					<input type="password" class="form-control" placeholder="{{placeholder}}" ng-model="value" ng-required="{{required}}" \
					name="{{fieldName}}" data-toggle="tooltip" title="{{alertMessage}}">\
					<span class="glyphicon glyphicon-ok form-control-feedback"></span>\
					</div>',
						restrict : "AE",
						require : '^form',
						scope : {
							value : '=ngModel',
							fieldName : '@',
							placeholder : '@',
							required : '=ngRequired',
							alertMessage : '@'
						},
						link : {
							post : function($scope, $element, $attrs, $formCtrl) {
								$scope.form = $formCtrl;
								
								if (!$attrs.required && !$attrs.requiredChange) {
									$element.find('span').remove();
									$element.find('input').remove();
									var input = '<input type="password" name="{{fieldName}}" placeholder="{{placeholder}}" data-toggle="tooltip" title="{{alertMessage}}" class="form-control" ng-model="value">';
									var ln = $compile(input);
									var content = ln($scope);
									$element.append(content);
								}else if (!$attrs.required && $attrs.requiredChange) {
									$element.find('input').remove();
									$element.find('span').remove();
									var div = '<div class="has-feedback"></div>';
									$($element[0]).find('div').remove();
									$($element[0]).append(div);
									
									var input = '<input type="password" name="{{fieldName}}" placeholder="{{placeholder}}" data-toggle="tooltip" title="{{alertMessage}}" class="form-control" ng-model="value" ng-required="">';
									var ln = $compile(input);
									var content = ln($scope);
									$element.find('div').append(content);
								}
								
								$scope.alertData = {};
								$scope.alertData.content = $attrs.alertMessage;
								if($attrs.lengthCheck) $scope.alertData.length = $attrs.lengthMessage;
								if($attrs.mixCheck) $scope.alertData.mix = $attrs.mixMessage;
								if($attrs.continueCheck) $scope.alertData.continued = $attrs.continueMessage;
								if($attrs.passwordCheck) $scope.alertData.passcheck = $attrs.passwordCheckMessage;
								
								var passChain = $attrs.requiredChainform;
								var parent = $($element.parent().parent().parent().parent()[0]);
								
								$element.on('focusout', function(){
									if ($attrs.required) {
										if($element.find('input').val() == ''){
											$element.find('input').attr('title', $scope.alertData.content);
											$element.find('input').attr('data-original-title', $scope.alertData.content);
											$($element).find('[data-toggle="tooltip"]').tooltip('show');
										}
									}
									
									if($attrs.requiredChange){
										if($element.find('input').val() == '' && $(parent.find('input[name='+passChain+']')).val() == ''){
											$element.find('span').remove();
											$element.find('div').removeClass('has-error').removeClass('has-success');
											$(parent.find('input[name='+passChain+']').offsetParent().removeClass('has-error').removeClass('has-success'));
											$(parent.find('input[name='+passChain+']').offsetParent().find('span').remove());
										}
									}
									
									if($element.find('input').val() != '' && $attrs.lengthCheck){
										if(!/^[a-zA-Z0-9!@#$%^&*()?_~]{4,20}$/.test($element.find('input').val())){
											$element.find('input').attr('title', $scope.alertData.length);
											$element.find('input').attr('data-original-title', $scope.alertData.length);
											$($element).find('[data-toggle="tooltip"]').tooltip('show');
											$element.find('div').removeClass('has-success').addClass('has-error');
											$scope.$apply(function(){
												$formCtrl.$invalid = true;
												$formCtrl.$valid = false;
											});
										} else {
											$element.find('div').removeClass('has-error').addClass('has-success');
										}
									}
									
									if($element.find('input').val() != '' && $attrs.mixCheck){
										var chk = 0;
								        if($element.find('input').val().search(/[0-9]/g) != -1 ) chk ++;
								        if($element.find('input').val().search(/[a-z]/ig)  != -1 ) chk ++;
								        //if($element.find('input').val().search(/[!@#$%^&*()?_~]/g)  != -1  ) chk ++;
								        if(chk < 2){
								        	$element.find('input').attr('title', $scope.alertData.mix);
											$element.find('input').attr('data-original-title', $scope.alertData.mix);
											$(this).find('[data-toggle="tooltip"]').tooltip('show');
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-success').addClass('has-error');
											
											$scope.$apply(function(){
												$formCtrl.$invalid = true;
												$formCtrl.$valid = false;
											});
								        } else {
								        	var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-error').addClass('has-success');
								        }
									}
									
									if($element.find('input').val() != '' && $attrs.continueCheck){
										if(/(\w)\1\1\1/.test($element.find('input').val())){
											$element.find('input').attr('title', $scope.alertData.continued);
											$element.find('input').attr('data-original-title', $scope.alertData.continued);
											$(this).find('[data-toggle="tooltip"]').tooltip('show');
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-success').addClass('has-error');
										} else {
											var tmp = $($element[0]).find('div')[0];
											$(tmp).removeClass('has-error').addClass('has-success');
										}
									}
									if($element.find('input').val() != '' && $attrs.passwordCheck){
										var checkForm = $attrs.passwordCheckForm;
										var password1 = $('input[name='+checkForm+']').val();
										var password2 = $element.find('input').val();
										if(password1 != password2){
											$element.find('input').attr('title', $scope.alertData.passcheck);
											$element.find('input').attr('data-original-title', $scope.alertData.passcheck);
											$(this).find('[data-toggle="tooltip"]').tooltip('show');
										}
									}
									if($element.find('input').val() != '' && $attrs.passwordCheck){
										var checkForm = $attrs.passwordCheckForm;
										var password1 = $('input[name='+checkForm+']').val();
										var password2 = $element.find('input').val();
										if(password1 != password2){
											$element.find('input').attr('title', $scope.alertData.passcheck);
											$element.find('input').attr('data-original-title', $scope.alertData.passcheck);
											$(this).find('[data-toggle="tooltip"]').tooltip('show');
										}
									}
								}).on('focusin', function(){
									$(this).find('[data-toggle="tooltip"]').tooltip('hide');
								}).on('keydown', function(){
									if($attrs.requiredChange){
										if($element.find('input') != '' && $(parent.find('input[name='+passChain+']')).val() == ''){
											$element.find('div').append('<span class="glyphicon glyphicon-ok form-control-feedback"></span>');
											$(parent.find('input[name='+passChain+']').offsetParent().addClass('has-error'));
											$(parent.find('input[name='+passChain+']').offsetParent().append('<span class="glyphicon glyphicon-ok form-control-feedback"></span>'));
										}
									}
								});
							}

						}
					}
				})
			.directive(
				'aonBeforePassword',
				function($compile) {
					return {
						template : '<div class="has-feedback">\
					<input type="password" class="form-control" placeholder="{{placeholder}}" ng-model="value" ng-required="{{required}}" ng-pattern="passwordPattern" \
					name="{{fieldName}}" data-toggle="tooltip" title="{{alertMessage}}">\
					<span class="glyphicon glyphicon-ok form-control-feedback"></span>\
					</div>',
						restrict : "AE",
						require : '^form',
						scope : {
							value : '=ngModel',
							fieldName : '@',
							placeholder : '@',
							required : '=ngRequired',
							alertMessage : '@'
						},
						link : {
							post : function($scope, $element, $attrs, $formCtrl) {
								
								$scope.isValid = function(){
									var inputValue = $element.find('input').val();
									if($attrs.mixCheck){
										$scope.passwordPattern = new RegExp('^(?=.*[a-zA-Z])(?=.*\\d).{' + $attrs.min + ',' + $attrs.max + '}$');
										//$scope.passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d).{4,20}$/;
										if($attrs.lengthCheck){
											var inputValLength = inputValue.length;
											if(inputValLength < $attrs.min || inputValLength > $attrs.max){
												//$scope.passwordPattern = new RegExp('^.{' + $attrs.min + ',' + $attrs.max + '}$');
												console.log('length Check');
												$element.find('input').attr('title', $attrs.lengthMessage);
												$element.find('input').attr('data-original-title', $attrs.lengthMessage);
												return false;
											}
										}
										
										if(!$scope.passwordPattern.test(inputValue)){
											console.log('mix Check');
								        	$element.find('input').attr('title', $attrs.mixMessage);
											$element.find('input').attr('data-original-title', $attrs.mixMessage);
								        	return false;
										}
									}
									return true;
								}
								$scope.isValid();
								
								$element.on('keyup', function(){
									if(!$scope.isValid()){
										$element.find('div').removeClass('has-success').addClass('has-error');
									}else{
										$element.find('div').removeClass('has-error').addClass('has-success');
									}
								}).on('focusin', function(){
									$($element).find('[data-toggle="tooltip"]').tooltip('hide');
								}).on('focusout', function(){
									if(!$scope.isValid()){
										$($element).find('[data-toggle="tooltip"]').tooltip('show');
									}else{
										$($element).find('[data-toggle="tooltip"]').tooltip('hide');
									}
								});
							}
						}
					}
				})				
		.directive(
				'aonTextarea',
				function() {
					return {
						template : '<textarea class="form-control" \
					          ng-model="value"\
					   		  name="{{fieldName}}" placeholder="{{placeholder}}" rows="7" data-toggle="tooltip" title="{{alertMessage}}"></textarea>',
						restrict : "AE",
						require : '^form',
						scope : {
							value : '=ngModel',
							fieldName : '@',
							placeholder : '@',
							alertMessage : '@'
						},
						link : {
							pre : function($scope, $element, $attrs, $formCtrl) {
								// publish the FormController to the scope - so
								// we don't
								// need to mess around with the parent scope.
								$scope.form = $formCtrl;
							},
							post : function(scope, element, attrs, $formCtrl) {
								scope.form = $formCtrl;
								
								$(element).find('textarea').off().on('focusout', function(){
									if($(this).val() == ''){
										$(element).find('[data-toggle="tooltip"]').tooltip('show');
									}
								}).on('focusin', function(){
//									console.log('focusin');
									$(element).find('[data-toggle="tooltip"]').tooltip('hide');
								});
							}
						}
					}
				})
		.directive(
				'aonFiles',
				[
						'$timeout',
						function($timeout) {
							return {
								template : '<div class="form-grup">\
								    <div>\
								      <table style="padding:0;width:100%;table-layout:fixed;">\
								 		<tr>\
								   	 	  <td width="*">\
								   	 	  	<select multiple class="form-control" id="{{fieldName}}"></select>\
								   	 	  </td>\
								   	 	  <td width="103px" valign="top" style="padding-left:12px;">\
								       	 	 <div id="{{fieldName}}File">\
												<span class="btn btn-primary" style="position:relative; width:91px; overflow:hidden;">{{insertButtonLabel}}\
													<input type="file" class="pointer" style="position:absolute; top:0; right:0; height:100%; opacity:0; filter: alpha(opacity=0);" onclick="angular.element(this).scope().files.doClickFile()"\
				 									onchange="angular.element(this).scope().files.doAddFile(this)"/>\
												</span>\
								  			</div>\
								  			<button type="button" class="btn btn-primary" style="width:91px;" onclick="angular.element(this).scope().files.doDelete();">\
											{{deleteButtonLabel}}</button>\
									   </td>\
								     </tr>\
								   </table>\
								  </div>\
								 </div>',
								restrict : "AE",
								require : '^form',
								scope : {
									value : '=ngModel',
									fieldName : '@',
									insertButtonLabel : '@',
									deleteButtonLabel : '@'
								},
								link : {
									pre : function($scope, $element, $attrs,$formCtrl) {
										$scope.form = $formCtrl;
										$scope.files = new Attachment(
												$attrs.fieldName);
										$scope.$on('SUBMIT', function(e) {
											$scope.files.doSubmit($('#'+ $scope.fieldName+ 'File'));
										});
										// 그려진 후에 호출되어야한다.
										$timeout(
												function() {
													$scope.files.doAddServerFile($scope.value);
												}, 0);
									}
								}
							}
						} ])
		.directive('script', function() {
			return {
				restrict : 'E',
				scope : false,
				link : function(scope, elem, attr) {
					if (attr.type === 'text/javascript-lazy') {
						var s = document.createElement("script");
						s.type = "text/javascript";
						var src = elem.attr('src');
						if (src !== undefined) {
							s.src = src;
						} else {
							var code = elem.text();
							s.text = code;
						}
						document.head.appendChild(s);
						elem.remove();
					}
				}
			};
		})
		.directive(
				'aonEditor',
				function() {
					return {
						template : '<div class="form-group" data-toggle="tooltip" title="{{alertMessage}}">\
						   <textarea  class="form-control" \
						          ng-model="value" ng-required="{{required}}" \
						   		  name="{{fieldName}}" placeholder="{{placeholder}}"></textarea>\
						</div>',
						restrict : "AE",
						require : [ '^form', '?ngModel' ],
						scope : {
							value : '=ngModel',
							fieldName : '@',
							placeholder : '@',
							required : '=ngRequired',
							alertMessage : '@'
						},
						link : function(scope, elm, attr, req) {
							var ta = elm.find('textarea')[0];
							var help = elm.find('p');
							var ck = CKEDITOR.replace(ta,
											{
												customConfig : jcontext.getLocationPath("/resources/js/directives/config.js"),
												language : "en_US",
												enterMode : '1',
												shiftEnterMode:'2'
											});

							scope.form = req[0];
							var ngModel = req[1];
							if (!ngModel)
								return;
							ck.on('instanceReady', function() {
								ck.setData(ngModel.$viewValue);
							});
							function updateModel(flg) {
								scope.$apply(function() {
									ngModel.$setViewValue(ck.getData());
									if (ck.getData().length == 0) {
										$(help[0]).removeClass('ng-hide')
												.addClass('ng-show');
									} else {
										$(help[0]).addClass('ng-hide')
												.removeClass('ng-show');
									}
								});
								
								if(ck.getData() != ''){
									$(elm).find('[data-toggle="tooltip"]').tooltip('hide');
								}
							}
							function change(e) {
								scope.$apply(function() {

								});
							}
							ck.on('change', updateModel);
							ck.on('key', updateModel);
							ck.on('dataReady', updateModel);
							ck.on('blur', updateModel);
							// ck.on('focus', updateModel);
							ck.on('focus', function(){
								if(ck.getData() == ''){
									$(elm).find('[data-toggle="tooltip"]').tooltip('show');
								} else {
									$(elm).find('[data-toggle="tooltip"]').tooltip('hide');
								}
							});
							
							ngModel.$render = function(value) {
								ck.setData(ngModel.$viewValue);
							};
							
							/*elm.ready(function () {
								$('[data-toggle="tooltip"]').tooltip('show');
							});*/
						}
					};
				})
		.directive('aonBtnModalOpen',
				function(){
					return {
						template : '<button type="button" data-toggle="modal" data-target="{{modalId}}" class="{{btnClass}}">{{fieldText}}</button>',
						scope : {
							fieldText : '@',
							modalId : '@',
							btnClass : '@'
						}
					}
				})
		.directive('aonBtnModalConfirm',
				function(){
					return {
						template : '<button type="button" data-toggle="modal" data-target="{{modalId}}" class="{{btnClass}}">{{fieldText}}</button>\
									<div class="modal fade confirm" id="confirm" tabindex="-1" aria-hidden="true">\
										<div class="modal-dialog">\
											<div class="modal-content">\
												<div class="modal-body center">\
									                <p class="modalTxt1">{{confirmText}}</p>\
									            </div>\
									            <div class="modal-footer">\
									                <button type="button" class="btn green" id="btnOk" data-dismiss="modal">'+i18n.getLang('common','yes')+'</button>\
									                <button type="button" class="btn dark btn-outline" data-dismiss="modal">'+i18n.getLang('common','no')+'</button>\
									            </div>\
									        </div>\
									    </div>\
									</div>',
						scope : {
							fieldText : '@',
							modalId : '@',
							btnClass : '@',
							confirmText : '@',
							callback : '&confirmCallback'
						},
						link : function(scope, element, attrs){
							$(element).find('#btnOk').off().on('click', function(){
								scope.callback();
							});
						}
					}
				})
		.directive('aonSelectReq',
				function($rootScope){
					return {
						restrict : "A",
						link : function(scope, element, attrs){
							if(attrs.fnChk){
								$(element).on('change', function(){
									fnChk(attrs.fnChk);
								});
								
								element.ready(function(){
									if($(element).val() != ''){
										$(element.parent()).removeClass('has-error').addClass('has-success');
									}
								});
							}

							if(attrs.aonRequired){
								if(element.hasClass('ng-empty')){
									$(element.parent()).removeClass('has-success').addClass('has-error');
								} else {
									$(element.parent()).removeClass('has-error').addClass('has-success');
								}
								
								element.on('change', function(){
									if($(element).val() == ''){
										$(element.parent()).removeClass('has-success').addClass('has-error');
									} else {
										$(element.parent()).removeClass('has-error').addClass('has-success');
									}
								});
							}
						}
					}			
				})
		.directive('aonPhonenumberSend',
				function($rootScope){
					return {
						template : '<span class="check_rs has-error">\
							{{phoneNum}}\
							</span>\
							<button type="button" class="btn btn-default num_open">'+i18n.getLang('common','authNum')+' <span class="check_fd"> '+i18n.getLang('common','sent')+'</span></button>\
							<span class="txt_etc block">'+i18n.getLang('common','registMent')+'</span>\
							<div class="phone_check" ng-class="{ \'has-error\' : form[number].$invalid, \'has-success\' : form[number].$valid }">\
							<p class="blue normal">'+i18n.getLang('common','sentMent')+'<br>\
								'+i18n.getLang('common','cautionMent')+'</p>\
							<span class="check_rs">\
							<aon-input-text ng-model="member.phonenumber" field-name="number" field_id="chkNumber"  placeholder="'+i18n.getLang('common','holdMent')+'" ng-required="true" alert-message="'+i18n.getLang('common','requiredMent')+'"></aon-input-text>\
							</span>\
							<button type="button" class="btn btn-default" id="btnChk">'+i18n.getLang('common','ok')+'</button>\
							<span>\
								'+i18n.getLang('common','remainTime')+' <span id="time_remaining">3:00</span>\
	                        </span>\
							</div>\
							<div class="phone_check_true" style="display:none;">\
							<p class="blue normal">'+i18n.getLang('common','authMent')+'</p>\
	                        </div>',
						restrict: "AE",
						require : '^form',
						scope:{
							value : '=ngModel',
							phoneNum : '@',
							chkNumber : '@',
							callbackSend : '&aonCallbackSend',
							callbackAuth : '&aonCallbackAuth'
						},
						link : function(scope, element, attrs, formCtrl){
							scope.timeChk = true;
							scope.numberChk = true;
							$(element).find('.num_open').on('click', function(){
								//if(sendNum($(element).find('#phoneNumber').val())){
								if(scope.callbackSend()){
									$(element).find('.phone_check').css('display', 'block');
									$(element).find('#chkNumber').val('');
									$(element).find('[data-toggle="tooltip"]').tooltip('hide');
									//$(element).find('#phoneNumber').parent().removeClass('has-error').removeClass('has-success');
									//$(element).find('#btnChk').parent().removeClass('has-success').addClass('has-error');
									if(my_set){
										clearInterval(my_set);
									}
									myTimer(179);
								}
							});
							
							$(element).find('#btnChk').off().on('click', function(){
								$rootScope.chkNumber = $(element).find('#chkNumber').val();
								if(!scope.callbackAuth()) {
									$(element).find('input').attr('title', attrs.authMessage);
									$(element).find('input').attr('data-original-title', attrs.authMessage);
									$(element).find('[data-toggle="tooltip"]').tooltip('show');
									var tmp = $(element[0]).find('div')[0];
									$(tmp).removeClass('has-success').addClass('has-error');
									//$(this).parent().addClass('has-error');
								} else {
									$(element).find('.phone_check').hide();
									$(element).find('.phone_check_true').show();
									$(element).find('[data-toggle="tooltip"]').tooltip('hide');
									if(my_set){
										clearInterval(my_set);
									}
									var tmp = $(element[0]).find('div')[0];
									$(tmp).removeClass('has-error').addClass('has-success');
									//$(element).find('#phoneNumber').parent().addClass('has-success');
								}
							});
							
							$(element).find('#chkNumber').off().on('focusin', function(){
								/*$(this).val('');
								$(element).find('[data-toggle="tooltip"]').tooltip('hide');
								$(element).find('#btnChk').parent().removeClass('has-success');*/
							});
							
							var my_set = '';
							var myTimer=function(set_number){
								var my_timer =function(){
									var minStr = parseInt(set_number / 60);
									var secStr = parseInt(set_number % 60);
									if(secStr < 10){
										secStr = '0' + secStr;
									}
									if(set_number == 0){
										$(element).find('#time_remaining').text('0'+minStr+':'+secStr);
										clearInterval(my_set);
										scope.timeChk = false;
//										console.log('인증번호 입력 시간이 초과되었습니다.인증번호 발송 과정부터 다시 시작해 주세요.');
									} else {
										$(element).find('#time_remaining').text(minStr+':'+secStr);
										set_number--;
									}
								};
								
								var my_timer_clear = function(){
									clearInterval(my_set);
								};

								my_set=setInterval(my_timer, 1000);
							}
							
							
						}
					}
				})
		.filter('Adate',
				function($filter, $cookies) {
					return function(input) {
						if (input == null) {
							return "";
						}
						var format =  jcontext.dateFormat($cookies);
						var _date = $filter('date')(new Date(input), format);

						return _date;

					};
				})
		.filter('AdateTime',
				function($filter, $cookies) {
					return function(input) {
						if (input == null) {
							return "";
						}
						var format =  jcontext.dateFormat($cookies);
						var _date = $filter('date')(new Date(input), format + ' hh:mm:ss');

						return _date;

					};
				})
		.filter('Apoint',
				function($filter, $cookies) {
					return function(input) {
						if (input == null) {
							return "";
						}
						var locale = jcontext.getLocale($cookies);
						var _currency = $filter('currency') (input, "", 0);
						return _currency;
					};
				})
		.filter('nl2br',
				function($sce){
					return function(text){
						if(text) return $sce.trustAsHtml(text.replace(/\n/g, '<br>'));
					}
				})
		.filter('cyberAccNum',
				function(){
					return function(text) {
						if (!text) return '';
						
						var cyberAccNum;
						cyberAccNum = text.slice(0,3) + "-" + text.slice(3,7) + "-" + text.slice(7,11) + "-" + text.slice(11);
						return cyberAccNum;
					}
				});

angular.module('aon.input.directives')
.directive("aonSelectTree",['$timeout',function($timeout) {
	return {
		template : '<select  class="form-control" name="{{fieldName}}"></select>',
		restrict : "AE",
		require : [ '^form', 'ngModel' ],
		scope : {
			value : '=ngModel',
			fieldName : '@',
			multi : '@',
			selected :'@'
		},
		link : {
			post : function($scope, $element, $attrs, req) {
				$scope.form = req[0];
				var ngModel = req[1];

	            var render = function(){            
	               // console.log('modelValue:', ngModel.$modelValue);
	                var data = ngModel.$modelValue;
	                if(data)
	                {
	                	
	                	data.forEach(
		                	function(e,index,a){
		                		var option = $('<option>', {
		                		    'value': e.id,
		                		    'text': e.name,
		                		    'data-parent' : e.parentId,
		                		    'leaf' : e.flagCode
		                		});
		                			
		                			$element.find('select').append(option);
		                		if ($attrs.selected==e.id){
		                			option.attr("selected","selected");
		                		}
		                	}		
	                	);
	                	 var options = {
	                		        buttontext: i18n.getLang('common','doSelect'),
	                		    };
	                	$($element.find('select')).treeselect(options);
	                	
	                }
	            
	            };
	            $scope.$watch(ngModel, render);
	            render();   
			}
		}
	}
}])
.directive('treeModel', function($compile) {
        return {
            restrict: 'A', //다이렉티브는 속성으로 인지한다.
            link: function ( scope, element, attrs ) {
                //트리 모델
                var treeModel = attrs.treeModel;

                //노드 아이디
                var nodeId = attrs.nodeId || 'id';

                //노드 라벨
                var nodeLabel = attrs.nodeLabel || 'label';

                //자식 노드들
                var nodeChildren = attrs.nodeChildren || 'children';

                //트리 템플릿. 이 템플릿 내에 data-tree-model 다이렉티브가 다시 존재하는 형태로 재귀호출이 구현된다.
                var template =
                    '<ul>' +
                    '<li data-ng-repeat="node in ' + treeModel + '">' +
                    '<i class="collapsed" data-ng-show="node.' + nodeChildren + '.length && !node.collapsed" data-ng-click="selectNodeHead(node)"></i>' +
                    '<i class="expanded" data-ng-show="node.' + nodeChildren + '.length && node.collapsed" data-ng-click="selectNodeHead(node)"></i>' +
                    '<i class="normal" data-ng-hide="node.' + nodeChildren + '.length"></i> ' +
                    '<span data-ng-class="node.selected" data-ng-click="selectNodeLabel(node)">{{node.' + nodeLabel + '}}</span>' +
                    '<div data-ng-show="node.collapsed" data-tree-model="node.' + nodeChildren + '" data-node-id=' + nodeId + ' data-node-label=' + nodeLabel + ' data-node-children=' + nodeChildren + '></div>' +
                    '</li>' +
                    '</ul>';

                //트리 모델명을 HTML 태그의 속성으로 입력했는지 체크
                if( treeModel && treeModel.length ) {

                    //data-angular-treeview 속성이 있으면 루트 노드이고,
                    //루트 노드일 때에만 클릭 이벤트 처리 메서드를 선언한다.
                    if( attrs.angularTreeview ) {

                        //노드의 아이콘 부분(노드 헤드)을 클릭했을 때,
                        scope.selectNodeHead = scope.selectNodeHead || function( selectedNode ){

                                //collapsed값을 토글해 준다.
                                selectedNode.collapsed = !selectedNode.collapsed;
                            };

                        //노드의 이름 부분(노드 라벨)을 클릭했을 때
                        scope.selectNodeLabel = scope.selectNodeLabel || function( selectedNode ){

                                //기존에 선택되어 있던 노드의 하이라이팅 클래스를 제거해주고,
                                if( scope.currentNode && scope.currentNode.selected ) {
                                    scope.currentNode.selected = undefined;
                                }

                                //현재 선택한 노드에 하이라이팅 클래스를 설정해 준다.
                                selectedNode.selected = 'selected'

                                //현재 선택한 노드를 $scope.currentNode 에 넣어준다.
                                scope.currentNode = selectedNode;
                            };
                    }

                    //템플릿을 렌더링해서 뿌려준다.
                    element.html(null).append( $compile( template )( scope ) );
                }
            }
        };
    })
.directive('aonBtn', function($compile){
	return {
		restrict : 'AE',
		scope : {
			btnText : '@',
			btnHref : '@',
			callback : '&btnCallback',
			btnColor : '@',
			btnSize : '@',
			btnType : '@',
			btnBlock : '@'
		},
		template : '<button class="btn" type="button">{{btnText}}</button>',
		link : function(scope, element, attrs){
			if (attrs.btnType == 'A') {
				$(element).find('button').remove();
				var anch = '<a class="btn" href="{{btnHref}}" role="button">{{btnText}}</a>';
				var ln = $compile(anch);
				var content = ln(scope);
				element.append(content);
			}
			
			if(attrs.btnColor){
				if (attrs.btnType == 'A') {
					$(element).find('a').addClass('btn-' + attrs.btnColor);
				} else {
					$(element).find('button').addClass('btn-' + attrs.btnColor);
				}
			} else {
				if (attrs.btnType == 'A') {
					$(element).find('a').addClass('btn-default');
				} else {
					$(element).find('button').addClass('btn-default');
				}
			}
			
			if(attrs.btnSize){
				if (attrs.btnType == 'A') {
					$(element).find('a').addClass('btn-' + attrs.btnSize);
				} else {
					$(element).find('button').addClass('btn-' + attrs.btnSize);
				}
			} else {
				if (attrs.btnType == 'A') {
					$(element).find('a').addClass('btn-default');
				} else {
					$(element).find('button').addClass('btn-default');
				}
			}
			
			if(attrs.btnBlock){
				if (attrs.btnType == 'A') {
					$(element).find('a').addClass('btn-block');
				} else {
					$(element).find('button').addClass('btn-block');
				}
			}
			
			$(element).find('button').off().on('click', function(){
				scope.callback();
			});
		}
	}
})
.directive( 'aonBank', function($compile, $rootScope) {
	return {
		template : '<div class="has-feedback" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }">\
						<input type="text" class="form-control" placeholder="{{placeholder}}" ng-model="ngModel" name="{{fieldName}}" ng-keypress="keypress" data-toggle="tooltip" title="" />\
					</div>',
		restrict : "AE",
		require : '^form',
		replace : true,
		scope : {
			ngModel : '=',
			fieldName : '@',
			placeholder : '@',
			alertMessage : '@',
			ngRequired : '='
		},
		link : {
			post : function($scope, $element, $attrs, $formCtrl) {
				$scope.alertData = {};
				$scope.alertData.content = $attrs.alertMessage;
				$element.find('input').attr('title', $scope.alertData.content);
				$element.find('input').attr('data-original-title', $scope.alertData.content);
				
				var relativeTagNames;
				if($attrs.relativeTagName){
					relativeTagNames = $attrs.relativeTagName.split(',');
				}
				
				var inputFieldCnt = relativeTagNames.length;
				var checkElement = function(){
					if(relativeTagNames){
						var inputCnt = 0;
						for(var i=0; i<inputFieldCnt; i++){
							var relativeTag = $('[name="' + relativeTagNames[i] + '"]');
							if(relativeTag.val().length > 0){
								inputCnt++;
								relativeTag.parent().removeClass('has-error').addClass('has-success');
							}else{
								relativeTag.parent().removeClass('has-success').addClass('has-error');
							}
						}
						if(inputCnt == 0){
							for(var i=0; i<inputFieldCnt; i++){
								var relativeTag = $('[name="' + relativeTagNames[i] + '"]');
								relativeTag.parent().removeClass('has-success').removeClass('has-error');
								
								if($formCtrl.$valid){
									relativeTag.parent().find('[data-toggle="tooltip"]').tooltip('hide');				
								}
							}
						}
					}
				}
				
				angular.element(document).ready(function() {
					checkElement();
	        	});
				
				$($element).on('keyup', function(){
					checkElement();
				});
				
				$element.on('focusout', function(){
					var modelValue = $formCtrl[$attrs.fieldName].$modelValue;
					if(modelValue || $formCtrl.$valid){
						$($element).find('[data-toggle="tooltip"]').tooltip('hide');				
					}else{
						$($element).find('[data-toggle="tooltip"]').tooltip('show');
					}
				}).on('focusin', function(){
					if($formCtrl.$valid){
						$($element).find('[data-toggle="tooltip"]').tooltip('hide');	
					}
				});
			}
		}
	}
})
.directive('aonInputPoint', function() {
	return {
		template: '<div>\
		<div class="has-feedback i_block" ng-class="{ \'has-error\' : form[fieldName].$invalid, \'has-success\' : form[fieldName].$valid }">\
		<input type="text" class="form-control" ng-model="ngModel" data-toggle="tooltip" title="{{alertMessage}}" ng-readonly="{{readonlyTrue}}">\
		<span class="glyphicon glyphicon-ok form-control-feedback"></span>\
		<input type="hidden" id="inputPoint" name="{{fieldName}}" />\
		</div>\
		<span id="dispCurrency" class="balck_small">{{currency | currency}}</span>\
		</div>',
		replace: true,
		restrict: 'AE',
		require: '^form',
		transclude : true,
		scope: {
			ngModel: '=',
			//ngPayments: '=',
			fieldName : '@',
			readonlyTrue: '@'
		},
		link: {
			post: function($scope, $element, $attrs, $ctrl) {
				var minPoint = parseInt($attrs.minpoint);
		        var termPoint = parseInt($attrs.termpoint);
		        var maxPoint = parseInt($attrs.maxpoint);
		        var ratio = parseInt($attrs.ratio);
		        if($attrs.isNotDisp){
		        	$($element.find('span')[1]).hide();
		        }
		        
		        var min = [minPoint];
		        var term = [termPoint];
		        var max = [maxPoint];
		        
		        $scope.minResult = true;
		        $scope.termResult = true;
		        $scope.maxResult = true;
		        
		        $scope.alertData = {};
		        $scope.alertData.contentMessage = i18n.getLang('common','pointNullMent');
		        $scope.alertData.minMessage = i18n.getLang('common','pointMinMent', min);
		        $scope.alertData.termMessage = i18n.getLang('common','pointTermMent', term);
		        $scope.alertData.maxMessage = i18n.getLang('common','pointMaxMent', max);
		        
		        $scope.$watch('ngModel', function(newValue, oldValue) {
		        	if (newValue) {
		        		$scope.ngModel = numberOnly(newValue);
		        		$scope.currency = newValue.toString().replace(/[^0-9]/gi, "") / ratio;
		        		//$scope.ngPayments = $scope.currency;
		        	} else {
		        		$scope.ngModel = '';
		        		$scope.currency = '';
		        	}
		        		
	        		var minResult, termResult, maxResult = true;
	        		
	        		if (minPoint) {
	        			$scope.minResult = checkMinPoint($scope.ngModel);
	        		}
	        		if (termPoint) {
	        			$scope.termResult = checkTermPoint($scope.ngModel);
	        		}
	        		if (maxPoint) {
	        			$scope.maxResult = checkMaxPoint($scope.ngModel);
	        		}
		        		
	        		//console.log(minResult + '/' + termResult + '/' + maxResult);
	        		if (!($scope.minResult && $scope.termResult && $scope.maxResult)) {
	        			setValid(false);
	        			var tmp = $($element[0]).find('div')[0];
						$(tmp).removeClass('has-success').addClass('has-error');
	        		} else {
	        			var tmp = $($element[0]).find('div')[0];
						$(tmp).removeClass('has-error').addClass('has-success');
	        		}
		        });
		        
		        $element.off().on('focusout', function(){
		        	if($($element.find('input')[0]).val() == ''){
		        		$($element.find('input')[0]).attr('title', $scope.alertData.contentMessage);
		        		$($element.find('input')[0]).attr('data-original-title', $scope.alertData.contentMessage);
						$($element).find('[data-toggle="tooltip"]').tooltip('show');
		        	} else if ($($element.find('input')[0]).val() != '' && !$scope.minResult) {
		        		$($element.find('input')[0]).attr('title', $scope.alertData.minMessage);
		        		$($element.find('input')[0]).attr('data-original-title', $scope.alertData.minMessage);
						$($element).find('[data-toggle="tooltip"]').tooltip('show');
		        	} else if ($($element.find('input')[0]).val() != '' && !$scope.termResult) {
		        		$($element.find('input')[0]).attr('title', $scope.alertData.termMessage);
		        		$($element.find('input')[0]).attr('data-original-title', $scope.alertData.termMessage);
						$($element).find('[data-toggle="tooltip"]').tooltip('show');
		        	} else if ($($element.find('input')[0]).val() != '' && !$scope.maxResult) {
		        		$($element.find('input')[0]).attr('title', $scope.alertData.maxMessage);
		        		$($element.find('input')[0]).attr('data-original-title', $scope.alertData.maxMessage);
						$($element).find('[data-toggle="tooltip"]').tooltip('show');
		        	} else {
		        		$scope.$apply(function(){
		        			$($element.find('input')[1]).val($($element.find('input')[0]).val().replace(/[^0-9]/gi, ""));
		        		});
		        	}
		        }).on('focusin', function(){
					$($element).find('[data-toggle="tooltip"]').tooltip('hide');
		        }).on("keydown keypress", function (event) {
		            if(event.which === 13) {
		                event.preventDefault();
		            }
		        });

		        function numberOnly(value) {
//		        	return value.replace(/[^0-9]/gi, "");
		        	tmp = value.toString().replace(/[^0-9]/gi, "");
		        	return addThousandSeparatorCommas(tmp);
		        }
		        
		        function addThousandSeparatorCommas(num) {
		        	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	        	}
		        
		        function checkMinPoint(value) {
		        	var result = false;
		        	if (value) {
		        		var intVal = parseInt(value.replace(/[^0-9]/gi, ""));
		        		if (intVal >= minPoint) {
		        			result = true;
		        		}
		        	}
		        	return result;
		        }
		        
		        function checkTermPoint(value) {
		        	var result = false;
		        	if (value) {
		        		var intVal = parseInt(value.replace(/[^0-9]/gi, ""));
		        		if (intVal % termPoint == 0) {
		        			result = true;
		        		}
		        	}
		        	return result;
		        }
		        
		        function checkMaxPoint(value) {
		        	var result = false;
		        	if (value) {
		        		var intVal = parseInt(value.replace(/[^0-9]/gi, ""));
		        		if (intVal <= maxPoint) {
		        			result = true;
		        		}
		        	}
		        	return result;
		        }

		        function setValid(result) {
		        	$ctrl.$valid = result;
		        	$ctrl.$invalid = !result;
		        }
	        }
		}
	}
});

angular.module('aon.input.directives')
.factory('safeApply', [function($rootScope) {
    return function($scope, fn) {
        var phase = $scope.$root.$$phase;
        if(phase == '$apply' || phase == '$digest') {
            if (fn) {
                $scope.$eval(fn);
            }
        } else {
            if (fn) {
                $scope.$apply(fn);
            } else {
                $scope.$apply();
            }
        }
    }
}])