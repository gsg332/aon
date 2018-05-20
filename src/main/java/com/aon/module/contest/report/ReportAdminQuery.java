package com.aon.module.contest.report;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;

@Service
public class ReportAdminQuery extends Query {

	@SuppressWarnings("unchecked")
	public QueryResults<Report> getList(ReportSearch search, Pageable page) throws Exception {
		String searchKey = search.getSearchKey();
		String searchText = search.getSearchText();
		QReport report = QReport.report;
		JPAQuery<?> query = getQuery();

		query.select(Projections.fields(Report.class, report.id, report.qaId, report.content, report.confirm,
				report.adminUser, report.reportUser, report.insertDate, report.confirmDate, report.adminComment));
		query.from(report);
		if (search.getStartDate() != null) {
			query.where(report.insertDate.goe(search.getStartDate()));
		}
		if (search.getEndDate() != null) {
			query.where(report.insertDate.loe(search.getEndDate()));
		}
		if (searchKey != null && !searchKey.equals("") && searchText != null && !searchText.equals("")) {
			switch (searchKey) {
			case "reportUser":
				query.where(report.reportUser.displayName.like("%" + searchText + "%"));
				break;
			case "adminUser":
				query.where(report.adminUser.displayName.like("%" + searchText + "%"));
				break;
			}
		}

		query.orderBy(report.id.desc()).offset(page.getOffset()).limit(page.getPageSize());

		return (QueryResults<Report>) query.fetchResults();
	}

	@SuppressWarnings("unchecked")
	public List<Report> getListByQaId(Long qaId) throws Exception {
		QReport report = QReport.report;
		JPAQuery<?> query = getQuery();
		query.select(Projections.fields(Report.class, report.id, report.qaId, report.content, report.confirm,
				report.adminUser, report.reportUser, report.insertDate, report.confirmDate, report.adminComment));
		query.from(report);
		query.where(report.qaId.eq(qaId));
		query.orderBy(report.id.desc());

		return (List<Report>) query.fetch();
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
