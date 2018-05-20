package com.aon.module.doc;

import java.util.List;

import javax.persistence.Tuple;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;



@Repository
public  interface IDocItemRepository extends IBaseRepository<DocItem, Long>{
	
	public Page<DocItem> findByTitleStartingWith(String title,Pageable pageable);
	
	public Page<DocItem> findAllByOrderByInsertDateDesc(Pageable pageable);
	
	/**
	 * native query sort,paging 개발자가 구현해야한다. 
	 * @param itemid
	 * @return
	 */
	@Query(value = "SELECT * FROM doc_item WHERE item_id = ?1", nativeQuery = true)
	public DocItem findById(Long itemid);

	@Query(value = "SELECT * FROM doc_item WHERE item_id = :id", nativeQuery = true)
	public DocItem findByIdWithParam(@Param("id") Long itemid);
	
	@Query(value = "SELECT * FROM doc_item ", nativeQuery = true)
	public List<DocItem> list();
	
	/**
	 * jpql,hql만 sort page 처리 
	 * @param pageable
	 * @return
	 */
	@Query(value = "from DocItem d")
	public Page<DocItem> paging(Pageable pageable);
	
	@Query(value = "from DocItem d inner join DocItem$Attachment f on d.id = f.entity.id")
	public Page<DocItem> join(Pageable pageable);
	
	@Query(value = "from DocItem as item inner join DocItem$Attachment as file on item.id = file.entity.id")
	public List<Tuple> listbyReturnTuple();

	

}