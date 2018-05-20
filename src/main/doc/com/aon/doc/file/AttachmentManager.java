package com.aon.doc.file;

import java.util.LinkedList;
import java.util.List;

import javax.persistence.EntityManager;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aon.doc.BaseDoc;
import com.aon.lib.jpa.TxListener;
import com.aon.lib.jpa.TxService;
import com.aon.lib.repo.RepositoryService;


@Component
public class AttachmentManager<T extends BaseAttachment> {
	private static Log _log = LogFactory.getLog(AttachmentManager.class);
	
	@Autowired
	public EntityManager em;
	/**
	 * 첨부파일을 repository에 저장하거나 삭제하고,
	 * <p>
	 * 삭제된 첨부파일은 포함되지 않은 새로운 Set을 돌려준다.
	 */
	public List<T> update(List<T> list, BaseDoc item)
		throws Exception
	{
		List<T> newAttachments = new LinkedList<T>();
		if (list != null)
		{
			for (T att : list)
			{
				att.setEntity(item); // DbService.flush할 때에 값이 필요함
				update(att);
				if (!att.isDelete())
				{
					newAttachments.add(att);
				}
			}
		}
		return newAttachments;
	}

	/**
	 * 첨부파일의 method에 따라 repository와 database에 저장하고 삭제한다.
	 */
	public void update(BaseAttachment att) throws Exception
	{
		handleXA(att);
		handleDB(att);
		
	}

	/**
	 * method에 따라 repository에 저장/삭제한다.
	 */
	private void handleXA(BaseAttachment att) throws Exception
	{
		if (att.isMove() || att.isDelete())
		{
			deleteXA(att);
		}
		if (att.isMove() || att.isCopy())
		{
			storeXA(att);
		}
	}

	/**
	 * method에 따라 database에 저장/삭제한다.
	 */
	private void handleDB(BaseAttachment att) throws Exception
	{
		if (att.isDelete())
		{
			 em.remove(em.contains(att) ? att : em.merge(att));
		}
		else if (att.isMove() || att.isCopy() || att.isLink() || att.isMime())
		{
			em.persist(att);
		}
	}

	/**
	 * 첨부파일을 모두 제거한다.
	 */
	public void remove(List<T> attachments) throws Exception
	{
		if (attachments != null)
		{
			for (BaseAttachment att : attachments)
			{
				deleteXA(att);
			}
		}
	}

	/**
	 * 첨부파일을 모두 제거한다. DB도 삭제
	 */
	public void removeAll(List<T> attachments) throws Exception
	{
		if (attachments != null)
		{
			for (BaseAttachment att : attachments)
			{
				deleteXA(att);
				em.remove(em.contains(att) ? att : em.merge(att));
			}
		}
	}

	/**
	 * 첨부파일을 repository에 저장한다. rollback할 경우 다시 삭제된다.
	 * <p>
	 * 새로운 저장 정보가 att에 설정된다.
	 */
	public void storeXA(BaseAttachment att) throws Exception
	{
		storeXA(att, RepositoryService.getDefaultRepositoryType());
	}

	public void storeXA(BaseAttachment att, final Integer type) throws Exception
	{
		final String path = RepositoryService.getRepository(type).store(att);
		att.setType(type);
		att.setPath(path);

		TxService.addTxListener(new TxListener()
		{
			public void commit()
			{
			}

			public void rollback() 
			{
				try {
					RepositoryService.getRepository(type).delete(path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * 파일을 repository에서 삭제한다.
	 * <p>
	 * 실제로는 commit할 때에 삭제된다.
	 * <p>
	 * 삭제 될 파일의 path가 gid로 묶인 item 중 같은 path가 없는 파일만 삭제한다.
	 */
	public void deleteXA(BaseAttachment att)
	{
		final Integer type = att.getType();
		final String path = att.getPath();
	

		TxService.addTxListener(new TxListener()
		{
			public void commit()
			{
				try
				{
						RepositoryService.getRepository(type).delete(path);
					
				}
				catch (Exception e)
				{
					if (_log.isErrorEnabled())
					{
						_log.error(e.getMessage(), e);
					}
				}
			}

			public void rollback() 
			{
			}
		});
	}

	
	
}
