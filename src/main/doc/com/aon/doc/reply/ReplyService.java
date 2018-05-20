package com.aon.doc.reply;

import com.aon.doc.BaseDoc;
import com.aon.lib.jpa.EntityManagerService;

/**
 * 계층형 게시판 기능을 제공한다.
  */
public class ReplyService
{
	private ReplyStepPos _stepPos;
	private ReplyCount _count;

	public ReplyService(Class<?> clazz)
	{
		_stepPos = new ReplyStepPos(clazz);
		_count = new ReplyCount(clazz);
	}

	
	public void setStepPos(BaseDoc server) throws Exception
	{
		if (server.isReply())
		{
			_stepPos.reply(server);
		}
		else
		{
			server.setPosition(0);
			server.setStep(0);
		}
	}

	
	public void increaseParentRplyCnt(BaseDoc server) throws Exception
	{
		EntityManagerService.flush();

		if (server.isReply())
		{
			_count.increaseRplyCnt(server.getParentId());
		}
	}

	/**
	 * 답변일 경우, 상위 글의 답변수를 감소시킨다.
	 * <p>
	 * flush하고 jdbc를 이용한다.
	 */
	public void decreaseParentRplyCnt(BaseDoc server) throws Exception
	{
		EntityManagerService.flush();

		if (server.isReply())
		{
			_count.decreaseRplyCnt(server.getParentId());
		}
	}

	/**
	 * 해당 문서에 대한 답글이 있는지를 돌려준다.
	 */
	public boolean hasReply(BaseDoc item) throws Exception
	{
		return _count.hasReply(item.getId());
	}

	/**
	 * 해당 문서에 대한 답글이 있는지를 돌려준다. 삭제된 상태의 문서는 제외한다.
	 */
	public boolean hasReplyExclOfStatus(BaseDoc item) throws Exception
	{
		return _count.hasReplyExclOfStatus(item.getId());
	}

	/**
	 * 해당 문서의 상위글 존재여부를 돌려준다. 삭제된 상태의 문서는 제외한다.
	 * @param item
	 * @return 존재여부
	 * @throws Exception
	 */
	public boolean hasParent(BaseDoc item) throws Exception
	{
		return _count.hasParent(item.getParentId());
	}

	/**
	 * REMOVED 상태의 문서를 제외한 답글이 존재하는지 확인한다.
	 * @throws ReplyExistsException 답글이 존재하는 경우
	 */
	public void checkReply(BaseDoc item) throws Exception
	{
		if (hasReply(item))
		{
			throw new ReplyExistsException();
		}
	}

	/**
	 * 상위글(질문 또는 답변)이 존재하는지 확인한다. REMOVED 상태의 문서는 제외됨
	 * @throws ParentNotExistsException 답글이 존재하는 경우
	 */
	public void checkParentExists(BaseDoc item) throws Exception
	{
		if (item.isFlagCode(BaseDoc.ORPHAN_FLAG)
			|| (item.getParentId() != null && !hasParent(item)))
		{
			throw new ReplyParentNotExistsException();
		}
	}
}
