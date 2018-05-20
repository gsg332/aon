package com.aon.module.cyberaccount;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.module.cyberaccount.point.PointService;
import com.aon.sys.member.Member;
import com.aon.sys.member.MemberService;
import com.aon.sys.usr.User;
import com.fasterxml.jackson.annotation.JsonView;

@Controller
@Secured(User.ROLE_ADMIN)
@RequestMapping("/supervisor/module/cyberAccount")
public class CyberAccountAdminController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(CyberAccountAdminController.class);

	@Autowired
	private CyberAccountService service;

	@Autowired
	private PointService pointService;

	@Autowired
	private MemberService memberService;

	/**
	 * 사용자의 포인트 거래내역을 조회한다.
	 *
	 * @param memberId
	 * @param pageable
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pointList")
	@JsonView(BaseJsonView.Summary.class)
	public Model pointList(Long memberId, Pageable pageable, Model model) throws Exception {
		logger.debug("##### memberId : {}", memberId);
		Member member = memberService.getMemberInfo(memberId);
		CyberAccount cyberAccount = service.getCyberAccount(member.getId());
		Object pointCount = pointService.getListCountByAdmin(cyberAccount.getId());
		List<Object> pointList = pointService.getListByAdmin(cyberAccount.getId(), pageable);

		model.addAttribute("member", member);
		model.addAttribute("cyberAccount", cyberAccount);
		model.addAttribute("pointList", pointList);
		model.addAttribute("pointCount", pointCount);

		return model;
	}
	
	/**
	 * memberId로 가상계좌를 조회한다.
	 *
	 * @param memberId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/read")
	@JsonView(BaseJsonView.Summary.class)
	public Model read(Long memberId, Model model) throws Exception {
		CyberAccount cyberAccount = service.getCyberAccount(memberId);
		logger.debug("##### cyberAccount : {}", cyberAccount.toString());
		model.addAttribute("item", cyberAccount);

		return model;
	}
}
