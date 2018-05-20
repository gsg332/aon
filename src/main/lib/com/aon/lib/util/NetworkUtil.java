package com.aon.lib.util;

import javax.servlet.http.HttpServletRequest;

public class NetworkUtil {

	/**
	 * long타입의 IP정보를 String타입의 IP정보로 변경
	 *
	 * @param address
	 * @return
	 */
	public static String longToStringIp(Long address) {
		long longip = address;
		StringBuilder sb = new StringBuilder(15);

		for (int i = 0; i < 4; i++) {

			sb.insert(0, Long.toString(longip & 0xff));

			if (i < 3) {
				sb.insert(0, '.');
			}

			longip = longip >> 8;

		}

		return sb.toString();
	}

	/**
	 * String타입의 IP정보를 long타입의 IP정보로 변경
	 *
	 * @param address
	 * @return
	 */
	public static Long StringToLongIp(String address) {
		long result = 0;

		String[] ipAddressInArray = address.split("\\.");
		for (int i = 3; i >= 0; i--) {
			long ip = Long.parseLong(ipAddressInArray[3 - i]);
			result |= ip << (i * 8);
		}

		return result;
	}

	/**
	 * 요청한 클라이언트의 IP정보를 가지고 온다.
	 *
	 * @return
	 */
	public static String getClientIp(HttpServletRequest request) {

		String[] HEADERS_LIST = { "X-Forwarded-For", "Proxy-Client-IP", "WL-Proxy-Client-IP", "HTTP_X_FORWARDED_FOR",
				"HTTP_X_FORWARDED", "HTTP_X_CLUSTER_CLIENT_IP", "HTTP_CLIENT_IP", "HTTP_FORWARDED_FOR",
				"HTTP_FORWARDED", "HTTP_VIA", "REMOTE_ADDR" };

		for (String header : HEADERS_LIST) {
			String ip = request.getHeader(header);
			if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
				return ip;
			}
		}
		return request.getRemoteAddr();
	}

}
