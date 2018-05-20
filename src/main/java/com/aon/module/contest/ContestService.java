package com.aon.module.contest;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.aon.doc.file.AttachmentManager;
import com.aon.lib.event.EventPublisher;
import com.aon.lib.tree.Node;
import com.aon.lib.tree.NodeVisitor;
import com.aon.module.contest.Contest.Attachment;
import com.aon.module.contest.Contest.Points;
import com.aon.module.cyberaccount.CyberAccountService;
import com.aon.module.cyberaccount.point.Point;
import com.aon.sys.category.CategoryCache;
import com.aon.sys.usr.UserService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author ranian
 * 정보거래 service class
 */
@Service
public class ContestService {

	@Autowired
	private AttachmentManager<Attachment> attachment;

	@Autowired
	private IContestRepository repository;

	@Autowired
	private EventPublisher publisher;

	@Autowired
	private ContestQuery query;
	
	@Autowired
	private CyberAccountService cyberAccountService ;

	/**
	 * 정보거래 객체를 생성한다.
	 *
	 * @param id
	 * @return repository.loadWithLock(id)
	 */
	public Contest loadOrCreate(Long id) {
		if (id == null) {
			return repository.create(new Contest());
		}
		return repository.loadWithLock(id);
	}
	
	public void eventNotify(Contest server, int position) throws Exception {
		if (position == 0) {
			publisher.broadcast(new ContestEvent.Create(server));
		} else if (position == 1) {
			publisher.broadcast(new ContestEvent.RegistedAnswer(server));
		} else if ((position > 1) && ((position % 2) == 0)) {
			publisher.broadcast(new ContestEvent.AdditionalQuestion(server));
		} else if ((position > 1) && ((position % 2) != 0)) {
			publisher.broadcast(new ContestEvent.AdditionalAnswer(server));
		}
	}

	/**
	 * 질문 글을 등록한다.
	 *
	 * @param server
	 * @throws Exception
	 */
	public void register(Contest server) throws Exception {

		server.setRegisterUser(UserService.getUser());
		server.setInsertDate(new Date());
		server.setUpdateDate(new Date());
		server.setStatus(Contest.REGISTERED_STATUS);
		server.setRead(true);
		publisher.broadcast(new ContestEvent.Create(server));
	}

	/**
	 * 작성된 질문 내용을 server에 update한다.
	 *
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	public void update(Contest server, Contest client) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		String pointRatio = client.getPointRatio() == null ? "" : client.getPointRatio().replace("&quot;", "\"");
        JsonNode results = pointRatio != "" ? objectMapper.readTree(pointRatio) : null;
        
		server.setTitle(client.getTitle());
		server.setContent(client.getContent());
		server.setPoint(client.getPoint());
		server.setExpireDate(client.getExpireDate());
		server.updateAttachments(attachment.update(client.getAttachments(), server));
		updateCategories(server, client);
		server.setGroupId(client.getGroupId());
		server.setAnswerGroupId(client.getAnswerGroupId());
		server.setParentId(client.getParentId());
		server.setChooseCount(client.getChooseCount());
		server.setShareType(pointRatio == "" ? 1 : Integer.parseInt(results.path("equal").toString()));
		server.setPointRatio(pointRatio);
		
		if (server.getId() == server.getGroupId()) {
			updatePoints(server, client, results);
		}
	}
	
	/**
	 * 질문 등록, 질문 취소 등의 행위가 발생한 뒤 가상계좌의 point 처리를 진행한다.
	 *
	 * @param server
	 * @param type
	 * @throws Exception
	 */
	public void insertPoint(Contest server, int type) throws Exception {
		cyberAccountService.insertPoint(type, server.getId(), server.getPoint(), server.getRegisterUser().getMemberId());
	}
	
	/**
	 * 질문 채택 행위가 발생한 뒤 가상계좌의 point 처리를 진행한다.
	 *
	 * @param server
	 * @param point
	 * @param type
	 * @throws Exception
	 */
	public void insertPoint(Contest server, long point, int type) throws Exception {
		cyberAccountService.insertPoint(type, server.getId(), point, server.getRegisterUser().getMemberId());
	}

	/**
	 * 카테고리 정보를 update 한다.
	 *
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	private static void updateCategories(Contest server, Contest client) throws Exception {
		server.setCategories(client.getCategories());
		server.updateFolderLevel();
	}
	
	/**
	 * 질문 등록 시, 채택 예정 건수 만큼 포인트 분배 테이블에 row를 생성한다.
	 *
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	public void updatePoints(Contest server, Contest client, JsonNode results) throws Exception {
		Contest.Points points;
		List<Points> pointsList = new ArrayList<Points>();
		
		for (int i=0; i<results.path("data").size(); i++) {
			points = new Contest.Points();
			points.setPointRatio(Integer.parseInt(results.path("data").get(i).get("value").toString()));
			points.setInsertDate(new Date());
			points.setUpdateDate(new Date());
			pointsList.add(i, points);
			server.setPoints(pointsList);
		}
	}
	
	public void updateCategoriesByListener(Long categoryId, List<Node> l) throws Exception {
		int result = query.updateCategoryLevel(categoryId, l);
	}
	
	public boolean getCanChoose(int chooseCount, Long groupId) throws Exception {
		long choosedCount = query.getChooseCount(groupId);
		int count = chooseCount - (int)choosedCount;
		
		return (count > 0) ? true : false;
	}
	
	public long getChoosedCount(Long groupId) throws Exception {
		return query.getChooseCount(groupId);
	}
	
	/**
	 * 포인트 분배 - 특정 정보거래 글의 채택된 전체 답변 목록
	 *
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public List<Contest> getAnswerListByContest(Long id) throws Exception {
		return query.getAnswerListByContest(id);
	}
	
	/**
	 * 포인트 분배 - 답변자 선택 시, 답변과 추가질문답변 반환
	 *
	 * @param id
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	public List<Contest> getAllListByChoosedAnswer(Long id, Long groupId) throws Exception {
		return query.getQuestionAllView(groupId, id);
	}
	
	/**
	 * 포인트 분배 - 채택 완료 버튼 클릭시, 포인트를 지급한다.
	 *
	 * @param answers
	 * @param groupId
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public void completeChoose(List<Contest> answers, Long groupId) throws Exception {
		long point = 0;
		for (int i=0; i<answers.size(); i++) {
			query.updatePoint(answers.get(i), i);
			point = query.getPoint(answers.get(i).getGroupId(), answers.get(i).getId());
			insertPoint(answers.get(i), point, Point.CHOSE_TYPE);
			publisher.broadcast(new ContestEvent.PointByChoosed(answers.get(i)));
		}
		long changeStatus = query.completeContest(groupId);
	}
	
	/**
	 * 채택 답변 수가 예정 채택수 보다 적을 경우 질문작성자에게 남은 포인트 반환 처리
	 *
	 * @param groupId
	 * @throws Exception
	 */
	public void payBackPoint(Long groupId) throws Exception {
		// 질문글 작성자 정보
		Contest contest = repository.findOne(groupId); 
		// qa_item_point 테이블에 answer_id가 null인 point_share값의 합이 0보다 클 경우 질문 작성자에게 남은 포인트 반환
		int sum = query.getPaybackPointSum(groupId);
		if (sum > 0) {
			insertPoint(contest, sum, Point.CHOOSED_PAYBACK_TYPE);
		}
		//채택완료 알림처리(질문 작성자에게)
		publisher.broadcast(new ContestEvent.CompleteChoose(contest));
	}
	
	public void completePoint(Long groupId) throws Exception {
		query.completePoint(groupId);
	}
	
	/**
	 * 경고 시 상태(status)변경 - admin
	 *
	 * @param seq
	 * @param warnContent
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public void editStatusByWarn(Contest server) throws Exception {
		server.setStatus(Contest.WARNING_STATUS);
		server.setUpdateDate(new Date());
	}

	/**
	 * 공모 취소 시 상태(status)변경 - admin
	 *
	 * @param seq
	 * @param warnContent
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public void cancelContest(Contest server) throws Exception {
		server.setStatus(Contest.CANCEL_STATUS);
		server.setUpdateDate(new Date());
		insertPoint(server, Point.CANCLEED_TYPE);
	}

	/**
	 * 질문 작성자 여부를 반환한다
	 *
	 * @param id
	 * @return true or false
	 * @throws Exception
	 */
	public boolean checkOwner(Long id) throws Exception {
		return query.checkOwner(id).size() > 0 ? true : false;
	}

	/**
	 * 질문에 대한 답변자 여부를 반환한다.
	 *
	 * @param id
	 * @return true or false
	 * @throws Exception
	 */
	public boolean checkAnswer(Long id) throws Exception {
		return query.checkAnswer(id).size() > 0 ? true : false;
	}
	
	/**
	 * 질문 작성자에 의해 질문취소 신청중 상태로 변경한다.
	 *
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	public void cancel(Contest server, Contest client) throws Exception {
		server.setStatus(Contest.CANCEL_READY_STATUS);
		server.setCancelReason(client.getCancelReason());
		server.setUpdateDate(new Date());
	}
	
	/**
	 * 계정의 확인하지 않은 답변 카운트
	 * 
	 * @return
	 * @throws Exception
	 */
	public long questionIsRead() throws Exception {
		return query.questionIsRead();
	}
	
	/**
	 * 계정의 확인하지 않은 질문 카운트
	 * 
	 * @return
	 * @throws Exception
	 */
	public long answerIsRead() throws Exception {
		return query.answerIsRead();
	}
	
	/**
	 * 채택건수를 반환한다.
	 *
	 * @return query.getChooseCount()
	 * @throws Exception
	 */
	public long getChooseCount() throws Exception {
		return query.getChooseCount();
	}
	
	/**
	 * categoryId의 분류에 속한 글의 개수를 반환한다.
	 *
	 * @param categoryId
	 * @return
	 * @throws Exception
	 */
	public List<Object> getContentsCount(Long categoryId) throws Exception {
		return query.getContentsCount(categoryId);
	}
	
	public void moveContents(Long categoryId, Long targetId) throws Exception {
		List<Node> l = new LinkedList<Node>();
		
		CategoryCache.visitAncestorsOrSelf(targetId, new NodeVisitor()
		{
			public void visit(Node node)
			{
				l.add(node);
			}
		});
		
		int result = query.updateCategory(categoryId, targetId, l);
	}
}
