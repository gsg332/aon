package com.aon.module.contest;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.sys.member.QMember;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;

@Service
public class ContestAdminQuery extends Query {
	static final Logger LOGGER = LoggerFactory.getLogger(ContestAdminController.class);

	/**
	 * querydsl을 사용한 리스트 출력 category 구조 상 사용 불가. 향후에 어떤방식으로 변경할 것 인지에 따라 보존 혹은
	 * 제거.
	 * 
	 * @param search
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public QueryResults<Contest> getList(ContestSearch search, Pageable page) throws Exception {
		String searchKey = search.getSearchKey();
		String searchText = search.getSearchText();
		QContest contest = QContest.contest;
		QMember member = QMember.mem;
		// QContest_Category category = QContest_Category.category;
		JPAQuery<?> query = getQuery();

		query.select(Projections.fields(Contest.class, contest.id, contest.title, contest.readCount, contest.content,
				contest.status, contest.insertDate, contest.expireDate, contest.choose, contest.point));
		query.from(contest);
		query.where(contest.position.eq(0));
		if (search.getStartDate() != null) {
			query.where(contest.insertDate.goe(search.getStartDate()));
		}
		if (search.getEndDate() != null) {
			query.where(contest.insertDate.loe(search.getEndDate()));
		}
		if (search.getSearchPoint() != null) {
			query.where(contest.point.goe(search.getSearchPoint()));
		}
		if (search.getSearchStatus() != -1) {
			if (search.getSearchStatus() == 1)
				query.where(contest.choose.eq(true));
			else
				query.where(contest.choose.eq(false));
		}
		if (search.getSearchChoose() != -1) {
			query.where(contest.status.eq(search.getSearchChoose()));
		}
		if (search.getCategoryId() != null && search.getCategoryId() != -1) {
			// query.where(contest.categories.categoryId.eq(search.getCategoryId()));
		}
		if (searchKey != null && !searchKey.equals("") && searchText != null && !searchText.equals("")) {
			switch (searchKey) {
			case "title":
				query.where(contest.title.like("%" + searchText + "%"));
				break;
			case "id":
				query.where(contest.id.eq(Long.parseLong(searchText)));
				break;
			case "nickname":
				query.join(member).on(contest.registerUser.memberId.eq(member.id))
						.where(member.nickname.like("%" + searchText + "%"));
			}
		}

		query.orderBy(contest.id.desc()).offset(page.getOffset()).limit(page.getPageSize());
		return (QueryResults<Contest>) query.fetchResults();
	}

	/**
	 * 
	 * @param search
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Contest> getListByNativeQuery(ContestSearch search, Pageable page) throws Exception {
		String searchKey = search.getSearchKey();
		String searchText = search.getSearchText();
		List<Contest> resultList;
		String querySelect = " select qa.qa_id as id, qa.title, qa.read_count as readCount, qa.content, qa.status, "
				+ " qa.insert_date as insertDate, qa.expire_date as expireDate, qa.is_choose as choose, qa.point, pc.category_name as categoryParent, sc.category_name as categoryName, qc.tag as categoryTag  ";
		String queryFrom = " from qa_item qa " 
				+ " left outer join qa_item_category qc on qa.qa_id = qc.qa_id "
				+ " left outer join sa_category sc on qc.category_id = sc.category_id "
				+ " left outer join sa_category pc on sc.parent_id = pc.category_id and pc.category_id > 1 ";
		String queryWhere = " where qa.position = 0 ";
		String queryOrder = " order by qa.qa_id desc ";
		if (search.getCategoryId() != null && search.getCategoryId() != -1) {
			queryWhere += " and sc.category_id = ?";
		}
		if (searchKey != null && !searchKey.equals("") && searchText != null && !searchText.equals("")) {
			switch (searchKey) {
			case "nickname":
				querySelect += ", hr.nickname as nickname ";
				queryFrom += " left outer join hr_member hr on qa.member_id = hr.member_id ";
				queryWhere += " and hr.nickname like ? ";
				break;
			case "title":
				queryWhere += " and qa.title like ? ";
				break;
			case "id":
				queryWhere += " and qa.qa_id = ? ";
				break;
			}
		}
		if (search.getStartDate() != null) {
			queryWhere += " and qa.insert_date >= ? ";
		}
		if (search.getEndDate() != null) {
			queryWhere += " and qa.insert_date <= ? ";
		}
		if (search.getSearchPoint() != null) {
			queryWhere += " and qa.point >= ? ";
		}
		if (search.getSearchStatus() != -1) {
			queryWhere += " and qa.status = ? ";
		}
		if (search.getSearchChoose() != -1) {
			queryWhere += " and qa.is_choose = ? ";
		}
		javax.persistence.Query query = createNativeQuery(querySelect + queryFrom + queryWhere + queryOrder);
		int position = 0;
		if (search.getCategoryId() != null && search.getCategoryId() != -1) {
			position++;
			if (search.getCategorySub() != null && search.getCategorySub() != -1) {
				query.setParameter(position, search.getCategorySub());
			}else{
				query.setParameter(position, search.getCategoryId());	
			}
		}
		if (searchKey != null && !searchKey.equals("") && searchText != null && !searchText.equals("")) {
			position++;
			if(!searchKey.equals("id"))
				searchText = "%"+searchText + "%";
			query.setParameter(position, searchText);
		}
		if (search.getStartDate() != null) {
			position++;
			query.setParameter(position, search.getStartDate());
		}
		if (search.getEndDate() != null) {
			position++;
			query.setParameter(position, search.getEndDate());
		}
		if (search.getSearchPoint() != null) {
			position++;
			query.setParameter(position, search.getSearchPoint());
		}
		if (search.getSearchStatus() != -1) {
			position++;
			query.setParameter(position, search.getSearchStatus());
		}
		if (search.getSearchChoose() != -1) {
			position++;
			query.setParameter(position, search.getSearchChoose());
		}
		resultList = query.setFirstResult(page.getOffset()).setMaxResults(page.getPageSize()).getResultList();

		return resultList;
	}

	@SuppressWarnings("unchecked")
	public List<Contest> getListCountByNativeQuery(ContestSearch search, Pageable page) throws Exception {
		String searchKey = search.getSearchKey();
		String searchText = search.getSearchText();
		List<Contest> resultList;
		String querySelect = " select count(qa.qa_id) as count";
		String queryFrom = " from qa_item qa " 
				+ " left outer join qa_item_category qc on qa.qa_id = qc.qa_id ";
		String queryWhere = " where qa.position = 0 ";
		if (search.getCategoryId() != null && search.getCategoryId() != -1) {
			queryFrom +=	" left outer join sa_category sc on qc.category_id = sc.category_id ";
			queryWhere += " and sc.category_id = ?";
		}
		if (searchKey != null && !searchKey.equals("") && searchText != null && !searchText.equals("")) {
			switch (searchKey) {
			case "nickname":
				queryFrom += " left outer join hr_member hr on qa.member_id = hr.member_id ";
				queryWhere += " and hr.nickname like ? ";
				break;
			case "title":
				queryWhere += " and qa.title like ? ";
				break;
			case "id":
				queryWhere += " and qa.qa_id = ? ";
				break;
			}
		}
		if (search.getStartDate() != null) {
			queryWhere += " and qa.insert_date >= ? ";
		}
		if (search.getEndDate() != null) {
			queryWhere += " and qa.insert_date <= ? ";
		}
		if (search.getSearchPoint() != null) {
			queryWhere += " and qa.point >= ? ";
		}
		if (search.getSearchStatus() != -1) {
			queryWhere += " and qa.status = ? ";
		}
		if (search.getSearchChoose() != -1) {
			queryWhere += " and qa.is_choose = ? ";
		}
		
		javax.persistence.Query query = createNativeQuery(querySelect + queryFrom + queryWhere);
		int position = 0;
		if (search.getCategoryId() != null && search.getCategoryId() != -1) {
			position++;
			if (search.getCategorySub() != null && search.getCategorySub() != -1) {
				query.setParameter(position, search.getCategorySub());
			}else{
				query.setParameter(position, search.getCategoryId());	
			}
		}
		if (searchKey != null && !searchKey.equals("") && searchText != null && !searchText.equals("")) {
			position++;
			if(!searchKey.equals("id"))
				searchText = "%"+searchText + "%";
			query.setParameter(position, searchText);
		}
		if (search.getStartDate() != null) {
			position++;
			query.setParameter(position, search.getStartDate());
		}
		if (search.getEndDate() != null) {
			position++;
			query.setParameter(position, search.getEndDate());
		}
		if (search.getSearchPoint() != null) {
			position++;
			query.setParameter(position, search.getSearchPoint());
		}
		if (search.getSearchStatus() != -1) {
			position++;
			query.setParameter(position, search.getSearchStatus());
		}
		if (search.getSearchChoose() != -1) {
			position++;
			query.setParameter(position, search.getSearchChoose());
		}
		resultList = query.getResultList();

		return resultList;
	}

	@SuppressWarnings("unchecked")
	public QueryResults<Contest> getAnswerList(ContestSearch search, Pageable page) throws Exception {
		String searchKey = search.getSearchKey();
		String searchText = search.getSearchText();
		QContest contest = QContest.contest;
		QMember member = QMember.mem;
		JPAQuery<?> query = getQuery();

		query.select(Projections.fields(Contest.class, contest.id, contest.title, contest.readCount, contest.content,
				contest.status, contest.insertDate, contest.expireDate, contest.parentId, member.loginId,
				member.nickname.as("nickName")));
		query.from(contest);
		query.leftJoin(member).on(contest.registerUser.memberId.eq(member.id));
		query.where(contest.position.eq(1));
		if (search.getStartDate() != null) {
			query.where(contest.insertDate.goe(search.getStartDate()));
		}
		if (search.getEndDate() != null) {
			query.where(contest.insertDate.loe(search.getEndDate()));
		}
		if (searchKey != null && !searchKey.equals("") && searchText != null && !searchText.equals("")) {
			switch (searchKey) {
			case "title":
				query.where(contest.title.like("%" + searchText + "%"));
				break;
			case "id":
				query.where(contest.groupId.eq(Long.parseLong(searchText)));
				break;
			case "nickname":
				query.where(member.nickname.like("%" + searchText + "%"));
			}
		}

		query.orderBy(contest.id.desc()).offset(page.getOffset()).limit(page.getPageSize());
		return (QueryResults<Contest>) query.fetchResults();
	}

	@SuppressWarnings("unchecked")
	public List<Contest> getAnswerRead(Long id) throws Exception {
		QContest contest = QContest.contest;
		JPAQuery<?> query = getQuery();

		query.select(Projections.fields(Contest.class, contest.id, contest.groupId, contest.parentId,
				contest.answerGroupId, contest.position, contest.title, contest.content, contest.step, contest.choose,
				contest.favorite, contest.gradePoint, contest.registerUser, contest.insertDate));
		query.from(contest);
		query.where(contest.parentId.eq(id));
		query.where(contest.position.goe(1));

		return (List<Contest>) query.fetch();
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getFileList(Long id) throws Exception {
		return createNativeQuery(
				"select m.file_id, m.file_name, m.file_size, m.save_path, m.qa_id from qa_item_file as m "
						+ "where qa_id = ? ").setParameter(1, id).getResultList();
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
