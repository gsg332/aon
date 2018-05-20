package com.aon.module.cyberaccount.point;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;

@Service
public class PointQuery extends Query {

	/**
	 * 관리자 - 포인트 거래내역 조회 count
	 *
	 * @param cyberAccId
	 * @return
	 * @throws Exception
	 */
	public Object getListCountByNativeQuery(Long cyberAccId) throws Exception {
		Object result;
		String qs = "select count(point_id) from pt_point where cyber_acc_id = ?";
		result = createNativeQuery(qs).setParameter(1, cyberAccId).getSingleResult();

		return result;
	}

	/**
	 * 관리자 - 포인트 거래내역 조회
	 *
	 * @param cyberAccId
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Object> getListByNativeQuery(Long cyberAccId, Pageable pageable) throws Exception {
		List<Object> result;
		String pointQs = "select " + "pp.point_id as point_id, " + "null as request_date, "
				+ "pp.insert_date as confirm_date, " + "pp.type as type, " + "null as request_point, "
				+ "pp.point as confirm_point, " + "pp.amount as amount, " + "null as confirm_account_name, " + "null as confirm_bank_code, "
				+ "null as confirm_account_number, " + "pp.source_id as source_id, " + "null as admin_id, "
				+ "null as admin_comment " + "from pt_point pp " + "where pp.cyber_acc_id = ? "
				+ "and pp.type not in (?, ?, ?, ?) ";
		String depositQs = "select " + "pp.point_id as point_id, " + "pd.request_date as request_date, "
				+ "pp.insert_date as confirm_date, " + "pp.type as type, " + "pd.request_point as request_point, "
				+ "pp.point as confirm_point, " + "pd.amount as amount, " + "pd.confirm_account_name as confirm_account_name, "
				+ "null as confirm_bank_code, " + "null as confirm_account_number, " + "pp.source_id as source_id, "
				+ "pd.admin_id as admin_id, " + "pd.admin_comment as admin_comment " + "from pt_point pp "
				+ "left join pt_deposit pd on pp.source_id = pd.deposit_id " + "where pp.cyber_acc_id = ? "
				+ "and pp.type in (?, ?) ";
		String withdrawQs = "select " + "pp.point_id as point_id, " + "pw.insert_date as request_date, "
				+ "pp.insert_date as confirm_date, " + "pp.type as type, " + "pw.request_point as request_point, "
				+ "pp.point as confirm_point, " + "pw.amount, " + "pw.confirm_account_name as confirm_account_name, "
				+ "pw.confirm_bank_code as confirm_bank_code, "
				+ "pw.confirm_account_number as confirm_account_number, " + "pp.source_id as source_id, "
				+ "pw.admin_id as admin_id, " + "pw.admin_comment as admin_comment " + "from pt_point pp "
				+ "left join pt_withdraw pw on pp.source_id = pw.withdraw_id " + "where pp.cyber_acc_id = ? "
				+ "and pp.type in (?, ?) ";

		String unionQs = pointQs + " union " + withdrawQs + " union " + depositQs;

		String qs = "select " + "a.point_id, a.request_date, a.confirm_date, a.type, a.request_point, a.confirm_point, "
				+ "a.amount, a.confirm_account_name, a.confirm_bank_code, a.confirm_account_number, a.source_id, "
				+ "a.admin_id, hm.loginid, a.admin_comment " + "from (" + unionQs + ") a "
				+ "left join hr_member hm on a.admin_id = hm.member_id " + "order by a.point_id desc";

		result = createNativeQuery(qs)
				.setParameter(1, cyberAccId)
				.setParameter(2, Point.DEPOSITED_TYPE)
				.setParameter(3, Point.ADMIN_DEPOSITED_TYPE)
				.setParameter(4, Point.WITHDREW_TYPE)
				.setParameter(5, Point.ADMIN_WITHDREW_TYPE)
				.setParameter(6, cyberAccId)
				.setParameter(7, Point.WITHDREW_TYPE)
				.setParameter(8, Point.ADMIN_WITHDREW_TYPE)
				.setParameter(9, cyberAccId)
				.setParameter(10, Point.DEPOSITED_TYPE)
				.setParameter(11, Point.ADMIN_DEPOSITED_TYPE)
				
				.setFirstResult(pageable.getOffset()).setMaxResults(pageable.getPageSize()).getResultList();

		return result;
	}

}
