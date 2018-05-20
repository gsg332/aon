package com.aon.module.paypal;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.net.ssl.HttpsURLConnection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class PaypalService {

	private static final Logger logger = LoggerFactory.getLogger(PaypalService.class);

	public Map<String, String> getPayInfo(String params) throws Exception {
		String response = urlConnection(params);

		return getPaypalResponse(response);
	}

	private Map<String, String> getPaypalResponse(String response) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		int i = 0;
		String key = "", value = "";

		StringTokenizer st = new StringTokenizer(response, "\n");
		while (st.hasMoreElements()) {
			String str = (String) st.nextElement();
			if (i == 0) {
				map.put("result", str);
			} else {
				StringTokenizer token = new StringTokenizer(str, "=");
				key = token.nextElement().toString();
				if (token.hasMoreElements())
					value = token.nextElement().toString();
			}
			map.put(key, URLDecoder.decode(value, "UTF-8"));
			i++;
		}

		return map;
	}

	private String urlConnection(String params) throws Exception {
		DataOutputStream dataOutputStream = null;
		InputStream inputStream = null;
		BufferedReader bufferedReader = null;
		StringBuffer response = null;

		try {
			URL url = new URL(PaypalSpring.getPaymentUrl());
			HttpsURLConnection httpsURLConnection = (HttpsURLConnection) url.openConnection();

			httpsURLConnection.setRequestMethod("POST");
			// httpsURLConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			httpsURLConnection.setDoOutput(true);
			dataOutputStream = new DataOutputStream(httpsURLConnection.getOutputStream());
			dataOutputStream.writeBytes(params);
			dataOutputStream.flush();

			int responseCode = httpsURLConnection.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				inputStream = httpsURLConnection.getInputStream();
			} else {
				inputStream = httpsURLConnection.getErrorStream();
			}
			bufferedReader = new BufferedReader(new InputStreamReader(inputStream));

			String inputLine;
			response = new StringBuffer();
			while ((inputLine = bufferedReader.readLine()) != null) {
				response.append(inputLine).append("\n");
			}
		} finally {
			if (dataOutputStream != null)
				dataOutputStream.close();
			if (inputStream != null)
				inputStream.close();
			if (bufferedReader != null)
				bufferedReader.close();
		}

		logger.debug("##### urlConnection() response.toString() : {}", response.toString());
		return response.toString();
	}

}
