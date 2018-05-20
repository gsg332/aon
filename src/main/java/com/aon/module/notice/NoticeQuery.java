package com.aon.module.notice;

import java.util.Date;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Service
public class NoticeQuery extends Query {

	/**
	 * 공지사항 리스트
	 * 
	 * @param page
	 * @param searchKey
	 * @param searchValue
	 * @return
	 * @throws Exception
	 */
	public QueryResults<Notice> list(Pageable page, String searchKey, String searchValue) throws Exception {
		QNotice notice = QNotice.notice;
		JPAQuery<?> query = getQuery();

		BooleanExpression searchQuery = null;
		
		if(!searchValue.equals("")){
			if(searchKey.equals("all")){
				searchQuery = notice.title.like('%'+searchValue+'%').or(notice.content.like('%'+searchValue+'%'));
			}else if(searchKey.equals("content")){
				searchQuery = notice.content.like('%'+searchValue+'%');
			}else if(searchKey.equals("title")){
				searchQuery = notice.title.like('%'+searchValue+'%');
			}
		}
		
		return query.select(Projections.fields(Notice.class
													,notice.id
													,notice.title
													,notice.readCount
													,notice.insertDate))
					.from(notice)
					.where(searchQuery)
					.orderBy(notice.insertDate.desc())
					.offset(page.getOffset())
					.limit(page.getPageSize())
					.fetchResults(); 
	}
	
	/**
	 * 공지사항 이전글
	 * 
	 * @param id
	 * @param searchKey
	 * @param searchValue
	 * @param insertDate
	 * @return
	 * @throws Exception
	 */
	public Notice getPrevious(Long id, String searchKey, String searchValue, Date insertDate) throws Exception {
		QNotice notice = QNotice.notice;
		JPAQuery<?> query = getQuery();
		
		BooleanExpression searchQuery = null;
		
		if(!searchValue.equals("")){
			if(searchKey.equals("all")){
				searchQuery = notice.title.like('%'+searchValue+'%').or(notice.content.like('%'+searchValue+'%'));
			}else if(searchKey.equals("content")){
				searchQuery = notice.content.like('%'+searchValue+'%');
			}else if(searchKey.equals("title")){
				searchQuery = notice.title.like('%'+searchValue+'%');
			}
		}
		
		return query.select(Projections.fields(Notice.class,notice.id,notice.title))
					.from(notice)
					.where(notice.insertDate.lt(insertDate))
					.where(searchQuery)
					.orderBy(notice.insertDate.desc())
					.orderBy(notice.id.desc())
					.fetchFirst();
	}
	
	/**
	 * 공지사항 다음글
	 * 
	 * @param id
	 * @param searchKey
	 * @param searchValue
	 * @param insertDate
	 * @return
	 * @throws Exception
	 */
	public Notice getNext(Long id, String searchKey, String searchValue, Date insertDate) throws Exception {
		QNotice notice = QNotice.notice;
		JPAQuery<?> query = getQuery();
		
		BooleanExpression searchQuery = null;
		
		if(!searchValue.equals("")){
			if(searchKey.equals("all")){
				searchQuery = notice.title.like('%'+searchValue+'%').or(notice.content.like('%'+searchValue+'%'));
			}else if(searchKey.equals("content")){
				searchQuery = notice.content.like('%'+searchValue+'%');
			}else if(searchKey.equals("title")){
				searchQuery = notice.title.like('%'+searchValue+'%');
			}
		}
		
		return query.select(Projections.fields(Notice.class,notice.id,notice.title))
					.from(notice)
					.where(notice.insertDate.gt(insertDate))
					.where(searchQuery)
					.orderBy(notice.insertDate.asc())
					.orderBy(notice.id.desc())
					.fetchFirst();
	}
	
	/**
	 * 공지사항 삭제
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public long delete(Long id) throws Exception {
		QNotice notice = QNotice.notice;
		JPAQueryFactory query = getQueryFactory();
		
		return query.delete(notice).where(notice.id.eq(id)).execute();
	}
}
