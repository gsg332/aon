package com.aon.sys.schedule.log;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.InetAddress;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.lib.util.NetworkUtil;

@Service
public class SysLogService {
	@Autowired
	private ISysLogRepository repository;

	/**
	 * 성공 로그를 남긴다.
	 */
	public void success(String name, String param) throws Exception {
		SysLog log = new SysLog();
		log.setName(name);
		log.setParam(param);
		log.setDetail(null);
		log.setInsertDate(new Date());
		log.setResult(true);
		log.setIp(NetworkUtil.StringToLongIp(InetAddress.getLocalHost().getHostAddress()));
		repository.save(log);
	}

	/**
	 * 실패 로그를 남긴다.
	 * <p>
	 * Exception의 stack trace가 detail에 남는다.
	 */
	public void fail(String name, String param, Exception e) throws Exception {
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		e.printStackTrace(pw);
		String st = sw.toString();
		fail(name, param, st);
	}

	/**
	 * 실패 로그를 남긴다.
	 */
	public void fail(String name, String param, String detail) throws Exception {
		SysLog log = new SysLog();
		log.setName(name);
		log.setParam(param);
		log.setDetail(detail);
		log.setInsertDate(new Date());
		log.setResult(false);
		log.setIp(NetworkUtil.StringToLongIp(InetAddress.getLocalHost().getHostAddress()));
		repository.save(log);

	}

}
