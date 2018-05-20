package com.aon.sys.category;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

import com.aon.doc.BaseJsonView;
import com.aon.lib.tree.Node;
import com.aon.lib.tree.NodeVisitor;
import com.fasterxml.jackson.annotation.JsonView;



public class CategoryReference implements Comparable<Object>, Serializable
{
	private static final long serialVersionUID = -751921353034135848L;

	@JsonView(BaseJsonView.Detail.class)
	private Long categoryId;
	private Long level1;
	private Long level2;
	private Long level3;
	private Long level4;
	private String tag;

	public CategoryReference()
	{
	}

	public CategoryReference(Long categoryId)
	{
		this.categoryId = categoryId;
		updateLevel();
	}


	public Long getCategoryId()
	{
		return categoryId;
	}

	public void setCategoryId(Long categoryId)
	{
		this.categoryId = categoryId;
	}

	
	public Long getLevel1()
	{
		return level1;
	}

	public void setLevel1(Long level1)
	{
		this.level1 = level1;
	}

	
	public Long getLevel2()
	{
		return level2;
	}

	public void setLevel2(Long level2)
	{
		this.level2 = level2;
	}

	
	public Long getLevel3()
	{
		return level3;
	}

	public void setLevel3(Long level3)
	{
		this.level3 = level3;
	}

	public Long getLevel4()
	{
		return level4;
	}

	public void setLevel4(Long level4)
	{
		this.level4 = level4;
	}
	
	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	
	public void updateLevel()
	{
		CategoryCache.setLevel(this, getCategoryId());
	}
	
	@JsonView(BaseJsonView.Detail.class)
	public List<String> getPath()
	{
		final List<String> list = new LinkedList<String>();
		CategoryCache.visitAncestorsOrSelf(categoryId, new NodeVisitor()
		{
			public void visit(Node node)
			{
				try
				{
					list.add(((Category) node).getName());
				}
				catch (Exception e)
				{
					e.printStackTrace();
				}
			}
		});
		return list;
	}

	public List<Node> getAncestorsOrSelf()
	{
		final List<Node> l = new LinkedList<Node>();
		CategoryCache.visitAncestorsOrSelf(getCategoryId(), new NodeVisitor()
		{
			public void visit(Node node)
			{
				l.add(node);
			}
		});
		return l;
	}

	/**
	 * (non-Javadoc)
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	public int compareTo(Object obj)
	{
		if (categoryId == null)
		{
			return 1;
		}
		Long folderId = ((CategoryReference) obj).getCategoryId();
		if (folderId == null)
		{
			return -1;
		}
		return folderId.compareTo(folderId);
	}

}
