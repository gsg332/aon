package com.aon.sys.usr;

import java.io.Serializable;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;

import com.aon.module.contest.ContestService;
import com.aon.module.cyberaccount.CyberAccount;
import com.aon.module.cyberaccount.CyberAccountService;
import com.aon.sys.member.Member;

/**
 * Spring Security용 Session 객체.
 *
 */
public class UserSecurity extends org.springframework.security.core.userdetails.User implements Serializable {

	private static final long serialVersionUID = 8225479693272931974L;

	private CustomUser customUser;

	private CyberAccountService cyberAccountService;
	private ContestService contestService;

	/**
	 * Spring Security의 로그인 서비스에서 제공하는 User객체는 id, password 등의 적은 정보만 제공되고 때문에 다양한 정보를 담을 수 없어 User객체를 상속하여 확장된 User객체를
	 * 생성하여 사용하도록 한다.
	 */
	public UserSecurity(String loginId, String password, Collection<? extends GrantedAuthority> authorities,
			Member member, CyberAccountService cyberAccountService, ContestService contestService) {

		super(loginId, password, true, true, true, true, authorities);

		customUser = new CustomUser();
		customUser.setId(member.getId());
		customUser.setLoginId(member.getLoginId());
		customUser.setType(member.getType());
		customUser.setFirstName(member.getFirstName());
		customUser.setLastName(member.getLastName());
		customUser.setNickname(member.getNickname());
		customUser.setEmail(member.getEmail());
		customUser.setCellPhoneNumber(member.getCellPhoneNumber());
		customUser.setInsertDate(member.getInsertDate());
		this.cyberAccountService = cyberAccountService;
		this.contestService = contestService;
	}

	public CustomUser getCustomUser() {
		return customUser;
	}

	public void setCustomUser(CustomUser customUser) {
		this.customUser = customUser;
	}

	/**
	 * 상단(헤더)에 표시될 잔여포인트를 반환한다. 
	 *
	 * @return
	 * @throws Exception
	 */
	public long getBalance() throws Exception {
		CyberAccount cyberAccount = cyberAccountService.getCyberAccount();
		if (cyberAccount != null) {
			return cyberAccount.getBalance();
		} else {
			return 0;
		}
	}

	/**
	 * 상단(헤더)에 표시될 미확인질문 여부를 반환한다.
	 *
	 * @return
	 * @throws Exception
	 */
	public long getQuestionIsRead() throws Exception{
		return contestService.questionIsRead();
	}
	
	/**
	 * 상단(헤더)에 표시될 미확인답변 여부를 반환한다.
	 *
	 * @return
	 * @throws Exception
	 */
	public long getAnswerIsRead() throws Exception {
		return contestService.answerIsRead();
	}

}
