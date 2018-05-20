package com.aon.lib.i18n;

import java.util.List;
import java.util.Locale;

/**
 * 다국어 관리
 */
public class I18N
{
	private static Locale _locale = Locale.getDefault();

	public void setDefaultLocale(String defaultLocale)
	{
		_locale = I18nService.convertToLocale(defaultLocale);
	}

	public void setLocales(List<String> locales)
	{
		AonLocale.setLocales(locales);
	}

	protected static Locale getDefaultLocale()
	{
		return _locale;
	}
}
