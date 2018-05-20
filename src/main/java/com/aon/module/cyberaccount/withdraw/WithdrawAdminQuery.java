package com.aon.module.cyberaccount.withdraw;

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
public class WithdrawAdminQuery extends Query {

	/**
	 * 관리자 - 출금신청 목록 조회
	 *
	 * @param search
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public QueryResults<Tuple> getListByEntity(WithdrawSearch search, Pageable pageable) throws Exception {
		QWithdraw withdraw = QWithdraw.withdraw;
		QCyberAccount cyberAccount = QCyberAccount.cyberAccount;
		QMember member = QMember.mem;
		QAdmin admin = QAdmin.admin;

		JPAQuery<?> query = getQuery();
		query.select(withdraw, cyberAccount,
				Projections.fields(Member.class, member.id, member.loginId, member.nickname, member.firstName,
						member.lastName),
				Projections.fields(Admin.class, admin.id, admin.loginId, admin.nickname, admin.firstName,
						admin.lastName));
		query.from(withdraw);
		query.join(cyberAccount).on(withdraw.cyberAccId.eq(cyberAccount.id));
		query.join(member).on(cyberAccount.memberId.eq(member.id));
		query.leftJoin(admin).on(withdraw.adminId.eq(admin.id));

		if (search.getDateSearchKey() != null) {
			switch (search.getDateSearchKey()) {
			case "insertDate":
				if (search.getStartDate() != null) {
					query.where(withdraw.insertDate.goe(search.getStartDate()));
				}
				if (search.getEndDate() != null) {
					query.where(withdraw.insertDate.loe(search.getEndDate()));
				}
				break;
			case "confirmDate":
				if (search.getStartDate() != null) {
					query.where(withdraw.confirmDate.goe(search.getStartDate()));
				}
				if (search.getEndDate() != null) {
					query.where(withdraw.confirmDate.loe(search.getEndDate()));
				}
				break;
			}
		}

		if (search.getSearchPoint() != null) {
			query.where(withdraw.requestPoint.eq(search.getSearchPoint()));
		}

		if (StringUtils.isNotBlank(search.getMemberSearchKey())
				&& StringUtils.isNotBlank(search.getMemberSearchValue())) {
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
			case "confirmAccountName":
				query.where(withdraw.confirmAccountName.like("%" + search.getMemberSearchValue() + "%"));
				break;
			}
		}
		query.orderBy(withdraw.status.asc(), withdraw.id.desc());

		return (QueryResults<Tuple>) query.offset(pageable.getOffset()).limit(pageable.getPageSize()).fetchResults();
	}

	/**
	 * 관리자 - 출금신청 조회.
	 *
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Tuple getReadByEntity(Long id) throws Exception {
		QWithdraw withdraw = QWithdraw.withdraw;
		QCyberAccount cyberAccount = QCyberAccount.cyberAccount;
		QMember member = QMember.mem;

		JPAQuery<?> query = getQuery();
		query.select(withdraw, cyberAccount,
				Projections.fields(Member.class, member.id, member.nickname, member.firstName, member.lastName,
						member.cellPhoneNumber, member.email, member.loginId))
				.from(withdraw, cyberAccount, member).where(withdraw.id.eq(id))
				.where(withdraw.cyberAccId.eq(cyberAccount.id)).where(cyberAccount.memberId.eq(member.id));

		return (Tuple) query.fetchOne();
	}
}
