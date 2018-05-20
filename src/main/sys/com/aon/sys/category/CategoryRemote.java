package com.aon.sys.category;

import java.util.List;

import org.hibernate.HibernateException;

import com.aon.lib.cache.CacheCommand;
import com.aon.lib.cache.CacheService;
import com.aon.lib.jpa.EntityManagerService;
import com.aon.lib.tree.Node;
import com.aon.lib.tree.Tree;


/**
 * 캐시 설정 Class
 */
abstract class CategoryRemote
{
	/**
	 * 전달된 Category 정보를 캐시에 반영한다.
	 */
	@SuppressWarnings("serial")
	static void added(final Category category, final Category parent) throws Exception
	{
		CacheService.send(new CacheCommand()
		{
			public void execute()
			{
				Tree t = CategoryCache.getTree();
				t.add(category, parent);
			}
		});
	}

	/**
	 * cache되어 있는 Category 객체를 변경한다.
	 */
	@SuppressWarnings("serial")
	static void updated(final Category category) throws Exception
	{
		CacheService.send(new CacheCommand()
		{
			public void execute()
			{
				Tree t = CategoryCache.getTree();
				t.update(category);
			}
		});
	}

	/**
	 * Category의 위치를 변경한다.
	 */
	@SuppressWarnings("serial")
	static void moved(final Category category, final Category srcParent, final Category dstParent) throws Exception
	{
		CacheService.send(new CacheCommand()
		{
			public void execute()
			{
				Tree t = CategoryCache.getTree();
				t.move(category, srcParent, dstParent);
			}
		});
	}

	/**
	 * Category의 위 아래 순서를 변경한다.
	 */
	@SuppressWarnings("serial")
	static void swapped(final Category movedUp, final Category movedDown) throws Exception
	{
		CacheService.send(new CacheCommand()
		{
			public void execute()
			{
				Tree t = CategoryCache.getTree();
				t.swap(movedUp, movedDown);
			}
		});
	}

	/**
	 * Category가 삭제된 경우에 호출한다.
	 */
	@SuppressWarnings("serial")
	static void removed(final Category category, final Category parent) throws Exception
	{
		CacheService.send(new CacheCommand()
		{
			public void execute()
			{
				Tree t = CategoryCache.getTree();
				t.remove(category, parent);
			}
		});
	}

	/**
	 * Root를 캐시에서 삭제한다.
	 */
	@SuppressWarnings("serial")
	static void removedRoot(final Category root) throws Exception
	{
		CacheService.send(new CacheCommand()
		{
			public void execute()
			{
				Tree t = CategoryCache.getTree();
				t.remove(root, null);
			}
		});
	}

	/**
	 * Root를 캐시에 추가한다.
	 */
	@SuppressWarnings("serial")
	static void addedRoot(final Category root) throws Exception
	{
		CacheService.send(new CacheCommand()
		{
			public void execute()
			{
				Tree t = CategoryCache.getTree();
				List<Node> nodes = null;
				try
				{
					nodes = getListByRoot(root);
				}
				catch (Exception e)
				{
					e.printStackTrace();
				}
				if (nodes != null)
					t.addNodes(nodes);
			}
		});
	}

	/**
	 * 전달된 Category 를 Root로 가지는 Category List를 돌려준다.
	 */
	@SuppressWarnings("unchecked")
	static List<Node> getListByRoot(Category root) throws HibernateException, Exception
	{
		javax.persistence.Query q = EntityManagerService.createNamedQuery("com.aon.sys.category.listByRootForCache");
		q.setParameter("rootId", root.getId());
		List<Node> l = q.getResultList();
		return l;

	}
}
