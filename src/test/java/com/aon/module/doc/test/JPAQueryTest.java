package com.aon.module.doc.test;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Tuple;
import javax.persistence.TupleElement;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.aon.junit.JUnitTest;
import com.aon.lib.jpa.ClassMetaData;
import com.aon.module.doc.DocItem;
import com.aon.module.doc.DocItemQuery;
import com.aon.module.doc.IDocItemRepository;
import com.aon.module.doc.QDocItem;
import com.aon.sys.member.Member;
import com.querydsl.core.QueryResults;

@RunWith(SpringJUnit4ClassRunner.class)
public class JPAQueryTest extends JUnitTest{

	@Autowired 
	protected ApplicationContext context;

	@Autowired
	protected IDocItemRepository repository;
	
	@Autowired 
	protected DocItemQuery sql;
	
	@Autowired
	private EntityManagerFactory emf;
	
	@Autowired
	private EntityManager em;
	
	@Test
	public void test(){
		System.out.println("jpaNativeQuery");

		DocItem doc = repository.findById(new Long(1));
		System.out.println("id="+doc.getId());
		System.out.println("title="+doc.getTitle());
		System.out.println("content="+doc.getContent());
		System.out.println("version="+doc.getVersion());
		assertEquals(doc.getId(),new Long(1));
	}
	
	@Test
	public void jpaNativeQueryWithParam(){
		System.out.println("jpaNativeQueryWithParam");

		DocItem doc = repository.findByIdWithParam(new Long(1));
		System.out.println("id="+doc.getId());
		System.out.println("title="+doc.getTitle());
		System.out.println("content="+doc.getContent());
		System.out.println("version="+doc.getVersion());
		assertEquals(doc.getId(),new Long(1));
	}
	
	@Test
	public void jpaNativeQueryList(){
		System.out.println("jpaNativeQueryList");
		List<DocItem> result= repository.list();
		for(DocItem doc:result){
			System.out.println("id="+doc.getId());
			System.out.println("title="+doc.getTitle());
			System.out.println("content="+doc.getContent());
			System.out.println("version="+doc.getVersion());
		}
	}
	
	/**
	 *HQL을 사용할 경우만 자동 paging,sorting 기능이 적용된다.
	 */
	@Test
	public void jpaHqlPaging(){
		 System.out.println("jpaHqlPaging");
		 PageRequest page = new  PageRequest(0,10);
		 Page<DocItem> result= repository.paging(page);
		List<DocItem> list = result.getContent();
		
		System.out.println("result size="+result.getTotalElements());
		
		
	}
	
	/**
	 *HQL을 사용할 경우만 자동 paging,sorting 기능이 적용된다.
	 * 단점으로 join후 페이징을 한다. 
	 */
	@Test
	public void jpaHqljoin(){
		System.out.println("Hql join list");
		 PageRequest page = new  PageRequest(0,10);
		 Page<DocItem>result= repository.join(page);
		System.out.println("result size="+result.getTotalElements());
		
	}
	
	/**
	 * Tuple은  HQL만 지원 
	 */
	@Test
	public void listbyReturnTuple(){
		System.out.println("listbyReturnTuple");
		List<Tuple> list = repository.listbyReturnTuple();
		
		for(Tuple t : list){
			System.out.println(t.get(0));
			System.out.println(t.get(1));
			//System.out.println(t.get("DocItem"));
			for(TupleElement<?> te : t.getElements())
			{
					System.out.println("te="+te.getAlias());
					System.out.println("te="+te.getJavaType());
					System.out.println("te="+te.getClass());
					
			}
		}
	}
	
	
	
	
	
	
	@Test
	public void queryDsl() throws Exception{
		QDocItem docItem = QDocItem.docItem;
		PageRequest page = new  PageRequest(0,10);

		System.out.println("queryDsl");
		QueryResults<DocItem> result = sql.getList(page);
		List<DocItem>  list= result.getResults();
		System.out.println("TOTAL count="+result.getTotal());
		
		
	}
	
	@Test
	public void queryDslByEntity() throws Exception{
		System.out.println("queryDslByEntity");
		PageRequest page = new  PageRequest(0,10);

		 QueryResults<com.querydsl.core.Tuple> result = sql.getListByEntity(page);
		List<com.querydsl.core.Tuple> list = result.getResults();
		System.out.println("TOTAL count="+result.getTotal());
		for(com.querydsl.core.Tuple d:list){
			System.out.println((d.get(0, DocItem.class).getId() + " "+(d.get(1, Member.class)).getNickname()));
		}
	}
	
	@Test
	public void queryByEmJqpl() throws Exception
	{
		System.out.println("queryByEmJqpl");
		PageRequest page = new  PageRequest(0,10);

		List<Tuple> list = sql.getListByJpql("test",page);
		for(Tuple t : list){
			
			System.out.format("%s %s\n\r",t.get("id"),t.get("title"));
		}
		
		
	}
	
	@Test
	public void getListByJpqlWithoutField() throws Exception
	{
		System.out.println("getListByJpqlWithoutField");
		PageRequest page = new  PageRequest(0,10);

		List<DocItem> list = sql.getListByJpqlWithoutField("test" ,page);
		for(DocItem  d : list){
			System.out.println(d.getId());
			System.out.println(d.getTitle());
			System.out.println(d.getContent());
			System.out.print("\n\r");
		}
	}
	
	@Test
	public void getListByNativeQuery() throws Exception{
		System.out.println("getListByNativeQuery");
		PageRequest page = new  PageRequest(0,10);

		List<Object[]> list = sql.getListByNativeQuery("test",page);
		for(Object[] t : list){
			System.out.format("%s %s\n\r",t[0],t[1]);
		}
	}
	
	
	
	@Test
	public void getTableName(){
		
		System.out.println("TableName="+ClassMetaData.getTableName(DocItem.class));
		

	}
}
