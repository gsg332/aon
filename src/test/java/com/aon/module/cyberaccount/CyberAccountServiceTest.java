package com.aon.module.cyberaccount;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.aon.junit.JUnitTest;

public class CyberAccountServiceTest extends JUnitTest {

	@Autowired
	public CyberAccountService service;

	@Test
	public void testMakeAccountNumber() throws Exception {
		String accNumber = service.makeAccountNumber(1L, "KR");
		assertEquals(accNumber, "41061026030000001");
	}

}
