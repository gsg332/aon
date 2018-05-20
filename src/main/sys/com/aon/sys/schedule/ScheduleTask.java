package com.aon.sys.schedule;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Query;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.ObjectNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.aon.lib.jpa.EntityManagerService;
import com.aon.sys.lock.LockService;
import com.aon.sys.schedule.log.SysLogService;
import com.aon.sys.usr.UserService;

/**
 * ScheduleTask를 주기적으로 실행시킨다.
 * TODO: Lock 1차 테스트는 진행하였으나.. 수행기간이 긴 작업에서의 클러스터링 테스트해야함.
 * DBLock이 아니면 ResourceLock으로 해결해야함. 
 */
@Service
public class ScheduleTask 
{
	private static boolean _isRunning = false;

	private static Log _log = LogFactory.getLog(ScheduleTask.class);
	
	@Autowired
	private ApplicationContext ctx;
	@Autowired
	private SysLogService service;
	
	@Autowired
	@Qualifier("transactionManager")
	private PlatformTransactionManager txMgr;

	
	public void run() throws Exception {
		
		synchronized (ScheduleTask.class) {
			_isRunning = true;
		}
		try {
			UserService.setUserSession(new ScheduleUser());
			try {
				execute();

			} catch (Exception e) {
				e.printStackTrace();
			}
		} finally {
			UserService.setUserSession(null);
			synchronized (ScheduleTask.class) {
				_isRunning = false;
			}
		}

	}

	/**
	 * Application 정지시 stop 시킨다. 
	 */
	public void stop() {
		if (_log.isInfoEnabled()) {
			_log.info("Scheduler Stopping.....");
		}
		while (true) {
			synchronized (ScheduleTask.class) {
				if (!_isRunning) {
					break;
				}
			}
			try {
				if (_log.isWarnEnabled()) {
					_log.warn("Waiting...");
				}
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		if (_log.isInfoEnabled()) {
			_log.info("Scheduler Stopped.");
		}
	}

	@Transactional
	public void execute() throws Exception {
		LockService.lock("ScheduleTask.beginExecution()");
		while (true) {
			Schedule schedule = getSchedule();
			if (schedule == null) {
				break;
			}
			try {
				ISchedule newJob = (ISchedule)ctx.getBean(Class.forName(schedule.getClassName()));
				newJob.execute(schedule.getParam());
				success(schedule);
			} catch (Exception e) {
				fail(schedule, e);
			} 
		}
		LockService.unlock();
	}

	
	public void execute(Long id) throws Exception {
		Schedule schedule = getSchedule(id);
		if (schedule != null) {
			try {
				ISchedule newJob = (ISchedule)ctx.getBean(Class.forName(schedule.getClassName()));
				newJob.execute(schedule.getParam());
				success(schedule);
			} catch (Exception e) {
				fail(schedule, e);
			}
		}
	}

	/**
	 * 이미 실행중이지 않은 경우 schedule 정보를 돌려준다.
	 * @throws Exception 
	 */
	private Schedule getSchedule(Long id) throws Exception {
		
		 LockService.lock("ScheduleTask.beginExecution(Long)");
		DefaultTransactionDefinition txDefinition = new DefaultTransactionDefinition();
		txDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus = txMgr.getTransaction(txDefinition);
		try {
			

			Schedule schedule = EntityManagerService.load(Schedule.class, id);
			if (schedule.getResult() == Schedule.RUNNING) {
				schedule = null;
			} else {
				schedule.setResult(Schedule.RUNNING);
			}
			// Service.commitAndClose();
			txMgr.commit(txStatus);
			return schedule;
		} catch (Exception e) {
			txMgr.rollback(txStatus);
			throw e;
		} finally {
			 LockService.unlock();
		}
	}

	/**
	 * 우선순위(실행시간)가 높은 Schedule을 돌려준다.
	 */
	@SuppressWarnings("unchecked")
	private final Schedule getSchedule() throws Exception {

		//LockService.lock("ScheduleTask.beginExecution()"); 
		
		DefaultTransactionDefinition txDefinition = new DefaultTransactionDefinition();
		TransactionStatus txStatus = txMgr.getTransaction(txDefinition);
		try {
			

			Query query = EntityManagerService.createNamedQuery("com.aon.sys.schedule.Schedule.selectRecent");
			query.setParameter("sysdate", new Date());
			List<Schedule> result = query.getResultList();
			Iterator<Schedule> i = result.iterator();
			Schedule schedule = null;
			if (i.hasNext()) {
				schedule = (Schedule) i.next();
				schedule.setResult(Schedule.RUNNING);

				if (_log.isDebugEnabled()) {
					_log.debug("running schedule " + schedule.getClassName());
				}
			}
			txMgr.commit(txStatus);
			return schedule;
		} catch (Exception e) {
			e.printStackTrace();
			txMgr.rollback(txStatus);
			e.printStackTrace();
			throw e;
		} finally {
		//	 LockService.unlock();
		}
	}

	private void success(Schedule schedule) throws Exception {
		// LockService.lock("ScheduleTask.success ");

		DefaultTransactionDefinition txDefinition = new DefaultTransactionDefinition();
		TransactionStatus txStatus = txMgr.getTransaction(txDefinition);
		try {
			 if (schedule.isBulk()) {
				Schedule old = (Schedule) EntityManagerService.load(Schedule.class, schedule.getId());
				old.setResult(Schedule.SUCCESS);
				old.calcRunTime();
				service.success(schedule.getClassName(),schedule.getParam());
			} else {
				EntityManagerService.remove(schedule);
			}
			txMgr.commit(txStatus);
		} catch (ObjectNotFoundException e) {
		} catch (Exception e) {
			if (_log.isErrorEnabled()) {
				_log.error("failed to record job success", e);
			}
			e.printStackTrace();
			txMgr.rollback(txStatus);
		} finally {
		//	 LockService.unlock();
		}
	}

	private void fail(Schedule schedule, Exception ex)  throws Exception{

		DefaultTransactionDefinition txDefinition = new DefaultTransactionDefinition();
		TransactionStatus txStatus = txMgr.getTransaction(txDefinition);

		if (_log.isErrorEnabled()) {
			_log.error("job failed", ex);
		}
		try {
			Schedule old = (Schedule) EntityManagerService.load(Schedule.class, schedule.getId());
			old.setResult(Schedule.FAILED);
			old.calcRunTime(); 
			service.fail(schedule.getClassName(), schedule.getParam(), ex);
			txMgr.commit(txStatus);
		} catch (Exception e) {
			if (_log.isErrorEnabled()) {
				_log.error("failed to record job failure", e);
			}
			txMgr.rollback(txStatus);
			throw e; 
		}

	}

}
