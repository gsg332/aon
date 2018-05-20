package com.aon.module.onlineask;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.module.doc.DocItem;
import com.aon.sys.member.QMember;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;

@Service
public class OnlineAskQuery extends Query {

	/**
	 * 목록 query
	 * 
	 * @param page
	 * @return query.select
	 * @throws Exception
	 */
	public QueryResults<OnlineAsk> getList(Pageable page) throws Exception {
		QOnlineAsk onlineask = QOnlineAsk.onlineAsk;
		QMember member = QMember.mem;
		JPAQuery<?> query = getQuery();
		int begin = new Integer(0);
		int end = new Integer(30);
		return query
				.select(Projections.fields(OnlineAsk.class, onlineask.id, onlineask.content.substring(begin, end).as("content"), onlineask.insertDate,
						onlineask.updateDate, onlineask.loginid, onlineask.userName, onlineask.adminComment,
						onlineask.email, onlineask.status, onlineask.adminId, member.nickname.as("adminNickname")))
				.from(onlineask).leftJoin(member).on(onlineask.adminId.eq(member.id)).orderBy(onlineask.insertDate.desc())
				.offset(page.getOffset()).limit(page.getPageSize()).fetchResults();
	}
}
