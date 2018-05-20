package com.aon.junit;

public class TestString {
	
	public static void main(String args[]){
		
		System.out.println("Väste".getBytes(java.nio.charset.StandardCharsets.UTF_8).length);
		System.out.println("hello".getBytes(java.nio.charset.StandardCharsets.UTF_8).length);
		System.out.println("안녕".getBytes(java.nio.charset.StandardCharsets.UTF_8).length);

	}
}
