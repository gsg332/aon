function jcontext() { 
}

// ////////////////////////////////////////////////////////////
// server constants
// ////////////////////////////////////////////////////////////
jcontext.CONTEXT_PATH = '';

/**
 * 도메인과 CONTEXT-PATH가 포함된 주소를 돌려준다.
 */
jcontext.getLocationPath = function(url, query) {
	return location.protocol + '//' + location.host + jcontext.getContextPath(url, query);
}
/**
 * CONTEXT-RELATIVE PATH를 돌려준다. 
 * QUERY를 추가 할 수 있다.
 */
jcontext.getContextPath = function(url, query) {
	if (!url) {
		// location.pathname은 context path와 url session을 이미 포함
		// prefix를 추가하면 안된다.
		return jcontext.suffix(location.pathname, query);
	}
	url = jcontext.suffix(url, query);
	url = jcontext.merge(url, jcontext.QUERY);
	if (url.charAt(0) != '/') {
		return url;
	}

	return jcontext.prefix(jcontext.CONTEXT_PATH, url);
}

jcontext.getCsrfPath = function (url,query){
	
	url = jcontext.suffix(url, '_csrf=@{_csrf}');
	return jcontext.getContextPath(url,query)
	
}
jcontext.suffix = function(url, query) {
	if (!query) {
		return url;
	} else if (url.indexOf('?') < 0) {
		return url + '?' + query;
	} else {
		return url + '&' + query;
	}
}
jcontext.prefix = function(root, url) {
	if (!root) return url;
	if (!url) return root;
	var rl = root.charAt(root.length - 1);
	var uf = url.charAt(0);
	if (rl == '/' && uf == '/') {
		return root + url.substring(1);
	}
	if (rl != '/' && uf != '/') {
		return root + '/' + url;
	}
	return root + url;
}
jcontext.getFileName = function (path) {
	if (path == null)
		return null;
	var i = path.lastIndexOf('\\');
	return path.substring(i + 1);
}

jcontext.merge = function(html, map) {
	var s = html;
	for(var key in map) {
		var re = new RegExp('\\@\\{' + key + '\\}', 'g');
		s = s.replace(re, map[key]);
	}
	return s;
}

jcontext.loadTEXT = function(path, query ,errorCallback) {
	var obj = null;
	var url = jcontext.getContextPath(path, query);
	jQuery.ajax({'url':url, 
			'dataType':'text', 
			'async':false, 
			'success':function(data, status) {obj = jQuery.parseJSON(data) },
			'error': function(e){
				obj = [];
				var error = jQuery.parseJSON(e.responseText);
				var md = new Modal($(document.body),{'message':error.exname,'title':'Alert','error':errorCallback});
				md.show();
			}
	});
	return obj;
}

jcontext.loadJSON = function(path, query ,errorCallback) {
	var obj = null;
	var url = jcontext.getContextPath(path, query);
	jQuery.ajax({'url':url, 
			'dataType':'json', 
			'async':false, 
			'success':function(data, status) {obj = data; },
			'error': function(e){
				obj = [];
				var error = jQuery.parseJSON(e.responseText);
				var md = new Modal($(document.body),{'message':error.exname,'title':'Alert','error':errorCallback});
				md.show();
				//console.log("code:"+e.status+"\n"+"message:"+error.exname+"\n");
			}
	});
	return obj;
}

jcontext.postJSON = function(path, object, isAlert, query) {
	var obj = null;
	var url = jcontext.getCsrfPath(path, query);
	jQuery.ajax({'url':url, 
			'dataType':'json',
			'method' : 'POST',
			'data' : object,
			'async':false, 
			'success':function(data, status) { obj = data; },
			'error': function(e){
				obj = [];
				var error = jQuery.parseJSON(e.responseText);
				//console.log("code:"+e.status+"\n"+"message:"+error.exname+"\n");
				//추후 에러부분 page alert 작성
			}
	});
	return obj;
}

jcontext.jsonAction = function(path, query ,success, fail) {
	var obj = null;
	var url = jcontext.getContextPath(path, query);
	jQuery.ajax({'url':url, 
			'processData': false,
			'contentType': false,
			'async':false, 
			'success': function(data){
				if(success.callback)
					success.callback(data);
				new PageAlert({'type':'success','title':'Notify','message':success.message});
			},
			'error': function(e){
				if(fail){
					fail.callback(e);
					new PageAlert({'type':'danger','title':'Notify','message':fail.message});
				}else{
					obj = [];
					var error = jQuery.parseJSON(e.responseText);
					var md = new Modal($(document.body),{'message':error.exname,'title':'Alert','error':function(){}});
					md.show();
				}
			}
	});
	return obj;
}

jcontext.submited = false;
jcontext.formSubmit = function(f, url, success, fail) {
	if(jcontext.submited==true){
		var md = new Modal($(document.body),{'message':'Processing..','title':'Alert','error':function(){}});
		md.show();
		return;
	}
	jcontext.submited  = true;
	var fd = new FormData(f[0]); 
	jQuery.ajax({
		'url' : jcontext.getCsrfPath(url),
		'type' : 'POST',
		'data' : fd,
		'processData': false,
        'contentType': false,
        'dataType': 'html',
		'success' : function(data) {
			if(success.callback)
				success.callback(data);
			new PageAlert({'type':'success','title':'Notify','message':success.message});
			jcontext.submited  = false;
		},
		'error': function(e){
			if(e.status == 400){
				var em = jQuery.parseJSON(e.responseText);
				jQuery.each(em.messages,function(index,message){
					 new PageAlert({'type':'danger','title':'Notify','message':message});
				});
				
			}else{
				if(fail.callback)
					fail.callback(e);
				 new PageAlert({'type':'danger','title':'Notify','message':fail.message});
			}
			jcontext.submited  = false;

		}
	});
   

}

// ////////////////////////////////////////////////////////////
// page
// ////////////////////////////////////////////////////////////
jcontext.init = function(cp,param) {
	if (cp) jcontext.CONTEXT_PATH = cp;
	jcontext.QUERY = param ? param : {};
}


jcontext.getParameter = function(name)
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars[name];
}
//////////////////
//local
///////////////
jcontext.getLocale = function($cookies) {
	var locale = $cookies.get("org.springframework.web.servlet.i18n.CookieLocaleResolver.LOCALE");
	return locale;
}
jcontext.getLocaleValue = function($cookies, json) {
	var value = json[jcontext.getLocale($cookies)];
	if(!value) value = json[$cookies.get('defaultLocale')];
	return value;
}

jcontext.getLocalesValue = function($cookies) {
	var locales = {};
	var value = $cookies.get('locales');
	value = value.substr(1, value.length - 2).split(',');
	for(var i=0; i<value.length; i ++){
		locales[i] = jQuery.trim(value[i]);
	}
	return locales;
}

jcontext.dateFormat = function($cookies){
	var locale = jcontext.getLocale($cookies);
	
	var format;
	if (locale == "ko_KR") {
		format = 'yyyy-MM-dd';
	} else {
		format = 'MMM dd yyyy';
	}
	return format;
}

function i18n(){}
i18n.lang = {};
i18n.addLang = function(module, resource) {
	i18n.lang[module] = resource;
}
i18n.getLang = function(module, key, arguments) {
	var value = (i18n.lang[module] != null) ? i18n.lang[module][key] : '@' + module + '.' + key;
	if(arguments){
		var pattern = /{[0-9]{1,}}/g;
		var matchList  = value.match(pattern);
		for(var i=0; i<arguments.length; i++){
			value = value.split('{' + i + '}').join(arguments[i]!=null?arguments[i]:matchList[i]);		
		}
	}
	return value;
}