package com.aon.sys.category;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.lib.cache.CacheService;
import com.aon.lib.tree.Node;
import com.aon.lib.tree.NodeVisitor;
import com.aon.lib.tree.Tree;
import com.aon.lib.tree.Tree.Entry;


@Service
public class CategoryCache {

	
	private static CategoryService service;
	
	@Autowired
	 void setCategoryService(CategoryService service){
		CategoryCache.service = service;
	 }
	/**
	 * tree 정보를 cache한다.
	 */
	public static void setTree(Tree tree)
	{
		CacheService.put(CategoryCache.class, tree);
	}

	/**
	 * cache된 트리 정보를 돌려준다.
	 */
	public static Tree getTree()
	{
		return (Tree) CacheService.get(CategoryCache.class);
	}

	/**
	 * cache를 초기화한다.
	 */
	@PostConstruct
	static void init() throws Exception
	{
		if (getTree() == null)
		{
			Tree tree = new Tree(service.list());
			setTree(tree);
		}
	}
	
	/**
	 * cache를 refresh한다.
	 */
	public static void refresh() throws Exception
	{
		Tree tree = new Tree(service.list());
		setTree(tree);
	}


	/**
	 * cache된 Folder를 돌려준다. 없는 경우 null을 돌려준다.
	 */
	public static Category getCategory(Long id)
	{
		Tree.Entry e = getTree().getEntry(id);
		if (e == null)
		{
			return null;
		}
		return (Category) e.getNode();
	}

	
	/**
	 * 유일한 자녀인지의 여부를 돌려준다.
	 */
	public static int getChildrenCount(Long id)
	{
		Tree.Entry entry = getTree().getEntry(id);
		return entry.getChildrenCount();
	}

	/**
	 * 첫 자녀를 돌려준다. 자녀가 없을 경우 null을 돌려준다.
	 */
	public static Category getFisrtChild(Long pid)
	{
		Tree.Entry entry = getTree().getEntry(pid);
		Tree.Entry first = entry.getFisrtChild();
		return (first == null) ? null : (Category) first.getNode();
	}
	
	/**
	 * 마지막 자녀를 돌려준다. 자녀가 없을 경우 null을 돌려준다.
	 */
	public static Category getLastChild(Long id)
	{
		Tree.Entry entry = getTree().getEntry(id);
		Tree.Entry last = entry.getLastChild();
		return (last == null) ? null : (Category) last.getNode();
	}

	public static Category getRootLastChild()
	{
		Tree.Entry entry = (Entry) CacheService.get(CategoryCache.class);
		Tree.Entry last = entry.getLastChild();
		return (last == null) ? null : (Category) last.getNode();
	}
	
	/**
	 * 최상위부터 자기자신까지 Node들을 방문한다.
	 * <p>
	 * cache에 node가 없는 경우 아무일도 하지 않는다.
	 */
	public static void visitAncestorsOrSelf(Long id, NodeVisitor visitor)
	{
		Tree.Entry entry = getTree().getEntry(id);
		if (entry != null)
		{
			entry.visitAncestorsOrSelf(visitor);
		}
	}

	/**
	 * suspectedId가 id의 상위 노드 혹은 자기 자신의 id인지를 돌려준다.
	 */
	public static boolean isAncestorOrSelfId(Long id, final Long suspectedId)
	{
		Tree.Entry entry = getTree().getEntry(id);
		if (entry != null)
		{
			return entry.isAncestorOrSelfId(suspectedId);
		}
		return false;
	}

	/**
	 * cache된 Folder의 level을 돌려준다.
	 */
	public static int getLevel(Long id)
	{
		return getTree().getEntry(id).getAncestorsOrSelfCount();
	}

	/**
	 * 자기자신을 포함하여 하위의 Node들을 방문한다.
	 */
	public static void visitSelfOrDescendants(Long id, NodeVisitor visitor)
	{
		Tree.Entry entry = getTree().getEntry(id);
		if (entry != null)
		{
			entry.visitSelfOrDescendants(visitor);
		}
	}

	/**
	 * 자기자신을 포함하여 형제 Node들을 방문한다.
	 */
	public static void visitSelfOrNextSiblings(Long id, NodeVisitor visitor)
	{
		Tree.Entry entry = getTree().getEntry(id);
		if (entry != null)
		{
			entry.visitSelfOrNextSiblings(visitor);
		}
	}

	/**
	 * 자식 Node들만 방문한다.
	 */
	public static void visitChildren(Long id, NodeVisitor visitor)
	{
		Tree.Entry entry = getTree().getEntry(id);
		if (entry != null)
		{
			entry.visitChildren(visitor);
		}
	}

	

	/**
	 * FolderLevel 객체의 level1, level2, level3, level4 속성을 설정한다.
	 */
	public static void setLevel(final CategoryReference ref, final Long id)
	{
		ref.setLevel1(null);
		ref.setLevel2(null);
		ref.setLevel3(null);
		ref.setLevel4(null);
		CategoryCache.visitAncestorsOrSelf(id, new NodeVisitor()
		{
			int i = 1;

			public void visit(Node node)
			{
				switch (i)
				{
					case 1 :
						ref.setLevel1(node.getId());
						break;
					case 2 :
						ref.setLevel2(node.getId());
						break;
					case 3 :
						ref.setLevel3(node.getId());
						break;
					case 4 :
						ref.setLevel4(node.getId());
						break;
				}
				i++;
			}
		});
	}

	
}
