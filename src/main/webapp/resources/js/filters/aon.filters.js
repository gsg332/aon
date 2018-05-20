angular.module('Filters', ['ngCookies'])
.filter('ctgrLang', function ($cookies, $rootScope) {
    return function (value) {
		try {
			if(value.indexOf('{') > -1 && value.indexOf('}') > -1){ //JSON 형식인지 검사 {, }가 포함되어 있는지 체크.
				return value ? jcontext.getLocaleValue($cookies, jQuery.parseJSON(value)) : null;
			}else{
				return value;
			}
		} catch (error) {
			return value;
		}
    };
})
.filter('className', function () {
    return function (value) {
		try {
			if(value.indexOf('{') > -1 && value.indexOf('}') > -1){ //JSON 형식인지 검사 {, }가 포함되어 있는지 체크.
				return value ? jQuery.parseJSON(value)['className'] : null;
			}else{
				return value;
			}
		} catch (error) {
			return value;
		}
    };
})
.filter('codeHtml', function () {
    return function (value, href) {
		try {
			//value = value.replace(/\\r\\n/g, '<br>');
			value = value.replace(/&lt;/g, '<');
			value = value.replace(/&gt;/g, '>');
			value = value.replace(/&quot;/g, '"');
			if(href){
				var _html = '';
				var _head = '';
				var _temp = '';
				var _tail = '';
				var _href = '';
				var count = value.match(/href="/g);
				if(count.length > 0){
					for (i=0; i<count.length; i++) {
						_head = value.substring(0,value.indexOf('href="')+6);
						_temp = value.substring(value.indexOf('href="')+6);
						_tail = _temp.substring(_temp.indexOf('"'));
						_href = _temp.substring(0,_temp.indexOf('"'));
						_html += _head + jcontext.getContextPath(_href);
						value = _tail;
					}
				}
				value = _html + _tail;
			}
			return value;
		} catch (error) {
			return value;
		}
    };
})
.filter('timeago', function ($filter, $cookies) {
    //time: the time
	//oneday: oneday
    //local: compared to what time? default: now
    //raw: wheter you want in a format of "5 minutes ago", or "5 minutes"
    return function (time, oneday, local, raw) {
        if (!time) return 'never';

        if (!local) {
            (local = Date.now())
        }

        if (angular.isDate(time)) {
            time = time.getTime();
        } else if (typeof time === 'string') {
            time = new Date(time).getTime();
        }

        if (angular.isDate(local)) {
            local = local.getTime();
        }else if (typeof local === 'string') {
            local = new Date(local).getTime();
        }

        if (typeof time !== 'number' || typeof local !== 'number') {
            return;
        }

        var
            offset = Math.abs((local - time) / 1000),
            span = [],
            MINUTE = 60,
            HOUR = 3600,
            DAY = 86400,
            WEEK = 604800,
            MONTH = 2629744,
            YEAR = 31556926,
            DECADE = 315569260;

        var format =  jcontext.dateFormat($cookies);
		var _date = $filter('date')(new Date(time), format);
        
        if (offset <= MINUTE)              span = [ '', raw ? i18n.getLang('time','now') : i18n.getLang('time','less') ];
        else if (offset < (MINUTE * 60))   span = [ Math.round(Math.abs(offset / MINUTE)), i18n.getLang('time','minute') ];
        else if (offset < (HOUR * 24))     span = [ Math.round(Math.abs(offset / HOUR)), i18n.getLang('time','hour') ];
        else if (oneday) return _date;
        else if (offset < (DAY * 7))       span = [ Math.round(Math.abs(offset / DAY)), i18n.getLang('time','day') ];
        else if (offset < (WEEK * 52))     span = [ Math.round(Math.abs(offset / WEEK)), i18n.getLang('time','week') ];
        else if (offset < (YEAR * 10))     span = [ Math.round(Math.abs(offset / YEAR)), i18n.getLang('time','year') ];
        else if (offset < (DECADE * 100))  span = [ Math.round(Math.abs(offset / DECADE)), i18n.getLang('time','decade') ];
        else                               span = [ '', i18n.getLang('time','long') ];

        if(jcontext.getLocale($cookies) != 'ko_KR'){
	        span[1] += (span[0] === 0 || span[0] > 1) ? 's' : '';
        }
        span = span.join(' ');
        
        if (raw === true) {
            return span;
        }
        
        if(jcontext.getLocale($cookies) == 'ko_KR'){
        	if(offset <= MINUTE){
        		return span;
        	}
        	return (time <= local) ? span + ' ' + i18n.getLang('time','ago') : span + ' ' + i18n.getLang('time','in');
        }else{
        	return (time <= local) ? span + ' ' + i18n.getLang('time','ago') : i18n.getLang('time','in') + ' ' + span;
        }
    }
});
