package com.aon.lib.i18n;

import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

@Service
public class I18nService {
     
	private static ApplicationContext ctx;
	
	@SuppressWarnings("static-access")
	@Autowired(required=true)
	public void setApplicationContext(ApplicationContext ctx){
		this.ctx = ctx;
	}
     
    public  static String getMessage(String code, Object[] args){
    	try{
    		return ctx.getMessage(code, args, LocaleContextHolder.getLocale());
    	}catch(Exception e){
    		return "Message Not Found(code="+code+")";
    	}
    }
    
    
    public static String getMessge(String code){
    	return getMessage(code,null);
    }

	public static String getMessage(String code, Object[] args, String defaultMessage) {
		return getMessage(code, null, defaultMessage,LocaleContextHolder.getLocale());
	}
	
	private static String getMessage(String code, Object[] args, String defaultMessage,Locale locale) {
		return ctx.getMessage(code, args, defaultMessage ,locale);
	}
	
	/**
	 * 시스템 기본 로케일 정보를 돌려준다.
	 * @return Locale
	 */
	public static Locale getLocale()
	{
//		try
//		{
//			Locale locale = getSessionLocale();
//			return locale == null ? getDefaultLocale() : locale;
//		}
//		catch (NullPointerException e)
//		{
			return getDefaultLocale();
//		}
	}

	/**
	 * @param locale
	 * @return
	 */
	public static Locale getLocale(String locale)
	{
		return (StringUtils.isEmpty(locale))
			? getDefaultLocale()
			: convertToLocale(locale);
	}

//	/**
//	 * 사용자 세션의 로케일 정보를 돌려준다.
//	 * @return
//	 */
//	public static Locale getSessionLocale()
//	{
//		return (Locale) UserService.getAttribute(AonLocale.LOCALE);
//	}

//	/**
//	 * 사용자세션에 로케일정보를 수정한다.
//	 * @param locale
//	 */
//	public static void setSessionLocale(String locale)
//	{
//		UserService.setLocale(getLocale(locale));
//	}

	/**
	 * 시스템 기본 로케일을 돌려준다.
	 * @return
	 */
	public static Locale getDefaultLocale()
	{
		return I18N.getDefaultLocale();
	}
	
	/**
	 * 시스템 사용가능한 로케일을 돌려준다.
	 * @return
	 */
	public static List<String> getLocales()
	{
		return AonLocale.getLocale();
	}
	
	/**
	 * string locale정보를 Locale객체로 변환한다.
	 * @param locale
	 * @return
	 */
	public static Locale convertToLocale(String locale)
	{
		String[] loc = locale.split(AonLocale.DIVIDER);
		switch (loc.length)
		{
			case 1 :
				return new Locale(loc[0]);
			case 2 :
				return new Locale(loc[0], loc[1]);
			case 3 :
				return new Locale(loc[0], loc[1], loc[2]);
		}
		return getDefaultLocale();
	}

	/**
	 * Json Text형태의 String을 JSON Object로 돌려준다.
	 * @param text
	 * @return
	 */
//	public static JSONObject getJSON(String text)
//	{
//		String _text = escape(text);
//		return ( .mayBeJSON(_text)) ? JSONObject.fromObject(_text) : null;
//	}

	/**
	 * jstl에서 사용될 로케일 정보를 돌려준다.
	 * @param req
	 */
	public static void jstlLocale(HttpServletRequest req)
	{
		req.setAttribute("defaultLocale", getDefaultLocale());
		req.setAttribute("locales", getLocales());
	}

	/**
	 * 현재 로케일의 language값을 반환한다.
	 * @return
	 */
	public static String getLanguage()
	{
		return getLocale().getLanguage();
	}

	/**
	 * 현재 로케일의 country값을 반환한다.
	 * @return
	 */
	public static String getCountry()
	{
		return getLocale().getCountry();
	}

	/**
	 * 현재 로케일의 language값을 반환한다.
	 * @return
	 */
	public static String getCountry(String language)
	{
		return AonLocale.getCountryOfLanguage(language);
	}

	/**
	 * 현재 로케일의 variant값을 반환한다.
	 * @return
	 */
	public static String getVariant()
	{
		return getLocale().getVariant();
	}

	/**
	 * 서버에 설정된 로케일과 같은지 확인한다.
	 * @return
	 */
	public static boolean isDefaultLocale(String locale)
	{
		return isDefaultLocale(convertToLocale(locale));
	}

	/**
	 * 서버에 설정된 로케일과 같은지 확인한다.
	 * @return
	 */
	public static boolean isDefaultLocale(Locale locale)
	{
		return getDefaultLocale().equals(locale);
	}

	/**
	 * 시스템 기본 언어를 돌려준다.
	 * @param text
	 * @return
	 */
//	public static String getDefaultLanguage(String text)
//	{
//		JSONObject json = getJSON(text);
//		if (JSONUtils.isNull(json))
//			return text;
//		return getDefaultLanguage(json);
//	}

	/**
	 * 시스템 기본 언어를 돌려준다.
	 * @param json
	 * @return
	 */
//	public static String getDefaultLanguage(JSONObject json)
//	{
//		String _language = getDefaultLocale().getLanguage();
//		return json.getString(_language);
//	}

	/**
	 * JSON에서 사용자 언어의 값을 가져온다. 없으면 시스템 기본 언어의 값을 돌려준다.
	 * @param text
	 * @return
	 */
//	public static String getLocalLanguage(String text)
//	{
//		JSONObject json = getJSON(text);
//		if (JSONUtils.isNull(json))
//			return text;
//		String _language = getLanguage();
//		return getLocalLanguage(json, _language);
//	}

	/**
	 * JSON에서 요청된 언어를 돌려준다. 없으면 시스템 기본 언어의 값을 돌려준다.
	 * @param text
	 * @param language
	 * @return
	 */
//	public static String getLocalLanguage(String text, String language)
//	{
//		JSONObject json = getJSON(text);
//		if (JSONUtils.isNull(json))
//			return text;
//		return getLocalLanguage(json, language);
//	}

	/**
	 * JSON에서 요청된 언어를 돌려준다. 없으면 시스템 기본 언어의 값을 돌려준다.
	 * @param json
	 * @param language
	 * @return
	 */
//	public static String getLocalLanguage(JSONObject json, String language)
//	{
//		if (json.containsKey(language))
//		{
//			String text = json.getString(language);
//			if (text != null && !"".equals(text))
//				return text;
//		}
//		return getDefaultLanguage(json);
//	}

	/**
	 * 시스템 기본 언어만 있을경우 text값을 돌려준다.
	 * @param text
	 * @return
	 */
//	public static String getMultiLanguage(String text)
//	{
//		return getMultiLanguage(text, false);
//	}

	/**
	 * Full JSON Text를 돌려준다. 1개만 있을경우 text값으로 돌려준다. (locale 이 잘못되어 디폴트 locale과 실제 들어있는
	 * 값이틀릴경우를 대비한다.) ex) deflocale : ko, value = {"en":"aaa"} 이런식이면 내용이 다 null이 되므로
	 * value값을 그냥 aaa 로 저장한다.
	 * @param text
	 * @param excludeEmpty
	 * @return
	 */
//	@SuppressWarnings("unchecked")
//	public static String getMultiLanguage(String text, boolean excludeEmpty)
//	{
//		JSONObject json = getJSON(text);
//		JSONObject newJson = new JSONObject();
//		if (JSONUtils.isNull(json))
//			return text;
//		if (excludeEmpty)
//		{
//			for (Iterator<String> i = json.keys(); i.hasNext();)
//			{
//				String key = i.next();
//				String value = json.getString(key);
//				if (!StringUtils.isEmpty(value))
//				{
//					newJson.put(key, value);
//				}
//			}
//		}
//		else
//		{
//			newJson = json;
//		}
//
//		if (newJson.size() == 1)
//		{
//			String key = "";
//			for (Iterator<String> i = newJson.keys(); i.hasNext();)
//			{
//				key = i.next();
//			}
//			return newJson.getString(key);
//		}
//		return newJson.toString();
//	}

	/**
	 * text를 json객체로 돌려준다.
	 * @param text
	 * @return
	 */
//	public static JSONObject getMultiLanguageJsonObject(String text)
//	{
//		JSONObject json = getJSON(text);
//		if (!JSONUtils.isNull(json))
//			return json;
//		json = new JSONObject();
//		json.element(getDefaultLocale().getLanguage(), text);
//		return json;
//	}

	/**
	 * language에 해당하는 속성값을 newName속성으로 바꾼다.
	 * @param jsonText
	 * @param newName
	 * @param language
	 * @return
	 */
//	public static String updateMultilanguage(
//		String jsonText,
//		String newName,
//		String language)
//	{
//		JSONObject json = getJSON(jsonText);
//		if (JSONUtils.isNull(json))
//			return jsonText;
//		if (json.containsKey(language))
//		{
//			json.element(language, newName);
//		}
//		return json.toString();
//	}

	/**
	 * JSON객체에중복된 언어의 리스트를 돌려준다.
	 * @param oldName
	 * @param newName
	 * @return
	 */
//	@SuppressWarnings("unchecked")
//	public static List<String> getDuplicatedLanguages(String oldName, String newName)
//	{
//		List<String> duplicatedElements = new ArrayList<String>();
//		JSONObject _old = getMultiLanguageJsonObject(oldName);
//		JSONObject _new = getMultiLanguageJsonObject(newName);
//		Iterator<String> oldNames = _old.keys();
//		while (oldNames.hasNext())
//		{
//			String key = oldNames.next();
//			if (_new.containsKey(key))
//			{
//				if (_old.getString(key).equals(_new.getString(key)))
//				{
//					duplicatedElements.add(key);
//				}
//			}
//		}
//		return duplicatedElements;
//	}

	/**
	 * Languages 정보를 List 형태로 돌려준다.
	 * @return
	 */
	public static List<String> getLanguages()
	{
		return AonLocale.Language.getLanguages();
	}

	/**
	 * Languages 정보를 javascript Array 형태로 돌려준다.
	 * @return
	 */
	public static String getLanguagesByJSArray()
	{
		String _default = getDefaultLocale().getLanguage();
		StringBuffer langs = new StringBuffer();
		List<String> languages = AonLocale.Language.getLanguages();
		Iterator<String> language = languages.iterator();
		langs.append("[");
		while (language.hasNext())
		{
			String lang = language.next();
			langs.append("{");
			langs.append("\"text\":");
			langs.append("\"" + lang + "\"");
			if (_default.equals(lang))
			{
				langs.append(",\"required\":\"true\"");
			}
			langs.append("},");
		}
		langs.delete(langs.length() - 1, langs.length());
		langs.append("]");
		return langs.toString();
	}

	private static String escape(String value)
	{
		if (value == null)
		{
			return null;
		}

		String text = value.toString();
		StringBuffer escVal = new StringBuffer();
		int l = text.length();
		for (int i = 0; i < l; i++)
		{
			char a = text.charAt(i);
			a = ((int) a <= 31 && (int) a != 13 && (int) a != 10) ? '*' : a;
			switch (a)
			{
				case '[' :
					escVal.append("\\[");
					break;
				case '\'' :
					escVal.append("\\'");
					break;
				default:
					escVal.append(a);
					break;
			}
		}
		return escVal.toString();
	}

//	/**
//	 * 서버시간 더해서 돌려준다.
//	 * @param l
//	 * @return
//	 */
//	public static long getServerTime(long l)
//	{
//		Time term = KCubeTimeZone.getTerm(getCountry(), false);
//		if (isLocal(term))
//			return l;
//		return addTime(l, term).getTimeInMillis();
//	}

//	/**
//	 * 서버시간을 더해서 돌려준다.
//	 * <p>
//	 * (현재 서버 시간 기준)
//	 * @return
//	 */
//	public static long getServerTime()
//	{
//		return getServerTime(new Date().getTime());
//	}

//	/**
//	 * 클라이언트 시간을 더해서 돌려준다.
//	 * @param long
//	 * @return
//	 */
//	public static long getLocalTime(long l)
//	{
//		Time term = KCubeTimeZone.getTerm(getCountry(), true);
//		if (isLocal(term))
//			return l;
//		return addTime(l, term).getTimeInMillis();
//	}

//	/**
//	 * 클라이언트 시간을 더해서 돌려준다.
//	 * @param Calendar
//	 * @return
//	 */
//	public static Calendar getLocalTime(Calendar c)
//	{
//		Time term = KCubeTimeZone.getTerm(getCountry(), true);
//		if (isLocal(term))
//			return c;
//		c.add(Calendar.HOUR, term.getHour());
//		c.add(Calendar.MINUTE, term.getMinute());
//		return c;
//	}

//	/**
//	 * 클라이언트 시간을 더해서 돌려준다.
//	 * @param Date
//	 * @return
//	 */
//	public static Date getLocalTime(Date d)
//	{
//		Time term = KCubeTimeZone.getTerm(getCountry(), true);
//		if (isLocal(term))
//			return d;
//		return addTime(d.getTime(), term).getTime();
//	}

//	/**
//	 * 현재 시간에 Time객체만큼 더한다.
//	 * @param now
//	 * @param term
//	 * @return
//	 */
//	private static Calendar addTime(long now, Time term)
//	{
//		Calendar c = Calendar.getInstance();
//		c.setTimeInMillis(now);
//		c.add(Calendar.HOUR, term.getHour());
//		c.add(Calendar.MINUTE, term.getMinute());
//		return c;
//	}

//	/**
//	 * 서버시간대와 클라이언트 시간대가 같은지 확인한다.
//	 * @param term
//	 * @return
//	 */
//	private static boolean isLocal(Time term)
//	{
//		return (term.getHour() == 0 && term.getMinute() == 0);
//	}
}
