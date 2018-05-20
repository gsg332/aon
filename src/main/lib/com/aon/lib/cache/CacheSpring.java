package com.aon.lib.cache;

public class CacheSpring{

	private static boolean clustered;
	
	private static String user;
	
	private static String password;
	
	public  void setClustered(boolean clustered) {
		CacheSpring.clustered = clustered;
	}

	public  void setUser(String user) {
		CacheSpring.user = user;
	}

	public  void setPassword(String password) {
		CacheSpring.password = password;
	}
	
	public static boolean  isClustered(){
		return CacheSpring.clustered;
	}
	
    public static  String getUser(){
    	return CacheSpring.user;
    }
	
	public static String getPassword(){
		return CacheSpring.password;
	}

	
	
}
