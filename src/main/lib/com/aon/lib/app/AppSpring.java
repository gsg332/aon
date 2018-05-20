package com.aon.lib.app;

public class AppSpring {

	private static String applicationName;
	
	public void setApplicationName(String applicationName){
		AppSpring.applicationName = applicationName;
	}
	
	public static String getApplicationName(){
		return AppSpring.applicationName;
	}
}
