package com.aon.sys.schedule;

import java.util.Date;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.sys.schedule.log.QSysLog;
import com.aon.sys.schedule.log.SysLog;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Service
public class ScheduleQuery extends Query {

	/**
	 * 스케쥴 리스트
	 * 
	 * @param page
	 * @param searchValue
	 * @return
	 * @throws Exception
	 */
	public QueryResults<Schedule> list(Pageable page, String searchValue) throws Exception {
		QSchedule schedule = QSchedule.schedule;
		JPAQuery<?> query = getQuery();
		
		BooleanExpression searchQuery = null;
		
		if(!searchValue.equals("")){
			searchQuery = schedule.className.like('%'+searchValue+'%');
		}
		
		return query.select(Projections.fields(Schedule.class
													,schedule.id
													,schedule.className
													,schedule.param
													,schedule.result
													,schedule.paused
													,schedule.insertDate
													,schedule.runDate
													,schedule.cron
													,schedule.interval))
					.from(schedule)
					.where(searchQuery)
					.orderBy(schedule.id.desc())
					.offset(page.getOffset())
					.limit(page.getPageSize())
					.fetchResults(); 
	}
	
	/**
	 * 스케쥴 삭제
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public long delete(Long id) throws Exception {
		QSchedule schedule = QSchedule.schedule;
		JPAQueryFactory query = getQueryFactory();
		
		return query.delete(schedule).where(schedule.id.eq(id)).execute();
	}
	
	/**
	 * 로고 리스트
	 * 
	 * @param page
	 * @param searchValue
	 * @return
	 * @throws Exception
	 */
	public QueryResults<SysLog> log(Pageable page, String searchValue, Date startDate, Date endDate) throws Exception {
		QSysLog syslog = QSysLog.sysLog;
		JPAQuery<?> query = getQuery();
		
		BooleanExpression searchQuery = null;
		BooleanExpression searchStartQuery = null;
		BooleanExpression searchEndQuery = null;
		
		if(!searchValue.equals("")){
			searchQuery = syslog.name.like('%'+searchValue+'%'); 
		}
		
		if(startDate != null){
			searchStartQuery = syslog.insertDate.goe(startDate);
		}
		
		if(endDate != null){
			searchEndQuery = syslog.insertDate.loe(endDate);
		}
		
		return query.select(Projections.fields(SysLog.class
													,syslog.id
													,syslog.name
													,syslog.insertDate
													,syslog.param
													,syslog.result
													,syslog.detail
													,syslog.ip))
					.from(syslog)
					.where(searchQuery)
					.where(searchStartQuery)
					.where(searchEndQuery)
					.orderBy(syslog.id.desc())
					.offset(page.getOffset())
					.limit(page.getPageSize())
					.fetchResults(); 
	}
}
