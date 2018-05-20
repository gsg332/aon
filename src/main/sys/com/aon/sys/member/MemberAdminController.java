package com.aon.sys.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.sys.member.Member.Category;
import com.aon.sys.usr.User;
import com.aon.sys.usr.UserPermission;
import com.fasterxml.jackson.annotation.JsonView;

/**
 * @Secured 로그인한 사용자가 ROLE_ADMIN일 경우에만 다음 메소드에 접근 가능.
 */
@Controller
@Secured(User.ROLE_ADMIN)
@RequestMapping("/supervisor/module")
public class MemberAdminController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(MemberAdminController.class);

	@Autowired
	private MemberService service;
	@Autowired
	private MemberValidator validator;
	private UserPermission permission;

	@Override
	public void init() {
		permission = new UserPermission();
	}

	/**
	 * 회원 LIST JSON
	 * 
	 * @param page
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/member/list")
	@JsonView(BaseJsonView.Summary.class)
	public Model memberList(MemberSearch search, Pageable page, Model model) throws Exception {
		return model.addAllAttributes(service.getMemberList(page, search));
	}

	/**
	 * 회원 View JSON
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/member/readForUpdate")
	@JsonView(BaseJsonView.Detail.class)
	public Model memberReadForUpdate(Long id, Model model) throws Exception {
		return model.addAttribute("item", service.getMemberInfo(id));
	}

	/**
	 * 회원정보 수정.
	 *
	 * @param member
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/member/modify", method = RequestMethod.POST)
	@JsonView(BaseJsonView.Detail.class)
	public void memberModify(Member member, BindingResult result, HttpServletRequest req) throws Exception {
		service.checkMemberPassword(member);
		validator.supervisorValidate(member, result);
		checkBindingResult(result);
		service.memberModifyByAdmin(member,req);
	}

	/**
	 * 회원탈퇴 LIST JSON
	 * 
	 * @param page
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dropout/list")
	@JsonView(BaseJsonView.Summary.class)
	public Model dropoutList(MemberSearch search, Pageable page, Model model) throws Exception {
		return model.addAllAttributes(service.getDropoutList(page, search));
	}
	
	/**
	 * 전문분야 가져오기
	 * 
	 * @param member
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/member/getSpecialty")
	@JsonView(BaseJsonView.Summary.class)
	public Model getSpecialty(HttpServletRequest request, Model model, Long memberId) throws Exception {
		List<Category> categories = service.getSpecialty(memberId); // 유저정보를 조회	
		model.addAttribute("list",categories);
		return model;
	}
	
}
