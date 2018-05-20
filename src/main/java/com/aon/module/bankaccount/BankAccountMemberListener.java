package com.aon.module.bankaccount;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aon.doc.BaseObject;
import com.aon.sys.member.IMemberListener;
import com.aon.sys.member.Member;
import com.aon.sys.member.MemberEvent.Create;
import com.aon.sys.member.MemberEvent.Delete;
import com.aon.sys.member.MemberEvent.SendMail;
import com.aon.sys.member.MemberEvent.Update;

@Component
public class BankAccountMemberListener implements IMemberListener {

	@Autowired
	IBankAccountRepository bankRepository;

	@Autowired
	BankAccountService bankAccountService;

	@Override
	public void create(Create e) throws Exception {
		Member member = (Member) e.getSource();
		member.setInsertDate(new Date());
		member.setStatus(BaseObject.REGISTERED_STATUS);
	}

	@Override
	public void delete(Delete e) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void update(Update e) throws Exception {
		/* paypal 연동으로 주석처리. 
		HttpServletRequest req = (HttpServletRequest) e.getSource();
		Long id = Long.parseLong(req.getAttribute("id").toString());
		BankAccount bankAccountServer = bankAccountService.loadOrCreate(id);

		bankAccountServer.setMemberId(id);
		bankAccountServer.setInsertDate(new Date());

		bankAccountServer.setBankCode(req.getParameter("bankCode").toString());
		bankAccountServer.setAccountName(req.getParameter("accountName").toString());
		bankAccountServer.setAccountNumber(req.getParameter("accountNumber").toString());
		*/
	}

	@Override
	public void sendMail(SendMail e) throws Exception {
		// TODO Auto-generated method stub

	}

}
