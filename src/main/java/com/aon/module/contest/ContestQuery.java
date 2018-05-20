package com.aon.module.contest;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.lib.tree.Node;
import com.aon.module.contest.Contest.Attachment;
import com.aon.sys.category.Category;
import com.aon.sys.category.QCategory;
import com.aon.sys.usr.UserService;
import com.querydsl.core.QueryResults;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.Expression;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

/**
 * @author ranian 정보거래 관련 query
 */
@Service
public class ContestQuery extends Query {
	 
	/**
	 * 정보거래 목록 (query dsl)
	 *
	 * @param page
	 * @param searchKey
	 * @param searchValue
	 * @param catSeq
	 * @return query.fetchResults()
	 * @throws Exception
	 */
	public QueryResults<Contest> getList(Pageable page, String searchKey, String searchValue, int catSeq)
			throws Exception {
		QContest contest = QContest.contest;
		JPAQuery<?> query = getQuery();

		return query
				.select(Projections.fields(Contest.class, contest.id, contest.title, contest.content, contest.choose,
						contest.point, contest.expireDate))
				.from(contest).orderBy(contest.id.desc()).offset(page.getOffset()).limit(page.getPageSize())
				.fetchResults();
	}

	/**
	 * 정보거래 목록 (native query)
	 *
	 * @param page
	 * @param searchKey
	 * @param searchValue
	 * @param catSeq
	 * @return query.getResultList()
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getListByNativeQuery(Pageable page, String searchKey, String searchValue, String catSeq)
			throws Exception {
		List<Contest> resultList;
		String query = "select q.qa_id as id, q.title as title, q.content as content, "
				+ "	q.is_choose as choose, q.point as point, q.expire_Date as expireDate, pc.category_name as categoryParent, sc.category_name as categoryName, c.tag as categoryTag "
				+ ", ( select count(qi.qa_id) from qa_item qi " 
				+ "		where qi.group_id = q.qa_id "
				+ "		and qi.position = 1 ) as answer_count "
				+ ", pc.category_id as categoryParentId, sc.category_id as categoryId "
				+ "from qa_item q " 
				+ "left outer join qa_item_category c on q.qa_id = c.qa_id "
				+ "left outer join sa_category sc on c.category_id = sc.category_id "
				+ "left outer join sa_category pc on sc.parent_id = pc.category_id and pc.category_id > 1 and pc.category_id > 1 "
				+ "left outer join hr_member m on q.member_id = m.member_id " 
				+ "where q.step = 0 "
				+ "and (q.status = ? or q.status = ? or q.status = ?) ";

		if (catSeq != null && !(catSeq.equals("0"))) {
			query += "and c.level2 = ? ";

			if (searchValue != null && !(searchValue.equals(""))) {
				if (searchKey.equals("title")) {
					query += "and q.title like ? ";
				} else if (searchKey.equals("qaId")) {
					query += "and q.qa_id = ? ";
				} else {
					query += "and m.nickname like ? ";
				}

				query += "order by q.qa_id desc ";

				resultList = createNativeQuery(query).setParameter(1, Contest.REGISTERED_STATUS)
						.setParameter(2, Contest.CANCEL_READY_STATUS)
						.setParameter(3, Contest.EXPIRED_STATUS)
						.setParameter(4, Long.parseLong(catSeq))
						.setParameter(5, !searchKey.equals("qaId") ? "%" + searchValue + "%" : searchValue)
						.setFirstResult(page.getOffset()).setMaxResults(page.getPageSize()).getResultList();
			} else {
				query += "order by q.qa_id desc ";

				resultList = createNativeQuery(query).setParameter(1, Contest.REGISTERED_STATUS)
						.setParameter(2, Contest.CANCEL_READY_STATUS)
						.setParameter(3, Contest.EXPIRED_STATUS)
						.setParameter(4, Long.parseLong(catSeq))
						.setFirstResult(page.getOffset()).setMaxResults(page.getPageSize()).getResultList();
			}
		} else {
			if (searchValue != null && !(searchValue.equals(""))) {
				if (searchKey.equals("title")) {
					query += "and q.title like ? ";
				} else if (searchKey.equals("qaId")) {
					query += "and q.qa_id = ? ";
				} else {
					query += "and m.nickname like ? ";
				}

				query += "order by q.qa_id desc ";

				resultList = createNativeQuery(query).setParameter(1, Contest.REGISTERED_STATUS)
						.setParameter(2, Contest.CANCEL_READY_STATUS)
						.setParameter(3, Contest.EXPIRED_STATUS)
						.setParameter(4, !searchKey.equals("qaId") ? "%" + searchValue + "%" : searchValue)
						.setFirstResult(page.getOffset())
						.setMaxResults(page.getPageSize())
						.getResultList();
			} else {
				query += "order by q.qa_id desc ";

				resultList = createNativeQuery(query).setParameter(1, Contest.REGISTERED_STATUS)
						.setParameter(2, Contest.CANCEL_READY_STATUS)
						.setParameter(3, Contest.EXPIRED_STATUS)
						.setFirstResult(page.getOffset())
						.setMaxResults(page.getPageSize())
						.getResultList();
			}
		}

		return resultList;
	}

	/**
	 * mypage 나의질문현황 목록 (native query)
	 *
	 * @param page
	 * @param searchKey
	 * @param searchValue
	 * @return resultList.getResultList()
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getMyListByNativeQuery(Pageable page, String searchKey, String searchValue, boolean unconfirmed) throws Exception {
		List<Contest> resultList;
		String query = "select q.qa_id as id, q.title as title, q.content as content, "
				+ "	q.is_choose as choose, q.point as point, q.expire_Date as expireDate, pc.category_name as categoryParent, sc.category_name as categoryName, c.tag as categoryTag, "
				+ " ( select count(qi.qa_id) from qa_item qi " 
				+ "		where qi.group_id = q.qa_id "
				+ "		and qi.position = 1 ) as answer_count " 
				+ "from qa_item q "
				+ "left outer join qa_item_category c on q.qa_id = c.qa_id "
				+ "left outer join sa_category sc on c.category_id = sc.category_id "
				+ "left outer join sa_category pc on sc.parent_id = pc.category_id and pc.category_id > 1 "
				+ "where q.step = 0 "
				+ "and q.member_id = ? ";
		
		if(unconfirmed){
			query += "and q.qa_id in ( " 
					+ "		select distinct(qi.group_id) " 
					+ "		from qa_item qi "
					+ "		where qi.position > 0 " 
					+ " 	and qi.is_read = 0 " 
					+ "		and qi.member_id <> q.member_id " 
					+ "	) ";
		}

		if (searchValue != null && !(searchValue.equals(""))) {
			if (searchKey.equals("title")) {
				query += "and q.title like ? ";
			} else {
				query += "and q.qa_id = ? ";
			}

			query += "order by q.is_choose asc, q.qa_id desc ";

			resultList = createNativeQuery(query)
					.setParameter(1, UserService.getUser().getMemberId())
					.setParameter(2, searchKey.equals("title") ? "%" + searchValue + "%" : searchValue)
					.setFirstResult(page.getOffset())
					.setMaxResults(page.getPageSize())
					.getResultList();
		} else {
			query += "order by q.qa_id desc, q.is_choose asc";

			resultList = createNativeQuery(query)
					.setParameter(1, UserService.getUser().getMemberId())
					.setFirstResult(page.getOffset())
					.setMaxResults(page.getPageSize())
					.getResultList();
		}

		return resultList;
	}

	/**
	 * mypage 나의답변현황 목록 (native query)
	 *
	 * @param page
	 * @param searchKey
	 * @param searchValue
	 * @return resultList.getResultList()
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getMyAnswerListByNativeQuery(Pageable page, String searchKey, String searchValue, boolean unconfirmed)
			throws Exception {
		List<Contest> resultList;
		String query = "select q.qa_id as id, q.title as title, q.content as content, "
				+ "	q.is_choose as choose, q.point as point, q.expire_Date as expireDate, pc.category_name as categoryParent, sc.category_name as categoryName, c.tag as categoryTag, "
				+ " ( select count(qi.qa_id) from qa_item qi " 
				+ "		where qi.group_id = q.qa_id "
				// + " and qi.qa_id <> qi.group_id "
				+ "		and qi.position = 1 ) as answer_count " 
				+ "from qa_item q "
				+ "left outer join qa_item_category c on q.qa_id = c.qa_id "
				+ "left outer join sa_category sc on c.category_id = sc.category_id "
				+ "left outer join sa_category pc on sc.parent_id = pc.category_id and pc.category_id > 1 "
				+ "where q.position = 0 "
				+ "and q.member_id <> ? "
				+ "and q.qa_id in ( " 
				+ "		select distinct(qi.group_id) " 
				+ "		from qa_item qi "
				+ "		where qi.position > 0 ";
		
		if(unconfirmed){
			query += " 	and qi.is_read = 0 " 
					+ "		and qi.member_id <> ? " 
					+ "	) ";
		}else{
			query += " 	and qi.member_id = ? " 
					+ "	) ";
		}
		
		if (searchValue != null && !(searchValue.equals(""))) {
			if (searchKey.equals("title")) {
				query += "and q.title like ? ";
			} else {
				query += "and q.qa_id = ? ";
			}

			
			
			query += "order by q.is_choose asc, q.qa_id desc ";

			resultList = createNativeQuery(query)
					.setParameter(1, UserService.getUser().getMemberId())
					.setParameter(2, UserService.getUser().getMemberId())
					.setParameter(3, searchKey.equals("title") ? "%" + searchValue + "%" : searchValue)
					.setFirstResult(page.getOffset())
					.setMaxResults(page.getPageSize())
					.getResultList();
		} else {
			query += "order by q.is_choose asc, q.qa_id desc ";

			resultList = createNativeQuery(query)
					.setParameter(1, UserService.getUser().getMemberId())
					.setParameter(2, UserService.getUser().getMemberId())
					.setFirstResult(page.getOffset())
					.setMaxResults(page.getPageSize())
					.getResultList();
		}

		return resultList;
	}

	/**
	 * 정보거래 목록 개수 (native query)
	 *
	 * @param page
	 * @param searchKey
	 * @param searchValue
	 * @param catSeq
	 * @return resultList.getResultList()
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getTotalCountByNativeQuery(Pageable page, String searchKey, String searchValue, String catSeq)
			throws Exception {
		List<Contest> resultList;
		String query = "select count(q.qa_id) as count " 
				+ "from qa_item q "
				+ "left outer join qa_item_category c on q.qa_id = c.qa_id "
				+ "left outer join hr_member m on q.member_id = m.member_id " 
				+ "where q.step = 0 "
				+ "and q.parent_id is null " 
				+ "and (q.status = ? or q.status = ? or q.status = ?) ";

		if (catSeq != null && !(catSeq.equals("0"))) {
			query += "and c.level2 = ? ";

			if (searchValue != null && !(searchValue.equals(""))) {
				if (searchKey.equals("title")) {
					query += "and q.title like ? ";
				} else if (searchKey.equals("qaId")) {
					query += "and q.qa_id = ? ";
				} else {
					query += "and m.nickname like ? ";
				}

				resultList = createNativeQuery(query).setParameter(1, Contest.REGISTERED_STATUS)
						.setParameter(2, Contest.CANCEL_READY_STATUS)
						.setParameter(3, Contest.EXPIRED_STATUS)
						.setParameter(4, Long.parseLong(catSeq))
						.setParameter(5, !searchKey.equals("qaId") ? "%" + searchValue + "%" : searchValue)
						.getResultList();
			} else {
				resultList = createNativeQuery(query).setParameter(1, Contest.REGISTERED_STATUS)
						.setParameter(2, Contest.CANCEL_READY_STATUS)
						.setParameter(3, Contest.EXPIRED_STATUS)
						.setParameter(4, Long.parseLong(catSeq))
						.getResultList();
			}
		} else {
			if (searchValue != null && !(searchValue.equals(""))) {
				if (searchKey.equals("title")) {
					query += "and q.title like ? ";
				} else if (searchKey.equals("qaId")) {
					query += "and q.qa_id = ? ";
				} else {
					query += "and m.nickname like ? ";
				}

				resultList = createNativeQuery(query).setParameter(1, Contest.REGISTERED_STATUS)
						.setParameter(2, Contest.CANCEL_READY_STATUS)
						.setParameter(3, Contest.EXPIRED_STATUS)
						.setParameter(4, !searchKey.equals("qaId") ? "%" + searchValue + "%" : searchValue)
						.getResultList();
			} else {
				resultList = createNativeQuery(query).setParameter(1, Contest.REGISTERED_STATUS)
						.setParameter(2, Contest.CANCEL_READY_STATUS)
						.setParameter(3, Contest.EXPIRED_STATUS)
						.getResultList();
			}
		}

		return resultList;
	}

	/**
	 * mypage 나의질문현황 목록 개수 (native query)
	 *
	 * @param page
	 * @param searchKey
	 * @param searchValue
	 * @return resultList.getResultList()
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getMyTotalCountByNativeQuery(Pageable page, String searchKey, String searchValue, boolean unconfirmed)
			throws Exception {
		List<Contest> resultList;
		String query = "select count(q.qa_id) " 
				+ "from qa_item q " 
				+ "where q.step = 0 " 
				+ "and q.member_id = ? ";

		if(unconfirmed){
			query += "and q.qa_id in ( " 
					+ "		select distinct(qi.group_id) " 
					+ "		from qa_item qi "
					+ "		where qi.position > 0 " 
					+ " 	and qi.is_read = 0 " 
					+ "		and qi.member_id <> q.member_id " 
					+ "	) ";
		}
		
		if (searchValue != null && !(searchValue.equals(""))) {
			if (searchKey.equals("title")) {
				query += "and q.title like ? ";
			} else {
				query += "and q.qa_id = ? ";
			}

			resultList = createNativeQuery(query)
					.setParameter(1, UserService.getUser().getMemberId())
					.setParameter(2, searchKey.equals("title") ? "%" + searchValue + "%" : searchValue)
					.getResultList();
		} else {
			resultList = createNativeQuery(query)
					.setParameter(1, UserService.getUser().getMemberId())
					.getResultList();
		}

		return resultList;
	}

	/**
	 * mypage 나의답변현황 목록 개수 (native query)
	 *
	 * @param page
	 * @param searchKey
	 * @param searchValue
	 * @return resultList.getResultList()
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getMyAnswerTotalCountByNativeQuery(Pageable page, String searchKey, String searchValue, boolean unconfirmed)
			throws Exception {
		List<Contest> resultList;
		String query = "select count(q.qa_id) " 
				+ "from qa_item q " 
				+ "where q.position = 0 "
				+ "and q.member_id <> ? "
				+ "and q.qa_id in ( "
				+ "		select distinct(qi.group_id) " 
				+ "		from qa_item qi " 
				+ "		where qi.position > 0 ";

		if(unconfirmed){
			query += " 	and qi.is_read = 0 " 
					+ "		and qi.member_id <> ? " 
					+ "	) ";
		}else{
			query += " 	and qi.member_id = ? " 
					+ "	) ";
		}
		
		if (searchValue != null && !(searchValue.equals(""))) {
			if (searchKey.equals("title")) {
				query += "and q.title like ? ";
			} else {
				query += "and q.qa_id = ? ";
			}
			
			resultList = createNativeQuery(query)
					.setParameter(1, UserService.getUser().getMemberId())
					.setParameter(2, UserService.getUser().getMemberId())
					.setParameter(3, searchKey.equals("title") ? "%" + searchValue + "%" : searchValue)
					.getResultList();
		} else {
			resultList = createNativeQuery(query)
					.setParameter(1, UserService.getUser().getMemberId())
					.setParameter(2, UserService.getUser().getMemberId())
					.getResultList();
		}

		return resultList;
	}

	/**
	 * 카테고리 목록 (query dsl)
	 *
	 * @return query.fetchResults()
	 * @throws Exception
	 */
	public QueryResults<Category> getCategoryList() throws Exception {
		QCategory category = QCategory.category;
		JPAQuery<?> query = getQuery();

		return query.select(Projections.fields(Category.class, category.id, category.name)).from(category)
				.where(category.parentId.isNull()).orderBy(category.id.asc()).fetchResults();
	}

	/**
	 * 카테고리 목록 (native query)
	 *
	 * @return resultList
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Category> getCategoryListByNativeQuery() throws Exception {
		String query = "select c.category_id, c.parent_id, c.root_id, c.category_name, ( "
				+ "	select count(q.qa_id) as count " 
				+ "	from qa_item_category qc, qa_item q "
				+ "	where qc.level2 = c.category_id " 
				+ " and q.qa_id = qc.qa_id " 
				+ " and q.step = 0 "
				+ " and (q.status = ? or q.status = ? or q.status = ?) " 
				+ "	 ) as count " 
				+ " from sa_category c "
				+ " where c.parent_id = 1 "
				+ " group by c.category_id, c.category_name " 
				+ " order by c.sort_order asc ";

		List<Category> resultList = createNativeQuery(query)
				.setParameter(1, Contest.REGISTERED_STATUS)
				.setParameter(2, Contest.CANCEL_READY_STATUS)
				.setParameter(3, Contest.EXPIRED_STATUS)
				.getResultList();

		return resultList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Category> getSubCategoryListByNativeQuery(Long pid) throws Exception {
		String query = "select c.category_id, c.parent_id, c.root_id, c.category_name "
				+ " from sa_category c "
				+ " where c.parent_id = ? "
				+ " order by c.sort_order asc ";

		List<Category> resultList = createNativeQuery(query).setParameter(1, pid).getResultList();

		return resultList;
	}
	
	/**
	 * 특정 정보거래 글의 채택된 답변 목록
	 *
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public List<Contest> getAnswerListByContest(Long id) throws Exception {
		QContest contest = QContest.contest;
		JPAQuery<?> query = getQuery();

		return query
				.select(Projections.fields(Contest.class, contest.id, contest.groupId, contest.parentId,
						contest.answerGroupId, contest.position, contest.title, contest.content, contest.step,
						contest.choose, contest.favorite, contest.gradePoint, contest.registerUser, contest.insertDate))
				.from(contest)
				.where(contest.parentId.eq(id).and(contest.choose.eq(true)))
				.orderBy(contest.gradePoint.desc()).fetch();
	}
	
	/**
	 * qa_item_point 테이블에 답변정보와 지급될 포인트를 update한다.
	 *
	 * @param answer
	 * @param rank
	 * @throws Exception
	 */
	public int updatePoint(Contest answer, int rank) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" update qa_item_point ");
		sb.append(" set answer_id = :answerId, point = point_ratio, update_date = :updateDate ");
		sb.append(" where qa_id = :qaId ");
		sb.append(" and rank = :rank ");
		
		return createNativeQuery(sb.toString())
				.setParameter("answerId", answer.getId())
				.setParameter("updateDate", new Date())
				.setParameter("qaId", answer.getGroupId())
				.setParameter("rank", rank)
				.executeUpdate();
	}
	
	/**
	 * 채택된 답변에 부여된 포인트를 반환한다.
	 *
	 * @param groupId
	 * @param answerId
	 * @return
	 * @throws Exception
	 */
	public int getPoint(Long groupId, Long answerId) throws Exception {
		String query = "select point "
				+ " from qa_item_point "
				+ " where qa_id = ? "
				+ " and answer_id = ? ";

		Object result = createNativeQuery(query)
					.setParameter(1, groupId)
					.setParameter(2, answerId)
					.getSingleResult();

		return Integer.parseInt(result.toString());
	}
	
	/**
	 * 채택완료 후, 잔여 포인트의 합계를 반환한다.
	 *
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	public int getPaybackPointSum(Long groupId) throws Exception {
		String query = "select sum(point_ratio) "
				+ " from qa_item_point "
				+ " where qa_id = ? "
				+ " and answer_id is null ";
		
		Object result = createNativeQuery(query)
				.setParameter(1, groupId)
				.getSingleResult();

	return Integer.parseInt(result.toString());
	}

	/**
	 * 답변 조회
	 *
	 * @param id
	 * @return query.fetch()
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getAnswerView(Long id) throws Exception {
		QContest contest = QContest.contest;
		JPAQuery<?> query = getQuery();

		return query
				.select(Projections.fields(Contest.class, contest.id, contest.groupId, contest.parentId,
						contest.answerGroupId, contest.position, contest.title, contest.content, contest.step,
						contest.choose, contest.favorite, contest.gradePoint, contest.registerUser, contest.insertDate))
				.from(contest)
				.where(contest.answerGroupId
						.eq((Expression<? super Long>) new JPAQuery().select(contest.id).from(contest)
								.where(contest.parentId.eq(id)
										.and(contest.position.eq(1)
												.and(contest.registerUser.memberId
														.eq(UserService.getUser().getMemberId()))))))
				.orderBy(contest.step.asc()).fetch();
	}

	/**
	 * 질문 조회
	 *
	 * @param page
	 * @param id
	 * @return query.fetchResults()
	 * @throws Exception
	 */
	public QueryResults<Tuple> getQuestionView(Pageable page, Long id) throws Exception {
		QContest contest = QContest.contest;
		QContest contestSub = new QContest("contestSub");
		JPAQueryFactory query = getQueryFactory();

		return query
				.select(contest.id, contest.groupId, contest.parentId, contest.answerGroupId, contest.position,
						contest.title, contest.content, contest.step, contest.choose, contest.favorite,
						contest.gradePoint, contest.registerUser, contest.insertDate,
						JPAExpressions.select(contestSub.id.count()).from(contestSub)
								.where(contestSub.answerGroupId.eq(contest.id)
										.and(contestSub.position.gt(1)
												.and(contestSub.registerUser.memberId
														.notIn(UserService.getUser().getMemberId())))))
				.from(contest).where(contest.parentId.eq(id).and(contest.position.eq(1)))
				.orderBy(contest.insertDate.asc()).offset(page.getOffset()).limit(page.getPageSize()).fetchResults();
	}

	/**
	 * 추가질문답변 전체 조회
	 *
	 * @param groupId
	 * @param id
	 * @return query.fetch()
	 * @throws Exception
	 */
	public List<Contest> getQuestionAllView(Long groupId, Long id) throws Exception {
		QContest contest = QContest.contest;
		JPAQuery<?> query = getQuery();

		return query
				.select(Projections.fields(Contest.class, contest.id, contest.groupId, contest.parentId,
						contest.answerGroupId, contest.position, contest.title, contest.content, contest.step,
						contest.choose, contest.favorite, contest.gradePoint, contest.registerUser, contest.insertDate))
				.from(contest).where(contest.answerGroupId.eq(id)).orderBy(contest.step.asc()).fetch();
	}

	/**
	 * 정보거래 파일 목록
	 *
	 * @param id
	 * @return query.fetch()
	 * @throws Exception
	 */
	public List<Attachment> getFileList(Long id) throws Exception {
		QContest_Attachment Attachment = QContest_Attachment.attachment;
		Contest server = new Contest();
		server.setId(id);
		JPAQuery<?> query = getQuery();

		return query
				.select(Projections.fields(Attachment.class, Attachment.id, Attachment.filename, Attachment.filesize,
						Attachment.path))
				.from(Attachment).where(Attachment.entity.eq(server)).orderBy(Attachment.id.asc()).fetch();
	}

	/**
	 * 질문 작성자 여부 체크
	 *
	 * @param id
	 * @return result
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> checkOwner(Long id) throws Exception {
		String query = "select q.qa_id from qa_item q " 
				+ "where q.member_id = ? " 
				+ "and q.qa_id = ? ";

		List<Contest> result = createNativeQuery(query)
				.setParameter(1, UserService.getUser().getMemberId())
				.setParameter(2, id)
				.getResultList();

		return result;
	}

	/**
	 * 답변자 여부 체크
	 *
	 * @param id
	 * @return result
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> checkAnswer(Long id) throws Exception {
		String query = "select q.qa_id from qa_item q " 
				+ "where q.member_id = ? " 
				+ "and q.group_id = ? "
				+ "and q.step > 0 ";

		List<Contest> result = createNativeQuery(query)
				.setParameter(1, UserService.getUser().getMemberId())
				.setParameter(2, id)
				.getResultList();

		return result;
	}

	/**
	 * 평가하기
	 *
	 * @param id
	 * @param gradePoint
	 * @return query.execute()
	 * @throws Exception
	 */
	public long gradePoint(Long id, int gradePoint) throws Exception {
		QContest contest = QContest.contest;
		JPAQueryFactory query = getQueryFactory();

		return query.update(contest).set(contest.gradePoint, gradePoint).set(contest.updateDate, new Date())
				.where(contest.id.eq(id)).execute();
	}

	/**
	 * 관심등록
	 *
	 * @param id
	 * @param favorite
	 * @return query.execute()
	 * @throws Exception
	 */
	public long favorite(Long id, Boolean favorite) throws Exception {
		QContest contest = QContest.contest;
		JPAQueryFactory query = getQueryFactory();

		return query.update(contest).set(contest.favorite, favorite).set(contest.updateDate, new Date())
				.where(contest.id.eq(id)).execute();
	}

	/**
	 * 채택하기
	 *
	 * @param id
	 * @param groupId
	 * @return query.execute()
	 * @throws Exception
	 */
	public long clauseAgree(Long id, Long groupId) throws Exception {
		QContest contest = QContest.contest;
		JPAQueryFactory query = getQueryFactory();

		return query.update(contest).set(contest.choose, true)
//				.set(contest.status, Contest.COMPLETE_STATUS)
				.set(contest.updateDate, new Date()).where(contest.id.in(id, groupId)).execute();
	}

	/**
	 * 채택완료 후, 정보거래 글을 완료상태로 변경한다.
	 *
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	public long completeContest(Long groupId) throws Exception {
		QContest contest = QContest.contest;
		JPAQueryFactory query = getQueryFactory();
		
		return query.update(contest)
					.set(contest.status, Contest.COMPLETE_STATUS)
					.set(contest.updateDate, new Date())
				.where(contest.id.eq(groupId))
				.execute();
	}
	
	public int completePoint(Long groupId) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" delete from qa_item_point ");
		sb.append(" where qa_id = :qaId ");
		sb.append(" and answer_id is null ");
		
		return createNativeQuery(sb.toString())
				.setParameter("qaId", groupId)
				.executeUpdate();
	}
	
	public void updateExpireStatus() throws Exception {
		QContest contest = QContest.contest;
		JPAQueryFactory query = getQueryFactory();
			
		query.update(contest).set(contest.status, Contest.EXPIRED_STATUS)
				.set(contest.updateDate, new Date())
				.where(contest.step.eq(0)
					.and(contest.status.ne(Contest.EXPIRED_STATUS)
					.and(contest.expireDate.lt(new Date()))))
				.execute();
	}

	public List<Contest> getExpectExpire() throws Exception {
		QContest contest = QContest.contest;
		JPAQuery<?> query = getQuery();

		return query
				.select(Projections.fields(Contest.class, contest.id, contest.groupId, contest.parentId,
						contest.answerGroupId, contest.position, contest.title, contest.content, contest.step,
						contest.choose, contest.favorite, contest.gradePoint, contest.registerUser, contest.insertDate, contest.expireDate))
				.from(contest)
				.where(contest.step.eq(0).and(contest.status.ne(Contest.EXPIRED_STATUS)).and(contest.expireDate.lt(new Date())))
				.orderBy(contest.expireDate.desc()).fetch();
	}
	
	/**
	 * 조회 여부 update
	 *
	 * @param groupId
	 * @param id
	 * @param mode
	 * @throws Exception
	 */
	public void updateIsRead(Long groupId, Long id, String mode) throws Exception {
		QContest contest = QContest.contest;
		JPAQueryFactory query = getQueryFactory();
		if (mode.equals("A")) {
			query.update(contest).set(contest.read, true).where(contest.answerGroupId.eq(groupId).or(contest.id.eq(id))
					.and(contest.registerUser.memberId.ne(UserService.getUser().getMemberId()))).execute();
		} else if (mode.equals("Q")) {
			query.update(contest).set(contest.read, true)
					.where(contest.id.eq(groupId)
							.or(contest.answerGroupId.eq(id)
									.and(contest.registerUser.memberId.ne(UserService.getUser().getMemberId()))))
					.execute();
		} else {
			query.update(contest).set(contest.read, false).where(contest.id.in(groupId, id)).execute();
		}
	}

	/**
	 * 질문 글 조회여부
	 *
	 * @return query.fetchCount()
	 * @throws Exception
	 */
	public long questionIsRead() throws Exception {
		QContest contest = QContest.contest;
		QContest innerContest = new QContest("A");
		QContest leftContest = new QContest("B");
		/* QContest contestSub = new QContest("contestSub"); */
		JPAQuery<?> query = getQuery();

		/*
		 * 기존 subquery 방식 return query.select(contest.id).from(contest)
		 * .where(contest.read.eq(false) .and(contest.position.ne(0)
		 * .and(contest.groupId.in(JPAExpressions.select(contestSub.id).from(
		 * contestSub) .where(contestSub.position.eq(0)
		 * .and(contestSub.registerUser.memberId
		 * .eq(UserService.getUser().getMemberId()))))))
		 * .and(contest.registerUser.memberId.ne(UserService.getUser().
		 * getMemberId()))) .fetchCount();
		 */
		query.from(contest);
		query.innerJoin(innerContest).on(contest.groupId.eq(innerContest.id));
		query.leftJoin(leftContest).on(contest.id.eq(leftContest.id));
		query.where(contest.read.eq(false));
		query.where(innerContest.position.eq(0));
		query.where(innerContest.registerUser.memberId.eq(UserService.getMemberId()));
		query.where(leftContest.registerUser.memberId.ne(UserService.getMemberId()));
		return query.fetchCount();
	}

	/**
	 * 답변 조회 여부
	 *
	 * @return query.fetchCount()
	 * @throws Exception
	 */
	public long answerIsRead() throws Exception {
		QContest contest = QContest.contest;
		QContest innerContest = new QContest("A");
		QContest leftContest = new QContest("B");
		/* QContest contestSub = new QContest("contestSub"); */
		JPAQuery<?> query = getQuery();

		/*
		 * 기존 subquery 방식 return query .select(contest.id) .from(contest)
		 * .where(contest.read.eq(false).and(contest.position.ne(0).and(contest.
		 * answerGroupId
		 * .in(JPAExpressions.select(contestSub.answerGroupId).from(contestSub).
		 * where(contestSub.position.eq(1).and(contestSub.registerUser.memberId.
		 * eq(UserService.getUser().getMemberId()))))))
		 * .and(contest.registerUser.memberId.ne(UserService.getUser().
		 * getMemberId()))) .fetchCount();
		 */
		query.from(contest);
		query.innerJoin(innerContest).on(contest.answerGroupId.eq(innerContest.id));
		query.leftJoin(leftContest).on(contest.id.eq(leftContest.id));
		query.where(contest.read.eq(false));
		query.where(innerContest.position.eq(1));
		query.where(innerContest.registerUser.memberId.eq(UserService.getMemberId()));
		query.where(leftContest.registerUser.memberId.ne(UserService.getMemberId()));
		return query.fetchCount();
	}

	/**
	 * 채택건수(사용자별)
	 *
	 * @return query.fetchCount()
	 * @throws Exception
	 */
	public long getChooseCount() throws Exception {
		QContest contest = QContest.contest;
		JPAQuery<?> query = getQuery();

		return query.select(contest.id).from(contest).where(
				contest.registerUser.memberId.eq(UserService.getUser().getMemberId()).and(contest.choose.eq(true)))
				.fetchCount();
	}
	
	/**
	 * 채택건수(문서별)
	 *
	 * @param groupId
	 * @return query.fetchCount()
	 * @throws Exception
	 */
	public long getChooseCount(Long groupId) throws Exception {
		QContest contest = QContest.contest;
		JPAQuery<?> query = getQuery();
		
		return query.select(contest.id).from(contest).where(
				contest.parentId.eq(groupId).and(contest.choose.eq(true)))
				.fetchCount();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> getContentsCount(Long categoryId) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select count(qa_id) as count ");
		sb.append("from qa_item_category ");
		sb.append("where category_id = ? ");

		return createNativeQuery(sb.toString()).setParameter(1, categoryId).getResultList();
	}

	/**
	 * 진행중인 나의 질문현황
	 *
	 * @return createNativeQuery.getResultList()
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getOngoingMyListByNativeQuery() throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append("select q.qa_id as id, q.title as title, q.content as content, ");
		sb.append(
				"	q.is_choose as choose, q.point as point, q.expire_Date as expireDate, pc.category_name as categoryParent, sc.category_name as categoryName, c.tag as categoryTag, ");
		sb.append(" ( select count(qi.qa_id) from qa_item qi ");
		sb.append("		where qi.group_id = q.qa_id ");
		sb.append("		and qi.position = 1 ) as answer_count ");
		sb.append("from qa_item q ");
		sb.append("left outer join qa_item_category c on q.qa_id = c.qa_id ");
		sb.append("left outer join sa_category sc on c.category_id = sc.category_id ");
		sb.append("left outer join sa_category pc on sc.parent_id = pc.category_id and pc.category_id > 1 ");
		sb.append("where q.step = 0 ");
		sb.append("and q.member_id = ? ");
		sb.append("and (q.status = 2000 or q.status = 4100)");
		sb.append("and q.is_choose = 0 ");
		sb.append("order by q.is_choose asc, q.qa_id desc ");
		sb.append("limit 3");

		return createNativeQuery(sb.toString()).setParameter(1, UserService.getUser().getMemberId()).getResultList();
	}

	/**
	 * 진행중인 나의 답변현황
	 *
	 * @return createNativeQuery.getResultList()
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getOngoingMyAnswerListByNativeQuery() throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append(
				"select q.qa_id as id, q.title as title, q.content as content, q.is_choose as choose, q.point as point, q.expire_Date as expireDate, pc.category_name as categoryParent, sc.category_name as categoryName, c.tag as categoryTag, ");
		sb.append("	( select count(qa_id) from qa_item where group_id = q.qa_id and position = 1 ) as answer_count ");
		sb.append(
				"from qa_item q left outer join qa_item_category c on q.qa_id = c.qa_id left outer join sa_category sc on c.category_id = sc.category_id ");
		sb.append("left outer join sa_category pc on sc.parent_id = pc.category_id and pc.category_id > 1 ");
		sb.append("where q.group_id in ");
		sb.append(" ( select distinct group_id from qa_item where member_id = :memberId and parent_id is not null ) ");
		sb.append("and q.parent_id is null ");
		sb.append("and q.member_id != :memberId ");
		sb.append("and (q.status = 2000 or q.status = 4100 ) ");
		sb.append("and q.is_choose = 0 ");
		sb.append("order by q.qa_id desc ");
		sb.append("limit 3");

		return createNativeQuery(sb.toString()).setParameter("memberId", UserService.getUser().getMemberId())
				.getResultList();
	}
	
	public int updateCategoryLevel(Long categoryId, List<Node> l) throws Exception {
		
		Long[] level = new Long[4];
		
		if(l.size() > 4){
			level = new Long[l.size()];
		}
		
		for (int i=0; i<l.size(); i++) {
			level[i] = l.get(i).getId();
		}
		
		StringBuffer sb = new StringBuffer();
		sb.append(" update qa_item_category ");
		sb.append(" set level1 = :level1, level2 = :level2, level3 = :level3, level4 = :level4 ");
		sb.append(" where category_id = :categoryId ");

		return createNativeQuery(sb.toString())
				.setParameter("level1", level[0])
				.setParameter("level2", level[1])
				.setParameter("level3", level[2])
				.setParameter("level4", level[3])
				.setParameter("categoryId", categoryId)
				.executeUpdate();
	}
	
	public int updateCategory(Long categoryId, Long targetId, List<Node> l) throws Exception {
		Long[] level = new Long[4];
		
		for (int i=0; i<l.size(); i++) {
			level[i] = l.get(i).getId();
		}
		
		StringBuffer sb = new StringBuffer();
		sb.append(" update qa_item_category ");
		sb.append(" set category_id = :targetId, level1 = :level1, ");
		sb.append(" 	level2 = :level2, level3 = :level3, level4 = :level4 ");
		sb.append(" where category_id = :categoryId ");

		return createNativeQuery(sb.toString())
				.setParameter("targetId", targetId)
				.setParameter("level1", level[0])
				.setParameter("level2", level[1])
				.setParameter("level3", level[2])
				.setParameter("level4", level[3])
				.setParameter("categoryId", categoryId)
				.executeUpdate();
	}
	
	/**
	 * 카테고리 기타로 등록된 내용 가져오기
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public String stringTag(Long id) throws Exception {
		String query = "select c.tag"
				+ " from qa_item_category c "
				+ " where c.qa_id = ? ";

		Object result = createNativeQuery(query).setParameter(1, id).getSingleResult();

		return result.toString();
	}
}
