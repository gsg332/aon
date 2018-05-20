package com.aon.module.email;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aon.sys.member.IMemberListener;
import com.aon.sys.member.Member;
import com.aon.sys.member.MemberEvent.Create;
import com.aon.sys.member.MemberEvent.Delete;
import com.aon.sys.member.MemberEvent.SendMail;
import com.aon.sys.member.MemberEvent.Update;

@Component
public class EmailListener implements IMemberListener {
	
	@Autowired
	EmailService emailService;
	
	@Override
	public void create(Create e) {
		// TODO Auto-generated method stub
	}

	@Override
	public void delete(Delete e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Update e) {
		// TODO Auto-generated method stub
	}

	@SuppressWarnings("unchecked")
	@Override
	public void sendMail(SendMail e) throws Exception {
		HashMap<String, Object> map = (HashMap<String, Object>) e.getSource();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		Member member = (Member) map.get("member");
		int status = (int) map.get("status");
		int rndNum = (int) map.get("rndNum");
		String joinAuthToken = String.valueOf(map.get("joinAuthToken"));
		emailService.sendEmailToMember(request, member, status, rndNum,joinAuthToken);
		
	}
}
