package com.aon.doc.reply;

import java.util.List;

import com.aon.doc.BaseDoc;
import com.aon.lib.jpa.ClassMetaData;
import com.aon.lib.jpa.EntityManagerService;

class ReplyStepPos
{
	private String parent;
	private String increaseBelow;
	private String lastStep;
	private String nextStep;

	ReplyStepPos(Class<?> clazz)
	{
		String tableName = ClassMetaData.getTableName(clazz);
		String identifier =  ClassMetaData.getIdentifierCoulumnName(clazz);
		
		StringBuffer parentQuery = new StringBuffer();
		parentQuery.append("SELECT step, position FROM ");
		parentQuery.append(tableName);
		parentQuery.append(" WHERE ");
		parentQuery.append(identifier);
		parentQuery.append("= ?");
		parent = parentQuery.toString();

		StringBuffer nextStepQuery = new StringBuffer();
		nextStepQuery.append("SELECT step FROM ");
		nextStepQuery.append(tableName);
		nextStepQuery.append(" WHERE group_id = ? "); // 같은 그룹
		nextStepQuery.append("AND step > ? "); // 아래쪽
		nextStepQuery.append("AND position <= ? "); // 깊이는 같거나 작음
		nextStepQuery.append("ORDER BY step "); // 첫번째
		nextStep = nextStepQuery.toString();

		StringBuffer increaseBelowQuery = new StringBuffer();
		increaseBelowQuery.append("UPDATE ");
		increaseBelowQuery.append(tableName);
		increaseBelowQuery.append(" SET step = step + 1 ");
		increaseBelowQuery.append("WHERE group_id = ? AND step >= ? ");
		increaseBelow = increaseBelowQuery.toString();

		StringBuffer lastStepQeury = new StringBuffer();
		lastStepQeury.append("SELECT step ");
		lastStepQeury.append("FROM ");
		lastStepQeury.append(tableName);
		lastStepQeury.append(" WHERE group_id = ? ");
		lastStepQeury.append("ORDER BY step DESC ");
		lastStep = lastStepQeury.toString();
	}

	/**
	 * 문서의 pos와 step을 설정한다.
	 */
	void reply(BaseDoc server) throws Exception
	{
		
		Object[] o = getParent(server.getParentId());
		int parentStep = (int) o[0];
		int parentPos = (int) o[1];

		int step = getNextStep(server.getGroupId(), parentStep, parentPos);
		if (step < 0)
		{
			step = getLastStep(server.getGroupId()) + 1;
		}
		else
		{
			increaseBelow(server.getGroupId(), step);
		}

		server.setPosition(parentPos + 1);
		server.setStep(step);
	}

	/*
	 * parent의 ResultSet을 돌려준다.
	 */
	private Object[] getParent(Long pid) throws Exception
	{
		@SuppressWarnings("unchecked")
		List<Object[]> result = EntityManagerService.createNativeQuery(parent)
						.setParameter(1, pid)
						.getResultList();
		return result.get(0);
	}

	/*
	 * 문서의 마지막 자녀 다음 문서의 step 값을 돌려준다.
	 */
	private int getNextStep(Long gid, int step, int pos) throws Exception
	{
		@SuppressWarnings("unchecked")
		List<Object> result =  EntityManagerService.createNativeQuery(nextStep)
				.setParameter(1, gid)
				.setParameter(2, step)
				.setParameter(3, pos).getResultList();

		if (!result.isEmpty())
		{
			return (int) result.get(0);
		}
		return -1;
	}

	/*
	 * 문서 그룹에 속한 마지막 문서의 step 값을 돌려준다.
	 */
	private int getLastStep(Long gid) throws Exception
	{
		@SuppressWarnings("unchecked")
		List<Object> result = EntityManagerService.createNativeQuery(lastStep)
				.setParameter(1, gid).getResultList();

		if (!result.isEmpty())
		{
			return (int) result.get(0);
		}
		return -1;
	}

	/*
	 * 문서그룹에서 주어진 step 이하의 문서의 step 값을 증가시킨다.
	 */
	private void increaseBelow(Long gid, int step) throws Exception
	{
		EntityManagerService.createNativeQuery(increaseBelow)
		.setParameter(1, gid)
		.setParameter(2, step)
		.executeUpdate();
	}

}
