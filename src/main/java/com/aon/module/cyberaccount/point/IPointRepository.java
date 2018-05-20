package com.aon.module.cyberaccount.point;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface IPointRepository extends IBaseRepository<Point, Long> {

	/**
	 * 가상계좌일려번호로 페이징 처리된 프인트 거래내역을 돌련준다.
	 *
	 * @param id
	 * @param pageable
	 * @return
	 */
	public Page<Point> findByCyberAccIdOrderByIdDesc(Long id, Pageable pageable);

}
