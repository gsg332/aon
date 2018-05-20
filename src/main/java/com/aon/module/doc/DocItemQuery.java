package com.aon.module.doc;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.sys.member.Member;
import com.aon.sys.member.QMember;
import com.querydsl.core.QueryResults;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQuery;


@Service
public class DocItemQuery extends Query {


	/**
	 * query dsl 사용을 표준으로한다. 
	 * 예제  
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public QueryResults<DocItem> getList(Pageable page) throws Exception {
		QDocItem docItem = QDocItem.docItem;
		JPAQuery<?> query = getQuery();
		return query.select(
				Projections.fields(DocItem.class,docItem.id,docItem.title,docItem.insertDate))
								   .from(docItem)
								   .orderBy(docItem.insertDate.desc())
								   .offset(page.getOffset())
								   .limit(page.getPageSize())
								   .fetchResults(); 
								 
		
	}
	
	/**
	 * 예제 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public QueryResults<Tuple> getListByEntity(Pageable page) throws Exception {
		System.out.println("getListByEntity");
		QDocItem docItem = QDocItem.docItem;
		QMember member  = QMember.mem;
		JPAQuery<?> query = getQuery();
		return  query.select(docItem,
						Projections.fields(Member.class,member.id,member.nickname,member.firstName,member.lastName))
									  .from(docItem,member).where(docItem.registerUser.memberId.eq(member.id))
									  .offset(page.getOffset())
									   .limit(page.getPageSize()).fetchResults();
									   
	}
	
	/**
	 * 예제 JPQL (비교 count query는 별로 작성해야함)
	 * alias 를 이용하여 Tuple객체를 이용 또는 Entity를 이용 
	 * @return
	 * @throws Exception
	 */
	public List<javax.persistence.Tuple> getListByJpql(String title,Pageable page) throws Exception{
		return createQuery("select m.id as id , m.title as title from DocItem as m "
				+ "where lower(m.title) like CONCAT('%', :searchTerm, '%') ", javax.persistence.Tuple.class)
		.setParameter("searchTerm", title)
		.setFirstResult(page.getOffset())
		.setMaxResults(page.getPageSize()).getResultList();
	}
	
	public List<DocItem> getListByJpqlWithoutField(String title,Pageable page) throws Exception{
		return createQuery("select m from DocItem as m where lower(m.title) like CONCAT('%', :searchTerm, '%') ",DocItem.class)
				.setParameter("searchTerm", title)
				.setFirstResult(page.getOffset())
				.setMaxResults(page.getPageSize()).getResultList();
		
	}
	
	
	
	/***
	 * 표준 
	 * -----------------------------------------
	 * 비표준 
	 */
	
	/**
	 * Native Query (성능튜닝이나 불가능한 경우에 사용할것)
	 * field명으로 접근할 수 없으며,쿼리하는 필드순으로 리턴한다. 
	 * @throws Exception 
	 */
	 @SuppressWarnings("unchecked")
	public List<Object[]> getListByNativeQuery(String title ,Pageable page) throws Exception
	 {
		 return createNativeQuery("select m.itemid  ,m.title from doc_item m "
		 		+ "where lower(m.title) like ? " ).setParameter(1, title+"%")
				    .setFirstResult(page.getOffset())
					.setMaxResults(page.getPageSize()).getResultList();
	 }
	

}
