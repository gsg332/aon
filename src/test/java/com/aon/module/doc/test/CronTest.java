package com.aon.module.doc.test;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;

import org.junit.Test;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.scheduling.support.SimpleTriggerContext;

import com.aon.lib.util.NetworkUtil;
import com.aon.sys.schedule.log.SysLog;

import junit.framework.TestCase;

public class CronTest extends TestCase {

	@Test
	public void test() {
		CronTrigger c = new CronTrigger("0 15 10 * * ?");
		Date d = c.nextExecutionTime(new SimpleTriggerContext());
		System.out.println(d.toString());

		try {
			System.out.println(InetAddress.getLocalHost().getHostAddress());
			SysLog log = new SysLog();

			log.setIp(NetworkUtil.StringToLongIp(InetAddress.getLocalHost().getHostAddress()));

			System.out.println(log.getIp());
			System.out.println(NetworkUtil.longToStringIp(log.getIp()));
		} catch (UnknownHostException e) { // 218.38.137.27
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
