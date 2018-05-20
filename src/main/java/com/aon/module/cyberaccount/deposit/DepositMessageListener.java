package com.aon.module.cyberaccount.deposit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aon.module.cyberaccount.CyberAccount;
import com.aon.module.cyberaccount.CyberAccountService;
import com.aon.module.cyberaccount.deposit.DepositEvent.Confirm;
import com.aon.sys.conf.ConfigService;
import com.aon.sys.member.Member;
import com.aon.sys.member.MemberService;
import com.aon.sys.msg.MessageService;
import com.aon.sys.usr.User;

@Component
public class DepositMessageListener implements IDepositListener {

	private static final Logger logger = LoggerFactory.getLogger(DepositMessageListener.class);

	@Autowired
	CyberAccountService cyberAccountService;

	@Autowired
	MemberService memberService;

	@Override
	public void confirm(Confirm e) throws Exception {
		Deposit deposit = (Deposit) e.getSource();

		Long cyberAccId = deposit.getCyberAccId();
		CyberAccount cyberAccount = cyberAccountService.getCyberAccountById(cyberAccId);
		Member member = memberService.getMemberInfo(cyberAccount.getMemberId());

		User receiver = new User(member.getId(), member.getNickname());
		
		// Map<String, Object> m = new HashMap<String, Object>();
		// m.put("receiver", receiver);
		// m.put("sender", sender);

		String content = ConfigService.merge(DepositMessageConfig.CONFIRM, null);
		MessageService.send(content, receiver);
	}

}
