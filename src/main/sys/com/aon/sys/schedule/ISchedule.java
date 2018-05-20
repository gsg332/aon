package com.aon.sys.schedule;

import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

public interface ISchedule {

	default Map<String, String> parseParameter(String param) {
		Map<String, String> result = new HashMap<String,String>();
		if (param != null) {
			StringTokenizer st = new StringTokenizer(param, "&");
			while (st.hasMoreTokens()) {
				String token = st.nextToken();
				int i = token.indexOf('=');
				if (i < 0) {
					continue;
				}
				result.put(token.substring(0, i), token.substring(i + 1));
			}
		}
		return result;
	}

	public default void execute(String param) throws Exception {
		execute(parseParameter(param));
	}

	public void execute(Map<String,String> param) throws Exception;
}
