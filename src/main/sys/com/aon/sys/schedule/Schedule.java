package com.aon.sys.schedule;


import java.util.Date;

import org.springframework.scheduling.support.CronTrigger;
import org.springframework.scheduling.support.SimpleTriggerContext;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Schedule extends BaseObject {

	private static final long serialVersionUID = 5220500412166767678L;

	/**
	 * 아직 실행되지 않음
	 */
	public static final int NONE = 0;

	/**
	 * 현재 실행 중
	 */
	public static final int RUNNING = 1000;

	/**
	 * 마지막 실행 결과 성공
	 */
	public static final int SUCCESS = 2000;

	/**
	 * 마지막 실행 결과 실패
	 */
	public static final int FAILED = 3000;

	@JsonView(BaseJsonView.Summary.class)
	private Date runDate;
	
	@JsonView(BaseJsonView.Summary.class)
	private Date insertDate;
	
	@JsonView(BaseJsonView.Summary.class)
	private String className;
	
	@JsonView(BaseJsonView.Summary.class)
	private String param;
	
	@JsonView(BaseJsonView.Summary.class)
	private int result;
	
	@JsonView(BaseJsonView.Summary.class)
	private String cron;
	
	@JsonView(BaseJsonView.Summary.class)
	private long interval;
	
	@JsonView(BaseJsonView.Summary.class)
	private boolean paused;

	
	public Date getRunDate() {
		return runDate;
	}
	public void setRunDate(Date runDate) {
		this.runDate = runDate;
	}
	public Date getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public String getCron() {
		return cron;
	}
	public void setCron(String cron) {
		this.cron = cron;
	}
	public long getInterval() {
		return interval;
	}
	public void setInterval(long interval) {
		this.interval = interval;
	}
	public boolean isPaused() {
		return paused;
	}
	public void setPaused(boolean paused) {
		this.paused = paused;
	}
	
	/**
	 * 실행시간을 계산한다.
	 * cron이나 interval이 설정되어 있어야 한다.
	 */
	public void calcRunTime() 
	{
		if (getCron() != null)
		{
			CronTrigger c = new CronTrigger(getCron());
			Date d = c.nextExecutionTime(new SimpleTriggerContext());
			setRunDate(d);
		}
		else if (getInterval() != 0)
		{
			Date d = new Date();
			d.setTime(d.getTime() + getInterval() * 1000);
			setRunDate(d);
		}
	}

	/**
	 * 주기적으로 작동하는 Schedule인지 돌려준다.
	 * 
	 * @return 주기적으로 작동하는지 여부
	 */
	public boolean isBulk()
	{
		return (getCron() != null || getInterval() != 0);
	}

	/**
	 * 새로운 값으로 update한다.
	 */
	public void update(Schedule client)
	{
		setClassName(client.getClassName());
		setCron(client.getCron());
		setInterval(client.getInterval());
		setParam(client.getParam());
	}
}