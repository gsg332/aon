package com.aon.module.cyberaccount.point;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class PointService {

	@Autowired
	private IPointRepository repository;

	@Autowired
	private PointQuery query;

	/**
	 * 가상계좌일련번호로 페이징 처리된 포인트 거래내역을 돌려준다.
	 *
	 * @param cyberAccId
	 * @param pageable
	 * @return
	 */
	public Page<Point> getList(Long cyberAccId, Pageable pageable) throws Exception {
		return repository.findByCyberAccIdOrderByIdDesc(cyberAccId, pageable);
	}	

	/**
	 * 
	 * 포인트를 처리한다.
	 *
	 * @param pointObj
	 * @throws Exception
	 */
	protected Point insertPoint(Point pointObj) throws Exception {
		return repository.save(pointObj);
	}

	public Object getListCountByAdmin(Long cyberAccId) throws Exception {
		Object result = query.getListCountByNativeQuery(cyberAccId);
		
		return result;
	}
	
	/**
	 * 관리자 - 사용자 포인트 거래내역 조회
	 *
	 * @param cyberAccId
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	public List<Object> getListByAdmin(Long cyberAccId, Pageable pageable) throws Exception {
		List<Object> result = query.getListByNativeQuery(cyberAccId, pageable);

		return result;
	}
}
