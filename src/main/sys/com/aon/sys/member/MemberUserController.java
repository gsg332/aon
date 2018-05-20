package com.aon.sys.member;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.doc.Permission;
import com.aon.lib.event.EventPublisher;
import com.aon.lib.security.SH256Cipher;
import com.aon.lib.validator.ValidationException;
import com.aon.sys.member.Member.Category;
import com.aon.sys.member.Member.MemberProfile;
import com.aon.sys.member.confirm.Confirm;
import com.aon.sys.member.confirm.IConfirmRepository;
import com.aon.sys.usr.UserService;
import com.fasterxml.jackson.annotation.JsonView;

@Controller
@RequestMapping(value = "/sys/member/")
public class MemberUserController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(MemberUserController.class);

	@Autowired
	private MemberService service;

	@Autowired
	private IMemberRepository repository;

	@Autowired
	private IConfirmRepository confirmRepository;

	@Autowired
	private MemberValidator validator;

	@Autowired
	private MemberQuery memQuery;

	@Autowired
	private EventPublisher publisher;

	private Permission permission;

	@Override
	public void init() {
		permission = new Permission();
	}

	/**
	 * 회원 LIST JSON
	 * 
	 * @param page
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberList")
	@JsonView(BaseJsonView.Summary.class)
	public Model list(Pageable page, Model model) throws Exception {
		return model.addAllAttributes(service.getMemberList(page, null));
	}

	/**
	 * 국가 가져오기
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getNations")
	@JsonView(BaseJsonView.Detail.class)
	public Model getNations(Model model) throws Exception {
		List<HashMap<String, Object>> nationList = service.getNationList();
		Locale locale = LocaleContextHolder.getLocale();
		model.addAttribute("nationList", nationList);
		model.addAttribute("compareLocale", String.valueOf(locale).substring(3,5));
		return model;
	}

	/**
	 * 멤버가입
	 * 
	 * @param sysMember
	 * @return
	 * @throws ValidationException
	 * @throws Exception
	 */
	@RequestMapping(value = "/joinMember", method = RequestMethod.POST)
	@JsonView(BaseJsonView.Detail.class)
	public void insertMember(Member client, Member.MemberProfile memberProfile, HttpServletRequest req,
			BindingResult result) throws Exception {

		// validator.validate(client, result); 이유는 모르겠는데 안됨
		checkBindingResult(result);
		Member server = repository.findByLoginId(client.getLoginId());
		Member rtnMember = service.memberModify(server, client);

		// cyberAccount 생성
		publisher.broadcast(new MemberEvent.Create(rtnMember));
		// bankAccount 데이터 생성 및 member 정보 업데이트
		service.memberProfileModify(server, memberProfile, client, req);
	}

	/**
	 * nickname 중복체크
	 * 
	 * @param sysMember
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/duplicateNickCheck", method = RequestMethod.POST)
	@JsonView(BaseJsonView.Detail.class)
	public Model duplicateNickNameCheck(String nickname, Long memberId, Model model) throws Exception {

		// 현재 자기 자신의 닉네임은 체크 대상에서 제외해야 함. 그렇지 않으면, 자기 자신의 현재 닉네임도 중복되는 메시지 발생.
		if (memberId == null) { // 사용자 화면 회원가입일 , 회원수정일 경우
			Long currLoginId = UserService.getMemberId();
			memberId = currLoginId == null ? 0L : currLoginId;
		}

		int rtnCnt = service.duplicateNickNameCheck(nickname, memberId);
		if (rtnCnt != 0) {
			model.addAttribute("nickChk", false);
		} else {
			model.addAttribute("nickChk", true);
		}
		return model;
	}

	/**
	 * email 중복체크
	 * 
	 * @param sysMember
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/duplicateLoginIdCheck", method = RequestMethod.POST)
	@JsonView(BaseJsonView.Detail.class)
	public Model duplicateLoginIdCheck(String loginId, Model model) throws Exception {
		String rtnCnt = service.duplicateLoginIdCheck(loginId);
		model.addAttribute("emailCnt", rtnCnt);
		return model;
	}

	/**
	 * 유저정보조회
	 * 
	 * @param member
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getMemberInfo")
	@JsonView(BaseJsonView.Summary.class)
	public Model getMemberInfo(Model model) throws Exception {
		Member member = service.getMemberInfo();
		model.addAttribute("memberInfo", member);
		return model;
	}

	/**
	 * 유저수정처리
	 * 
	 * @param member
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberModify", method = RequestMethod.POST)
	@JsonView(BaseJsonView.Detail.class)
	public void memberModify(HttpServletRequest request, Member member, BindingResult result) throws Exception {
		service.checkMemberPassword(member);
		validator.myPageValidate(member, result);
		checkBindingResult(result);
		Member server = repository.loadWithLock(UserService.getMemberId());
		service.memberModify(server, member);

	}

	/**
	 * 유저프로필수정 처리
	 * 
	 * @param memberProfile
	 * @param bankAccount
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberProfileModify", method = RequestMethod.POST)
	@JsonView(BaseJsonView.Detail.class)
	public void memberProfileModify(Member.MemberProfile memberProfile, Member member, HttpServletRequest req, Model model,
			BindingResult result) throws Exception {
		checkBindingResult(result);
		Member server = repository.findOne(UserService.getMemberId());
		service.memberProfileModify(server, memberProfile, member, req);
	}
	
	@RequestMapping(value = "/getPasswordCheck", method = RequestMethod.POST)
	// @ResponseStatus(code = HttpStatus.OK)
	@JsonView(BaseJsonView.Summary.class)
	public Model getMemberPassword(Member member, BindingResult result, Model model) throws Exception {
		checkBindingResult(result);
		Member server = memQuery.getMemberPassword(member);

		if (server.getPassword().equals(SH256Cipher.getSHA256(member.getPassword()))) {
			model.addAttribute("passwordChk", true);
		}
		return model;
	}

	/**
	 * 유저 탈퇴처리
	 * 
	 * @param member
	 * @throws Exception
	 */
	@RequestMapping(value = "/memberWithdrawal", method = RequestMethod.POST)
	public void deleteMember(Member member, BindingResult result, ModelAndView model) throws Exception {
		// validator.validate(member, result);
		checkBindingResult(result);
		// permission.checkOwner(member);
		service.deleteMember(member);

	}

	/**
	 * 유저정보조회
	 * 
	 * @param member
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/emailConfirmUserStatus")
	@JsonView(BaseJsonView.Summary.class)
	public Model emailConfirmUserInfo(Model model, Member client) throws Exception {
		Member member = service.emailConfirmUserStatus(client);
		if (member == null) {
			model.addAttribute("status", Member.APPLIED_STATUS);
		} else {
			model.addAttribute("status", member.getStatus());
		}
		return model;
	}

	/**
	 * 가입메일발송
	 * 
	 * @param member
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/emailInvitation")
	@ResponseStatus(code = HttpStatus.OK)
	public void emailInvitation(HttpServletRequest request, Member client) throws Exception {
		service.emailConfirmUserUpdate(request, client); // 1000및 1100처리를 한다
	}

	/**
	 * 인증처리 암호화 String path를 암호화하여 MAV로 원하는 페이지로 리다이렉트 한다
	 * 
	 * @param path
	 * @return
	 */
	@RequestMapping(value = "/{path}/emailConfirm")
	public ModelAndView findByConfirmCode(@PathVariable("path") String path, ModelAndView model) throws Exception {
		Confirm confirm = confirmRepository.findByConfirmCode(path);
		
		if (confirm != null) {
			Member member = repository.findByLoginId(confirm.getLoginId());
			confirmRepository.deleteByLoginId(confirm.getLoginId());
			model.addObject("member", member);
			model.setViewName("/sys/member/index");
		} else {
			model.setViewName("/sys/member/invalidEmailConfirm");
		}
		
		return model;
	}

	/**
	 * 비밀번호찾기
	 * 
	 * @param member
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findMemberPassword")
	@JsonView(BaseJsonView.Summary.class)
	public Member findMemberPassword(HttpServletRequest request, Model model, Member client) throws Exception {
		Member member = service.findMemberPassword(request, client); // 유저정보를 조회
		return member;
	}
	
	/**
	 * 전문분야 가져오기
	 * 
	 * @param member
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSpecialty")
	@JsonView(BaseJsonView.Summary.class)
	public Model getSpecialty(HttpServletRequest request, Model model, Member client) throws Exception {
		model.addAttribute("list",service.getSpecialty());
		return model;
	}
	
	/**
	 * 프로필 사진 다운로드
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/download")
	@ResponseBody
	public void download(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MemberProfile att = (MemberProfile) memQuery.find(MemberProfile.class, UserService.getMemberId());
		if (att.getImage() != null) {
			super.download(request, response, att.getImage(), true);
		}
	}
}
