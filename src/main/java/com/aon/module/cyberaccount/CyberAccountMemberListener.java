package com.aon.module.cyberaccount;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aon.sys.member.IMemberListener;
import com.aon.sys.member.Member;
import com.aon.sys.member.MemberEvent.Create;
import com.aon.sys.member.MemberEvent.Delete;
import com.aon.sys.member.MemberEvent.SendMail;
import com.aon.sys.member.MemberEvent.Update;

@Component
public class CyberAccountMemberListener implements IMemberListener {

	@Autowired
	CyberAccountService cyberAccountService;

	@Override
	public void create(Create e) throws Exception {
		
		Member member = (Member)e.getSource();
		CyberAccount cyberAccount = cyberAccountService.getCyberAccount(member.getId());
		if(cyberAccount == null){
			cyberAccountService.create(member.getId(), member.getCountryCode()); 
		}
	}

	@Override
	public void delete(Delete e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Update e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sendMail(SendMail e) throws Exception {
		// TODO Auto-generated method stub
		
	}

	
}
