package com.aon.module.contest;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.module.cyberaccount.CyberAccountService;
import com.aon.sys.category.CategoryService;
import com.aon.sys.member.Member;
import com.aon.sys.member.MemberService;
import com.aon.sys.usr.User;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;

@Controller
@RequestMapping("/supervisor/module/contest")
@Secured(User.ROLE_ADMIN)

public class ContestAdminController extends BaseController {
	static final Logger LOGGER = LoggerFactory.getLogger(ContestAdminController.class);
	@Autowired
	ContestService contestService;

	@Autowired
	MemberService memberService;

	@Autowired
	CategoryService categoryService;
	
	@Autowired
	private IContestRepository repository;

	@Autowired
	private CyberAccountService cyberAccountService;

	@Autowired
	private ContestAdminQuery query;

	/**
	 * 공모 정보 목록
	 *
	 * @param seq
	 * @return ModelAndView
	 * @throws Exception
	 */

	@RequestMapping("/listPage")
	@JsonView(BaseJsonView.Summary.class)
	public Model list(ContestSearch search, Pageable page, Model model) throws Exception {
		// QueryResults<Contest> result = query.getList(search, page);		
		List<Contest> result = query.getListByNativeQuery(search, page);
		List<Contest> count = query.getListCountByNativeQuery(search, page);
		model.addAttribute("list", result);
		model.addAttribute("count", count.get(0));
		return model;
	}

	/**
	 * 공모 정보 조회
	 *
	 * @param seq
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/read")
	@JsonView(BaseJsonView.Detail.class)
	public Model read(Long id, Model model) throws Exception {
		Contest server = repository.findOne(id);
		Member register = null;
		register = memberService.getMemberInfo(server.getRegisterUser().getMemberId());
		register.setCyberAccount(cyberAccountService.getCyberAccount(server.getRegisterUser().getMemberId()));
		model.addAttribute("item", server).addAttribute("register", register);

		return model;
	}

	/**
	 * 답변 리스트
	 *
	 * @param seq
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/listAnswer")
	@JsonView(BaseJsonView.Detail.class)
	public Model listByAnswer(ContestSearch search, Pageable page, Model model) throws Exception {
		QueryResults<Contest> result = query.getAnswerList(search, page);
		return model.addAttribute("list", result.getResults()).addAttribute("count", result.getTotal());
	}

	/**
	 * 답변과 공모 정보 조회
	 *
	 * @param seq
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/readAnswer")
	@JsonView(BaseJsonView.Detail.class)
	public Model readAnswer(Long id, Model model) throws Exception {
		Contest server = repository.findOne(id);
		List<Contest> result = query.getAnswerRead(id);
		model.addAttribute("item", server);
		model.addAttribute("answerList", result);
		return model;
	}

	/**
	 * 경고 처리
	 *
	 * @param seq
	 * @param warnContent
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/setWarnnig")
	public void setWarning(Long id) throws Exception {
		Contest server = repository.loadWithLock(id);
		contestService.editStatusByWarn(server);
	}

	/**
	 * 공모 취소
	 *
	 * @param seq
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/cancel")
	public void cancelContest(Long id) throws Exception {
		Contest server = repository.loadWithLock(id);
		contestService.cancelContest(server);
	}
	/**
	 * 첨부파일 다운로드
	 *
	 * @param request
	 * @param response
	 * @param id
	 * @throws Exception
	 */
	@RequestMapping(value = "/download")
	@ResponseBody
	public void download(HttpServletRequest request, HttpServletResponse response, Long id) throws Exception {
		Contest.Attachment att = (Contest.Attachment) query.find(Contest.Attachment.class, id);
		Contest server = (Contest) att.getEntity();
		// TODO : permission check
		super.download(request, response, att, false);
	}
	
	@RequestMapping(value = "/getContentsCount")
	@ResponseBody
	public Model getContentsCount(Long categoryId, Model model) throws Exception {
		List<Object> contentsCount = contestService.getContentsCount(categoryId);
		model.addAttribute("contentsCount", contentsCount);
		return model;
	}
	
	/**
	 * 글 이동
	 *
	 * @param id : 원본 카테고리 ID
	 * @param targetId : 이동할 카테고리 ID
	 * @throws Exception
	 */
	@RequestMapping(value = "/moveContents")
	@ResponseBody
	public void moveContents(Long id, Long parentId, Long targetId, Long targetParentId) throws Exception {
		categoryService.CategoryCache(id, parentId);
		categoryService.CategoryCache(targetId, targetParentId);
		contestService.moveContents(id, targetId);
	}
}
