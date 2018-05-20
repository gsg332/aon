package com.aon.module.cyberaccount;

import java.util.Calendar;

import com.neovisionaries.i18n.CountryCode;

/**
 * 가상계좌와 관련된 util class
 *
 */
public class CyberAccountUtil {

	/**
	 * reverse(년yyyy)+reverse(월mm)+reverse(일dd)를 돌려준다.
	 *
	 * @return
	 * @throws Exception
	 */
	public static String getReverseDate() throws Exception {
		Calendar cal = Calendar.getInstance();

		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DAY_OF_MONTH);

		String reverseDate = reverseString(String.format("%04d", year)) + reverseString(String.format("%02d", month))
				+ reverseString(String.format("%02d", day));
		return reverseDate;
	}

	/**
	 * 회원일련번호를 받아서 6자리 문자열로 돌려준다. 6자리가 안되는 경우 0으로 채운다.
	 *
	 * @param memberId
	 * @return
	 * @throws Exception
	 */
	public static String get6ZerofillMemberId(Long memberId) throws Exception {
		String str = memberId.toString();

		if (str.length() > 6) {
			str = str.substring(str.length() - 6, str.length());
		}
		str = String.format("%06d", Integer.parseInt(str));

		return str;
	}

	/**
	 * reverse string
	 *
	 * @param str
	 * @return
	 */
	public static String reverseString(String str) {
		String reverseStr = new StringBuffer(str).reverse().toString();
		return reverseStr;
	}

	/**
	 * ISO 3166-1 alpha-2 or alpha-3 code에 해당하는 국가코드를 받아서 ISO 3166-1 numeric code를 얻는다.
	 *
	 * @param countryCode
	 * @return
	 */
	public static String get3ZerofillCountryNumericCode(String countryCode) throws Exception {
		CountryCode cc = CountryCode.getByCode(countryCode);
		String code = String.format("%03d", cc.getNumeric());
		return code;
	}
}
