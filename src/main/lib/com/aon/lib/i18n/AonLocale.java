package com.aon.lib.i18n;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class AonLocale
{
	private static List<String> _locale;
	private static List<Locale> _locales;
	private static Map<String, String> _localeMap; // ko_KR 의 경우 ko와 KR을 하나의 set으로 묶는다.
	public final static String LOCALE = "org.springframework.web.servlet.i18n.CookieLocaleResolver.LOCALE";
	public final static String DIVIDER = "_";

	protected static void setLocales(List<String> locales)
	{
		_locale = new LinkedList<String>();
		_locales = new LinkedList<Locale>();
		_localeMap = new HashMap<String, String>();
		Language.init();
		Country.init();
		for (String locale : locales)
		{
			_locale.add(locale);
			Locale _locale = I18nService.convertToLocale(locale);
			_locales.add(_locale);
			_localeMap.put(_locale.getLanguage(), _locale.getCountry());
			Language.addLanguage(_locale.getLanguage());
			Country.addCountry(_locale.getCountry());
		}
	}

	protected static List<Locale> getLocales()
	{
		return _locales;
	}

	protected static List<String> getLocale()
	{
		return _locale;
	}
	
	protected static String getCountryOfLanguage(String language)
	{
		return _localeMap.get(language);
	}

	static class Language
	{
		public final static String NATION_LANGUAGE = "ko";
		private static List<String> _languages;

		/**
		 * 초기화
		 */
		protected static void init()
		{
			_languages = new LinkedList<String>();
		}

		/**
		 * Language 추가
		 * @param language
		 */
		protected static void addLanguage(String language)
		{
			_languages.add(language);
		}

		protected static List<String> getLanguages()
		{
			return _languages;
		}
	}

	static class Country
	{
		private static List<String> _countries = new LinkedList<String>();

		/**
		 * 초기화
		 */
		protected static void init()
		{
			_countries = new LinkedList<String>();
		}

		/**
		 * Country 추가
		 * @param country
		 */
		protected static void addCountry(String country)
		{
			_countries.add(country);
		}

		protected static List<String> getCountries()
		{
			return _countries;
		}
	}
}
