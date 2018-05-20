package com.aon.module.cyberaccount.deposit;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.module.cyberaccount.Admin;
import com.aon.module.cyberaccount.QAdmin;
import com.aon.module.cyberaccount.QCyberAccount;
import com.aon.sys.member.Member;
import com.aon.sys.member.QMember;
import com.querydsl.core.QueryResults;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;

@Service
public class DepositAdminQuery extends Query {

	/**
	 * 관리자용 충전신청 목록 조회
	 *
	 * @param search
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public QueryResults<Tuple> getListByEntity(DepositSearch search, Pageable pageable) throws Exception {
		QDeposit deposit = QDeposit.deposit;
		QCyberAccount cyberAccount = QCyberAccount.cyberAccount;
		QMember member = QMember.mem;
		QAdmin admin = QAdmin.admin;

		JPAQuery<?> query = getQuery();
		query.select(deposit, cyberAccount,
				Projections.fields(Member.class, member.id, member.loginId, member.nickname, member.firstName,
						member.lastName),
				Projections.fields(Admin.class, admin.id, admin.loginId, admin.nickname, admin.firstName,
						admin.lastName));
		query.from(deposit);
		query.join(cyberAccount).on(deposit.cyberAccId.eq(cyberAccount.id));
		query.join(member).on(cyberAccount.memberId.eq(member.id));
		query.leftJoin(admin).on(deposit.adminId.eq(admin.id));

		if (search.getDateSearchKey() != null) {
			switch (search.getDateSearchKey()) {
			case "insertDate":
				if (search.getStartDate() != null) {
					query.where(deposit.insertDate.goe(search.getStartDate()));
				}
				if (search.getEndDate() != null) {
					query.where(deposit.insertDate.loe(search.getEndDate()));
				}
				break;
			case "requestDate":
				if (search.getStartDate() != null) {
					query.where(deposit.requestDate.goe(search.getStartDate()));
				}
				if (search.getEndDate() != null) {
					query.where(deposit.requestDate.loe(search.getEndDate()));
				}
				break;
			}
		}

		if (search.getSearchPoint() != null) {
			query.where(deposit.requestPoint.eq(search.getSearchPoint()));
		}

		if (StringUtils.isNotBlank(search.getMemberSearchKey()) && StringUtils.isNotBlank(search.getMemberSearchValue())) {
			switch (search.getMemberSearchKey()) {
			case "loginId":
				query.where(member.loginId.like("%" + search.getMemberSearchValue() + "%"));
				break;
			case "nickname":
				query.where(member.nickname.like("%" + search.getMemberSearchValue() + "%"));
				break;
			case "firstName":
				query.where(member.firstName.like("%" + search.getMemberSearchValue() + "%"));
				break;
			case "requestAccountName":
				query.where(deposit.requestAccountName.like("%" + search.getMemberSearchValue() + "%"));
				break;
			}
		}

		query.orderBy(deposit.status.asc(), deposit.id.desc());

		return (QueryResults<Tuple>) query.offset(pageable.getOffset()).limit(pageable.getPageSize()).fetchResults();
	}

	/**
	 * 관리자용 충전신청 조회
	 *
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Tuple getReadByEntity(Long id) throws Exception {
		QDeposit deposit = QDeposit.deposit;
		QCyberAccount cyberAccount = QCyberAccount.cyberAccount;
		QMember member = QMember.mem;

		JPAQuery<?> query = getQuery();
		query.select(deposit, cyberAccount,
				Projections.fields(Member.class, member.id, member.nickname, member.firstName, member.lastName,
						member.cellPhoneNumber, member.email, member.loginId))
				.from(deposit, cyberAccount, member).where(deposit.id.eq(id))
				.where(deposit.cyberAccId.eq(cyberAccount.id)).where(cyberAccount.memberId.eq(member.id));

		return (Tuple) query.fetchOne();
	}

}