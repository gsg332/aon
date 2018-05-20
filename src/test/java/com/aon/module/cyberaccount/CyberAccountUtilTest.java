package com.aon.module.cyberaccount;

import org.junit.Test;

import com.aon.junit.JUnitTest;

public class CyberAccountUtilTest extends JUnitTest {

	@Test
	public void testGetReverseDate() throws Exception {
		assertEquals(CyberAccountUtil.getReverseDate(), "61026020");
	}

	@Test
	public void testGet6ZerofillMemberId() throws Exception {
		assertEquals(CyberAccountUtil.get6ZerofillMemberId(1L), "000001");
		assertEquals(CyberAccountUtil.get6ZerofillMemberId(1234567L), "234567");
	}	

	@Test
	public void testGet3ZerofillCountryNumericCode() throws Exception {
		assertEquals(CyberAccountUtil.get3ZerofillCountryNumericCode("KR"), "410");
		assertEquals(CyberAccountUtil.get3ZerofillCountryNumericCode("KOR"), "410");
	}

}
