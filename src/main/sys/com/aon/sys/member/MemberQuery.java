package com.aon.sys.member;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.aon.lib.jpa.Query;
import com.aon.lib.tree.Node;
import com.aon.module.cyberaccount.QCyberAccount;
import com.aon.sys.member.Member.Category;
import com.aon.sys.usr.UserService;
import com.querydsl.core.QueryResults;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;

@Service
public class MemberQuery extends Query {

	/**
	 * 회원 목록을 가지고 온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public QueryResults<Tuple> getList(Pageable page, MemberSearch search) throws Exception {

		QMember member = QMember.mem;
		QCyberAccount cyberAccount = QCyberAccount.cyberAccount;

		BooleanExpression dateSearch = null;
		BooleanExpression statusSearch = null;
		BooleanExpression inputSearch = null;

		if (search != null) {
			String dateSearchKey = search.getDateSearchKey();
			Date startDate = search.getStartDate();
			Date endDate = search.getEndDate();
			if (endDate != null)
				endDate = new Date(endDate.getTime() + 1000 * 60 * 60 * 24);
			if (dateSearchKey != null) {
				switch (dateSearchKey) {
				case "insertDate":
					if (startDate != null && endDate != null)
						dateSearch = member.insertDate.between(startDate, endDate);
					if (startDate != null && endDate == null)
						dateSearch = member.insertDate.goe(startDate);
					if (startDate == null && endDate != null)
						dateSearch = member.insertDate.loe(endDate);
					break;
				case "dropoutDate":
					if (startDate != null && endDate != null)
						dateSearch = member.dropoutDate.between(startDate, endDate);
					if (startDate != null && endDate == null)
						dateSearch = member.dropoutDate.goe(startDate);
					if (startDate == null && endDate != null)
						dateSearch = member.dropoutDate.loe(endDate);
					break;
				}
			}

			String statusSearchKey = search.getStatusSearchKey();
			if (statusSearchKey != null) {
				switch (statusSearchKey) {
				case "activeMember":
					statusSearch = member.status.eq(Member.REGISTERED_STATUS);
					break;
				case "dropoutMember":
					statusSearch = member.status.eq(Member.DELETED_STATUS);
					break;
				}
			}

			String inputSearchKey = search.getInputSearchKey();
			String inputSearchValue = search.getInputSearchValue();
			if (!StringUtils.isEmpty(inputSearchKey) && !StringUtils.isEmpty(inputSearchValue)) {
				switch (inputSearchKey) {
				case "loginId":
					inputSearch = member.loginId.like("%" + inputSearchValue + "%");
					break;
				case "firstName":
					inputSearch = member.firstName.like("%" + inputSearchValue + "%");
					break;
				case "nickname":
					inputSearch = member.nickname.like("%" + inputSearchValue + "%");
					break;
				}
			}
		}

		JPAQuery<?> query;
		try {
			query = getQuery();
			return query
					.select(Projections.fields(Member.class, member.id, member.loginId, member.nickname,
							member.firstName, member.lastName, member.lastAccessDate, member.questionCnt,
							member.answerCnt), cyberAccount)
					.from(member).leftJoin(cyberAccount).on(member.id.eq(cyberAccount.memberId))
					.where(dateSearch, statusSearch, inputSearch).orderBy(member.id.desc()).offset(page.getOffset())
					.limit(page.getPageSize()).fetchResults();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 회원 정보를 가지고 온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public Tuple getMemberInfo(Long id) throws Exception {

		QMember member = QMember.mem;
		JPAQuery<?> query;
		try {
			query = getQuery();
			return (Tuple) query.select(member).from(member).where(member.id.eq(id)).fetchOne();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 회원 탈퇴 목록을 가지고 온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public QueryResults<Tuple> getDropoutList(Pageable page, MemberSearch search) throws Exception {
		QMember member = QMember.mem;
		QCyberAccount cyberAccount = QCyberAccount.cyberAccount;

		BooleanExpression dateSearch = null;
		BooleanExpression inputSearch = null;

		if (search != null) {
			Date startDate = search.getStartDate();
			Date endDate = search.getEndDate();
			if (endDate != null)
				endDate = new Date(endDate.getTime() + 1000 * 60 * 60 * 24);

			if (startDate != null && endDate != null)
				dateSearch = member.dropoutDate.between(startDate, endDate);
			if (startDate != null && endDate == null)
				dateSearch = member.dropoutDate.goe(startDate);
			if (startDate == null && endDate != null)
				dateSearch = member.dropoutDate.loe(endDate);

			String inputSearchKey = search.getInputSearchKey();
			String inputSearchValue = search.getInputSearchValue();
			if (!StringUtils.isEmpty(inputSearchKey) && !StringUtils.isEmpty(inputSearchValue)) {
				switch (inputSearchKey) {
				case "all":
					inputSearch = member.firstName.like("%" + inputSearchValue + "%")
							.or(member.nickname.like("%" + inputSearchValue + "%"));
					break;
				case "firstName":
					inputSearch = member.firstName.like("%" + inputSearchValue + "%");
					break;
				case "nickname":
					inputSearch = member.nickname.like("%" + inputSearchValue + "%");
					break;
				}
			}
		}

		JPAQuery<?> query;
		try {
			query = getQuery();
			return query
					.select(Projections.fields(Member.class, member.id, member.loginId, member.nickname,
							member.firstName, member.lastName, member.dropoutDate, member.dropoutReason), cyberAccount)
					.from(member).leftJoin(cyberAccount).on(member.id.eq(cyberAccount.memberId))
					.where(dateSearch, inputSearch,
							member.status.eq(Member.DELETED_STATUS).or(member.status.eq(Member.DELETED_APPLY)))
					.orderBy(member.insertDate.desc()).offset(page.getOffset()).limit(page.getPageSize())
					.fetchResults();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 탈퇴회원 정보를 가지고 온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public Tuple getDropoutInfo(Long id) throws Exception {

		QMember member = QMember.mem;
		QCyberAccount cyberAccount = QCyberAccount.cyberAccount;

		JPAQuery<?> query;
		try {
			query = getQuery();
			return query
					.select(Projections.fields(Member.class, member.id, member.loginId, member.nickname,
							member.firstName, member.lastName, member.dropoutDate, member.dropoutReason), cyberAccount)
					.from(member).leftJoin(cyberAccount).on(member.id.eq(cyberAccount.memberId)).where(member.id.eq(id))
					.fetchOne();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 회원 탈퇴 전 비밀번호를 가져온다
	 * 
	 * @return
	 * @throws Exception
	 */
	public Member getMemberPassword(Member client) throws Exception {
		QMember member = QMember.mem;
		JPAQuery<?> query;
		query = getQuery();

		return query.select(Projections.fields(Member.class, member.password)).from(member)
				.where(member.id.eq(client.getId())).fetchFirst();
	}

	/**
	 * 신규회원, 탈퇴회원 확인
	 * 
	 * @return
	 * @throws Exception
	 */
	public Member emailConfirmUserStatus(Member client) throws Exception {
		QMember member = QMember.mem;
		JPAQuery<?> query;
		query = getQuery();

		return query.select(Projections.fields(Member.class, member.id, member.status)).from(member)
				.where(member.loginId.eq(client.getLoginId())).fetchFirst();
	}
	
	/**
	 * 회원가입 이메일 발송전 회원의 STATUS를 변경한다.
	 * 
	 * @param client
	 * @return
	 * @throws Exception
	 */
	public Member emailConfirmUserUpdate(Member client) throws Exception {
		QMember member = QMember.mem;
		JPAQuery<?> query;
		query = getQuery();

		return (Member) query.from(member).where(member.loginId.eq(client.getLoginId())).fetchFirst();
	}

	/**
	 * 회원의 비밀번호를 조회한다
	 * 
	 * @param client
	 * @return
	 * @throws Exception
	 */
	public Member findMemberPassword(Member client) throws Exception {
		QMember member = QMember.mem;
		JPAQuery<?> query;
		query = getQuery();

		return (Member) query
				.from(member).where(member.loginId.eq(client.getLoginId())
						.and(member.firstName.eq(client.getFirstName())).and(member.lastName.eq(client.getLastName())))
				.fetchFirst();
	}
	
	
	/**
	 * 회원카테고리 목록 (native query)
	 *
	 * @return resultList
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Category> getSpecialty(Long memberId) throws Exception {
		String query = " select hr.member_id, c.category_id, hr.level1, hr.level2 , hr.level3 , hr.level4, hr.sort_order, hr.tag, c.category_name "
			         + " from hr_category hr, sa_category c "
			         + " where hr.category_id = c.category_id "
			         + " and hr.member_id = ? "
			         + " order by c.sort_order asc";
		List<Category> resultList = createNativeQuery(query).setParameter(1, memberId).getResultList();
		return resultList;
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
		sb.append(" update hr_category ");
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
	
	@SuppressWarnings("unchecked")
	public List<Object> getContentsCount(Long categoryId) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select count(category_id) as count ");
		sb.append(" from hr_category ");
		sb.append(" where category_id = ? ");

		return createNativeQuery(sb.toString()).setParameter(1, categoryId).getResultList();
	}
	
	/**
	 * 회원의 비밀번호가 맞는지 확인한다.
	 * 
	 * @param client
	 * @return
	 * @throws Exception
	 */
	public int checkMemberPassword(Member client) throws Exception {
		QMember member = QMember.mem;
		JPAQuery<?> query;
		query = getQuery();

		return (int) query.from(member).where(member.id.eq(UserService.getMemberId()).and(member.password.eq(client.getBeforePassword()))).fetchCount();
	}
	
	/**
	 * 탈퇴회원 정보를 가지고 온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public QueryResults<Member> getSchedulerDropoutInfo() throws Exception {
		QMember member = QMember.mem;
		JPAQuery<?> query;
		try {
			query = getQuery();
			return query
					.select(member)
					.from(member)
					.where(member.status.eq(Member.DELETED_APPLY))
					.fetchResults();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 탈퇴회원 정보를 가지고 온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public QueryResults<Member> getSchedulerUnFinishMember() throws Exception {
		QMember member = QMember.mem;
		JPAQuery<?> query;
		try {
			query = getQuery();
			return query
					.select(member)
					.from(member)
					.where(member.status.eq(Member.APPLIED_STATUS))
					.fetchResults();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
