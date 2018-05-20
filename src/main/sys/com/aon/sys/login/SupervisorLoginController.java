package com.aon.sys.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.aon.sys.usr.UserService;

@Controller
@RequestMapping("/supervisor/sys/login")
public class SupervisorLoginController {

	static final Logger LOGGER = LoggerFactory.getLogger(SupervisorLoginController.class);

	/**
	 * AngularJS에 의해 로그인 페이지가 특정 template에 들어가기 때문에 완전히 redirect할 수 있도록 실제 로그인 폼으로 가기 전의 로그인 페이지를 호출한다. template한 페이지에서
	 * 다시 페이지이동이 일어나면 그 때는 template영역이 아닌 완전한 페이지이동이 됨.
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		return mv;
	}

	/**
	 * 회원 로그인폼으로 이동한다.
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/loginForm")
	public ModelAndView loginForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){    
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		UserService.setUser(null);
		
		return "redirect:/supervisor/sys/login/loginForm.aon";
	}

}
