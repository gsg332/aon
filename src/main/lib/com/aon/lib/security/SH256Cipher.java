package com.aon.lib.security;
 
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
 
public class SH256Cipher {
 
    /**
     * @param args
     * @throws NoSuchAlgorithmException 
     */
     
    public static String getSHA256(String originalStr) throws NoSuchAlgorithmException {
		String securitycode = "";

		StringBuffer sb = new StringBuffer();
		MessageDigest md = MessageDigest.getInstance("SHA-256");

		md.update(originalStr.getBytes());
		byte[] msgb = md.digest();

		for (int i = 0; i < msgb.length; i++) {
			byte temp = msgb[i];
			String str = Integer.toHexString(temp & 0xFF);
			while (str.length() < 2) {
				str = "0" + str;
			}
			str = str.substring(str.length() - 2);
			sb.append(str);
		}

		securitycode = sb.toString();
		return securitycode;
	}
}