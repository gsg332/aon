package com.aon.module.contest;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface IContestRepository extends IBaseRepository<Contest, Long> {

	public Page<Contest> findByTitleStartingWith(String title, Pageable pageable);

	public Page<Contest> findAllByOrderByInsertDateDesc(Pageable pageable);

	public Page<Contest> findAllByOrderByIdDesc(Pageable page);

	public Page<Contest> findByTitleContainingOrderByIdDesc(String Title, Pageable page);

	public Page<Contest> findByContentContainingOrderByIdDesc(String Content, Pageable page);

	public Page<Contest> findByTitleContainingOrContentContainingOrderByIdDesc(String Title, String Content,
			Pageable page);

}