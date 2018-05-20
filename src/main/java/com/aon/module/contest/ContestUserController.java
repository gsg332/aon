package com.aon.module.contest;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.doc.Permission;
import com.aon.doc.hist.ReadService;
import com.aon.doc.reply.ReplyService;
import com.aon.lib.event.EventPublisher;
import com.aon.module.cyberaccount.point.Point;
import com.aon.sys.category.Category;
import com.aon.sys.usr.UserService;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;
import com.querydsl.core.Tuple;

@Controller
@RequestMapping("/module/contest")
public class ContestUserController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ContestUserController.class);

	@Autowired
	private ContestService service;

	@Autowired
	private IContestRepository repository;

	@Autowired
	private ContestQuery query;

	@Autowired
	private ContestValidator validator;
	
	@Autowired
	private EventPublisher publisher;

	private ReadService read;
	private ReplyService reply;
	private Permission permission;

	@Override
	public void init() {
		read = new ReadService(Contest.class);
		reply = new ReplyService(Contest.class);
		permission = new Permission();
	}

	/**
	 * 정보거래 목록
	 *
	 * @param page
	 * @param model
	 * @param searchKey
	 * @param searchValue
	 * @param catSeq
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	@JsonView(BaseJsonView.Summary.class)
	public Model list(Pageable page, Model model, String searchKey, String searchValue, String catSeq)
			throws Exception {
		// QueryResults<Contest> result = query.getList(page, searchKey, searchValue, catSeq);
		// return model.addAttribute("list", result.getResults()).addAttribute("count", result.getTotal());

		List<Contest> result = query.getListByNativeQuery(page, searchKey, searchValue, catSeq);
		List<Contest> count = query.getTotalCountByNativeQuery(page, searchKey, searchValue, catSeq);
		return model.addAttribute("list", result).addAttribute("count", count.get(0));
	}

	/**
	 * 나의 질문 현황 목록
	 *
	 * @param page
	 * @param model
	 * @param searchKey
	 * @param searchValue
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/myList")
	@JsonView(BaseJsonView.Summary.class)
	public Model myList(Pageable page, Model model, String searchKey, String searchValue, boolean unconfirmed) throws Exception {
		// QueryResults<Contest> result = query.getMyList(page, searchKey, searchValue);
		// return model.addAttribute("list", result.getResults()).addAttribute("count", result.getTotal());

		List<Contest> result = query.getMyListByNativeQuery(page, searchKey, searchValue, unconfirmed);
		List<Contest> count = query.getMyTotalCountByNativeQuery(page, searchKey, searchValue, unconfirmed);

		return model.addAttribute("list", result).addAttribute("count", count.get(0));
	}

	/**
	 * 나의 답변 현황 목록
	 *
	 * @param page
	 * @param model
	 * @param searchKey
	 * @param searchValue
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/myAnswerList")
	@JsonView(BaseJsonView.Summary.class)
	public Model myAnswerList(Pageable page, Model model, String searchKey, String searchValue, boolean unconfirmed) throws Exception {
		// QueryResults<Contest> result = query.getMyList(page, searchKey, searchValue);
		// return model.addAttribute("list", result.getResults()).addAttribute("count", result.getTotal());

		List<Contest> result = query.getMyAnswerListByNativeQuery(page, searchKey, searchValue, unconfirmed);
		List<Contest> count = query.getMyAnswerTotalCountByNativeQuery(page, searchKey, searchValue, unconfirmed);

		return model.addAttribute("list", result).addAttribute("count", count.get(0));
	}
	
	/**
	 * 포인트 분배 - 채택된 답변 전체 목록
	 *
	 * @param model
	 * @param id
	 * @return model.addAttribute("choosedAnswerList", choosedAnswerList);
	 * @throws Exception
	 */
	@RequestMapping(value = "/answerListByContest")
	@JsonView(BaseJsonView.Summary.class)
	public Model answerListByContest(Model model, Long id) throws Exception {
		List<Contest> choosedAnswerList = service.getAnswerListByContest(id);

		return model.addAttribute("choosedAnswerList", choosedAnswerList);
	}
	
	/**
	 * 포인트 분배 - 답변자 선택 시, 답변과 추가질문답변 반환
	 *
	 * @param model
	 * @param id
	 * @param groupId
	 * @return model.addAttribute("allBychoosedAnswer", allBychoosedAnswer);
	 * @throws Exception
	 */
	@RequestMapping(value = "/allListByChoosedAnswer")
	@JsonView(BaseJsonView.Summary.class)
	public Model allListByChoosedAnswer(Model model, Long id, Long groupId) throws Exception {
		List<Contest> allBychoosedAnswer = service.getAllListByChoosedAnswer(id, groupId);

		return model.addAttribute("allBychoosedAnswer", allBychoosedAnswer);
	}
	
	/**
	 * 포인트 분배 - 채택완료(평점 순위로 포인트를 분배한다. qa_item_point 테이블 update)
	 *
	 * @param model
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/completeChoose")
	@JsonView(BaseJsonView.Summary.class)
	public void completeChoose(Long groupId) throws Exception {
		List<Contest> choosedAnswerList = service.getAnswerListByContest(groupId);
		// 포인트 분배 후, 채택 완료 상태로 변경
		service.completeChoose(choosedAnswerList, groupId);
		// 채택 답변 수가 예정 채택수 보다 적을 경우 남은 포인트 회수
		service.payBackPoint(groupId);
		// qa_item_point 테이블에 answer_id가 null인 row 삭제
		service.completePoint(groupId);
	}

	/**
	 * 질문 등록
	 *
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)
	public void register(Contest client, BindingResult result) throws Exception {
		validator.validate(client, result);
		checkBindingResult(result);
		
		Contest server = service.loadOrCreate(client.getId());
		service.update(server, client);
		service.register(server);
		service.insertPoint(server, Point.REGISTERED_TYPE);

		reply.setStepPos(server);
		reply.increaseParentRplyCnt(server);
		reply.checkParentExists(server);
		
		service.eventNotify(server, server.getPosition());
		if(server.getPosition() > 0){
			query.updateIsRead(server.getGroupId(), server.getId(), "R");	
		}
	}

	/**
	 * 카테고리 목록
	 *
	 * @param model
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/categoryList")
	@JsonView(BaseJsonView.Summary.class)
	public Model categoryList(Model model) throws Exception {
		// QueryResults<Category> result = query.getCategoryList();
		// return model.addAttribute("list", result.getResults());

		List<Category> result = query.getCategoryListByNativeQuery();
		return model.addAttribute("list", result);
	}
	
	@RequestMapping(value = "/subCategoryList")
	@JsonView(BaseJsonView.Summary.class)
	public Model subCategoryList(Long pid, Model model) throws Exception {
		List<Category> result = query.getSubCategoryListByNativeQuery(pid);
		return model.addAttribute("list", result);
	}

	/**
	 * 질문 조회 - 등록자 혹은 답변자 여부에 따른 화면 분기
	 * 
	 * @param id
	 * @param m
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/read")
	@JsonView(BaseJsonView.Detail.class)
	public Model read(Long id, Model model) throws Exception {
		boolean isLogin = UserService.getUser().getMemberId() != null ? true : false;
		boolean isOwner = service.checkOwner(id);
		boolean isAnswer = service.checkAnswer(id);

		Contest server = repository.findOne(id);
		read.read(null, server);
		model.addAttribute("item", server);
		
		if (isLogin && isOwner) {
			model.addAttribute("isOwner", isOwner);
		} else if (isLogin && isAnswer) {
			model.addAttribute("isAnswer", isAnswer);
		}

		return model;
	}
	
	/**
	 * 질문 조회(SNS용) - 등록자 혹은 답변자 여부에 따른 화면 분기
	 * 
	 * @param id
	 * @param m
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/snsRead")
	@JsonView(BaseJsonView.Detail.class)
	public Model snsRead(Long id, Model model) throws Exception {
		boolean isLogin = UserService.getUser().getMemberId() != null ? true : false;
		boolean isOwner = service.checkOwner(id);
		boolean isAnswer = service.checkAnswer(id);

		Contest server = repository.findOne(id);
		read.read(null, server);
		
		model.addAttribute("item", server);
		model.addAttribute("isLogin", isLogin);
		
		if (isLogin && isOwner) {
			model.addAttribute("isOwner", isOwner);
		} else if (isLogin && isAnswer) {
			model.addAttribute("isAnswer", isAnswer);
		}

		return model;
	}

	/**
	 * 답변현황상세
	 * 
	 * @param id
	 * @param model
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/answerRead")
	@JsonView(BaseJsonView.Detail.class)
	public Model answerRead(Long id, Model model) throws Exception {
		Contest server = repository.findOne(id);
		List<Contest> replyList = query.getAnswerView(id);
		permission.checkOwner(replyList.get(0));
		//query.updateIsRead(id, replyList.get(0).getAnswerGroupId(), "A");
		model.addAttribute("item", server);
		model.addAttribute("replyList", replyList);
		return model;
	}

	/**
	 * 질문현황상세
	 * 
	 * @param page
	 * @param id
	 * @param model
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/questionRead")
	@JsonView(BaseJsonView.Detail.class)
	public Model questionRead(Pageable page, Long id, Model model) throws Exception {
		Contest server = repository.findOne(id);
		permission.checkOwner(server);
		long choosedCount = service.getChoosedCount(id);
		QueryResults<Tuple> replyList = query.getQuestionView(page, id);

		List<Object[]> viewList = new ArrayList<>();

		for (int i = 0; i < replyList.getResults().size(); i++) {
			viewList.add(i, replyList.getResults().get(i).toArray());
		}
		model.addAttribute("item", server);
		model.addAttribute("replyList", viewList);
		model.addAttribute("count", replyList.getTotal());
		model.addAttribute("choosedCount", choosedCount);
		return model;
	}

	/**
	 * 질문현황상세 리스트
	 * 
	 * @param groupId
	 * @param id
	 * @param model
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/questionAllRead")
	@JsonView(BaseJsonView.Detail.class)
	public Model questionAllRead(Long groupId, Long id, Model model) throws Exception {
		Contest server = repository.findOne(groupId);
		permission.checkOwner(server);
		//query.updateIsRead(groupId, id, "Q");
		List<Contest> replyList = query.getQuestionAllView(groupId, id);
		boolean canChoose = service.getCanChoose(server.getChooseCount(), groupId);

		model.addAttribute("item", server);
		model.addAttribute("replyList", replyList);
		model.addAttribute("canChoose", canChoose);
		return model;
	}

	@RequestMapping(value = "/isRead", method = RequestMethod.GET)
	@JsonView(BaseJsonView.Detail.class)
	public void isRead(Long groupId, Long id, String mode) throws Exception {
		query.updateIsRead(groupId, id, mode);
	}
	
	/**
	 * 첨부파일 불러오기
	 * 
	 * @param id
	 * @param model
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/readFile")
	@JsonView(BaseJsonView.Detail.class)
	public Model readFile(Long id, Model model) throws Exception {
		List<Contest.Attachment> server = query.getFileList(id);

		model.addAttribute("item", server);
		return model;
	}

	/**
	 * 평점 주기
	 * 
	 * @param id
	 * @param gradePoint
	 * @param model
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/gradePoint", method = RequestMethod.GET)
	@JsonView(BaseJsonView.Detail.class)
	public Model gradePoint(Long id, int gradePoint, Model model) throws Exception {
		// 성공 1 데이터가 없으면 0
		model.addAttribute("message", query.gradePoint(id, gradePoint));
		return model;
	}

	/**
	 * 관심등록/해제
	 * 
	 * @param id
	 * @param favorite
	 * @param model
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/favorite", method = RequestMethod.GET)
	@JsonView(BaseJsonView.Detail.class)
	public Model favorite(Long id, boolean favorite, Model model) throws Exception {
		// 성공 1 데이터가 없으면 0
		model.addAttribute("message", query.favorite(id, favorite));
		return model;
	}

	/**
	 * 채택
	 * 
	 * @param id
	 * @param groupId
	 * @param model
	 * @return model
	 * @throws Exception
	 */
	@RequestMapping(value = "/clauseAgree", method = RequestMethod.GET)
	@JsonView(BaseJsonView.Detail.class)
	public Model clauseAgree(Long id, Long groupId, Model model) throws Exception {
		Contest server = repository.findOne(id);
		Contest parent = repository.findOne(groupId);
		
		if (!(service.getCanChoose(parent.getChooseCount(), groupId))) {
			throw new ContestException.DenyChooseException();
		}		
		
		// 성공 1 데이터가 없으면 0
		model.addAttribute("message", query.clauseAgree(id, groupId));
		publisher.broadcast(new ContestEvent.Choose(server));
		
		return model;
	}

	/**
	 * 질문취소
	 * 
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/cancel", method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)
	public void cancel(Contest client, BindingResult result) throws Exception {
		// validator.validate(client, result);
		checkBindingResult(result);
		Contest server = repository.findOne(client.getId());
		permission.checkOwner(server);
		service.cancel(server, client);
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
	
	/**
	 * 첨부파일 다운로드 
	 *
	 * @param request
	 * @param response
	 * @param id
	 * @throws Exception
	 */
	@RequestMapping(value = "/chooseCount")
	@ResponseBody
	public Model chooseCount(HttpServletRequest request, HttpServletResponse response, Long id, Model model) throws Exception {
		long chooseCount = service.getChooseCount();
		model.addAttribute("chooseCount", chooseCount);
		return model;
	}
	
	@RequestMapping(value = "/myContests")
	@JsonView(BaseJsonView.Summary.class)
	public Model myContests(Model model) throws Exception{
		List<Contest> myOngoingContestList = query.getOngoingMyListByNativeQuery(); //진행중인 나의 질문 목록
		List<Contest> myOngoingAnswerList = query.getOngoingMyAnswerListByNativeQuery(); //진행중인 나의 답변 목록
		return model.addAttribute("myOngoingContestList", myOngoingContestList).addAttribute("myOngoingAnswerList", myOngoingAnswerList);
	}
	
	
}
