package com.aon.sys.login;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.EntityManagerService;
import com.aon.module.contest.ContestService;
import com.aon.module.cyberaccount.CyberAccountService;
import com.aon.sys.member.Member;
import com.aon.sys.usr.User;
import com.aon.sys.usr.UserSecurity;

@Service("supervisorLoginService")
public class SupervisorLoginService implements UserDetailsService {

	static final Logger LOGGER = LoggerFactory.getLogger(SupervisorLoginService.class);
	
	@Autowired
	private CyberAccountService cyberAccountService;
	
	@Autowired
	private ContestService contestService;

	/**
	 * Spring Security를 사용하여 로그인할 경우, 로그인 요청 직후에 이 메소드가 호출되어 회원정보를 찾은 후 Spring session에 회원정보를 등록한다.
	 */
	@Override
	public UserDetails loadUserByUsername(String loginId) throws UsernameNotFoundException {

		LOGGER.debug("### member login loginId : " + loginId);

		Member member = null;

		try {
			member = (Member) EntityManagerService
					.createQuery("select m from Member m where loginId = ? and admin = ? and status = ?", Member.class)
					.setParameter(1, loginId).setParameter(2, true).setParameter(3, Member.REGISTERED_STATUS).getSingleResult();

		} catch (Exception e) {
			// 스프링 시큐리티를 이용한 로그인시 UsernameNotFoundException이외에 throws를 할 수 없기 때문에 예외를 여기서 잡도록 함.
			e.printStackTrace();
		}

		if (member == null) {
			throw new UsernameNotFoundException(loginId);
		}

		List<GrantedAuthority> gas = new ArrayList<GrantedAuthority>();
		gas.add(new SimpleGrantedAuthority(User.ROLE_ADMIN));

		return new UserSecurity(member.getLoginId(), member.getPassword(), gas, member, cyberAccountService, contestService);
	}

}
