package com.aon.sys.conf;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface ConfigUI {
	public UI type(); 
	
	public enum UI {
		
		INPUT("input"),CHECKBOX("checkbox"),TEXTAREA("textarea"),SELECT("select");
	
		private final String tag;
		
		private UI(String tag){
			this.tag = tag;
		}
		
		public String getTag(){
			return tag;
		}
		
	}
}
