package com.aon.module.cyberaccount.withdraw;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aon.module.cyberaccount.CyberAccount;
import com.aon.module.cyberaccount.CyberAccountService;
import com.aon.module.cyberaccount.withdraw.WithdrawEvent.Confirm;
import com.aon.sys.conf.ConfigService;
import com.aon.sys.member.Member;
import com.aon.sys.member.MemberService;
import com.aon.sys.msg.MessageService;
import com.aon.sys.usr.User;

@Component
public class WithdrawMessageListener implements IWithdrawListener {
	
	private static final Logger logger = LoggerFactory.getLogger(WithdrawMessageListener.class);

	@Autowired
	CyberAccountService cyberAccountService;

	@Autowired
	MemberService memberService;

	@Override
	public void Confirm(Confirm e) throws Exception {
		Withdraw withdraw = (Withdraw) e.getSource();

		Long cyberAccId = withdraw.getCyberAccId();
		CyberAccount cyberAccount = cyberAccountService.getCyberAccountById(cyberAccId);
		Member member = memberService.getMemberInfo(cyberAccount.getMemberId());
		
		User receiver = new User(member.getId(), member.getNickname());
		
		String content = ConfigService.merge(WithdrawMessageConfig.CONFIRM, null);
		MessageService.send(content, receiver);
	}

}
