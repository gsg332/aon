package com.aon.lib.tree;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


public class Tree implements Serializable
{
	private static final long serialVersionUID = 2547346503794385305L;

	private Map<Long, Entry> entries = new HashMap<Long, Entry>();
	private List<Entry> roots = new LinkedList<Entry>();
	private List<Entry> orphans = new LinkedList<Entry>();

	/**
	 * 비어있는 Tree를 생성한다.
	 */
	public Tree()
	{
	}

	/**
	 * 트리를 생성하여 다수의 Node를 추가한다.
	 */
	public Tree(List<Node> nodes)
	{
		for (Node node : nodes)
		{
			addNode(node);
		}
	}

	/**
	 * 트리를 복사하여 생성한다. Node 객체는 복사되지 않는다.
	 */
	public Tree(Tree tree)
	{
		for (Entry e : tree.roots)
		{
			addEntry(e);
		}

		for (Entry e : tree.orphans)
		{
			addEntry(e);
		}
	}

	/**
	 * 하위 노드까지 모두 복사한다.
	 */
	private void addEntry(Entry e)
	{
		addNode(e.getNode());
		for (Entry child : e._children)
		{
			addEntry(child);
		}
	}

	/**
	 * Node를 추가한다.
	 */
	private void addNode(Node node)
	{
		Long id = node.getId();

		// entry를 생성하여 추가한다.
		Entry entry = addEntry(node);

		// orphan들을 검사하여 자식인 경우 추가한다.
		// 매번 검사해야 순서를 유지할 수 있다.
		for (Iterator<Entry> i = orphans.iterator(); i.hasNext();)
		{
			Entry orphan = i.next();
			if (orphan._node.getParentId().equals(id))
			{
				entry.appendChild(orphan);
				i.remove();
			}
		}
	}

	private Entry addEntry(Node node)
	{
		Entry entry = new Entry();
		entry.setNode(node);

		Long id = node.getId();
		entries.put(id, entry);

		// 상위 노드에 추가한다.
		Long parentId = node.getParentId();
		Entry parent = entries.get(parentId);
		if (parentId == null)
		{
			roots.add(entry);
		}
		else if (parent == null)
		{
			orphans.add(entry);
		}
		else
		{
			parent.appendChild(entry);
		}

		return entry;
	}

	/**
	 * 주어진 id에 일치하는 저장된 Entry를 돌려준다. Entry가 없는 경우 null을 돌려준다.
	 */
	public Entry getEntry(Long id)
	{
		return entries.get(id);
	}

	/**
	 * Node를 추가한다.
	 */
	public void add(Node child, Node parent)
	{
		addNode(child);
		if (parent != null)
		{
			update(parent);
		}
	}
	
	public void addNodes(List<Node> nodes)
	{
		for (Node node : nodes)
		{
			addNode(node);
		}
	}

	/**
	 * Node를 제거한다.
	 * <p>
	 * 하위 노드도 제거된다.
	 */
	public void remove(Node child, Node parent)
	{
		Entry c = entries.remove(child.getId());
		if (parent != null)
		{
			Entry p = entries.get(parent.getId());
			p.removeChild(c);
			p.setNode(parent);
		}
		else
		{
			roots.remove(c);
		}
		c.clear();
	}

	/**
	 * 해당 위치의 Node를 대체한다.
	 * @throws NullPointerException Node가 없는 경우
	 */
	public void update(Node node)
	{
		Entry e = entries.get(node.getId());
		e.setNode(node);
	}

	/**
	 * Node를 이동한다.
	 * <p>
	 * Node를 기존 위치에서 새롭게 설정된 parent의 하위로 이동한다. Node들은 모두 새로운 Node로 대체된다.
	 * @throws NullPointerException Node가 없는 경우
	 */
	public void move(Node node, Node srcParent, Node dstParent)
	{
		Entry child = entries.get(node.getId());
		Entry src = entries.get(srcParent.getId());
		Entry dst = entries.get(dstParent.getId());
		child.setNode(node);
		src.setNode(srcParent);
		dst.setNode(dstParent);
		src.removeChild(child);
		dst.appendChild(child);
	}

	/**
	 * 두 노드의 위치를 바꾼다. Node들은 모두 새로운 Node로 대체된다.
	 */
	public void swap(Node n1, Node n2)
	{
		Long id1 = n1.getId();
		Long id2 = n2.getId();
		Entry e1 = entries.get(id1);
		Entry e2 = entries.get(id2);
		e1.setNode(n1);
		e2.setNode(n2);
		Entry p1 = e1._parent;
		Entry p2 = e2._parent;
		List<Entry> s1 = (p1 == null) ? roots : p1._children;
		List<Entry> s2 = (p2 == null) ? roots : p2._children;
		int i1 = s1.indexOf(e1);
		int i2 = s2.indexOf(e2);
		s1.remove(i1);
		s1.add(i1, e2);
		s2.remove(i2);
		s2.add(i2, e1);
	}

	/**
	 * Garbage-Collection에 도움을 주기 위해 link를 모두 끊는다.
	 */
	public void clear()
	{
		for (Entry e : roots)
		{
			e.clear();
		}

		for (Entry e : orphans)
		{
			e.clear();
		}
		entries.clear();
		roots.clear();
		orphans.clear();
	}

	/**
	 * 실제로 필요한 정보를 계산할 때에는 iterate해야 하기 때문에 ancestors, descendants, leaves 등을 cache하는 것은
	 * 의미가 없다.
	 */
	public static class Entry implements Serializable
	{
		private static final long serialVersionUID = -9205903377342057357L;

		private Node _node = null;
		private Entry _parent = null;
		private LinkedList<Entry> _children = new LinkedList<Entry>();

		private Entry()
		{
		}

		/**
		 * Node 객체를 돌려준다.
		 */
		public Node getNode()
		{
			return _node;
		}

		public void setNode(Node node)
		{
			_node = node;
		}

		/**
		 * 현재 entry에 해당 entry를 추가한다.
		 */
		private void appendChild(Entry child)
		{
			try
			{
				if (isSelfOrAncestor(child))
				{
					throw new IllegalArgumentException("Recursion detected folderId="
						+ child.getNode().getId());
				}
				child._parent = this;
				_children.add(child);
			}
			catch (IllegalArgumentException e)
			{
				e.printStackTrace();
			}
		}

		/**
		 * 현재 entry를 상위 entry에서 제거한다.
		 */
		private void removeChild(Entry child)
		{
			_children.remove(child);
			child._parent = null;
		}

		/**
		 * 주어진 Entry 객체가 self이거나 ancestor인지를 확인한다.
		 */
		private boolean isSelfOrAncestor(Entry child)
		{
			if (equals(child))
			{
				return true;
			}
			else if (_parent == null)
			{
				return false;
			}
			return _parent.isSelfOrAncestor(child);
		}

		/**
		 * garbage collection을 준비한다.
		 */
		private void clear()
		{
			for (Entry child : _children)
			{
				child.clear();
			}
			_children.clear();
			_node = null;
			_parent = null;
			_children = null;
		}

		/**
		 * root인지의 여부를 돌려준다.
		 */
		public boolean isRoot()
		{
			return (_parent == null);
		}

		/**
		 * leaf인지의 여부를 돌려준다.
		 */
		public boolean isLeaf()
		{
			return _children.isEmpty();
		}

		/**
		 * 자식 Node의 수를 돌려준다.
		 */
		public int getChildrenCount()
		{
			return _children.size();
		}

		/**
		 * 첫 자식 Entry를 돌려준다. 없을 경우 null을 돌려준다.
		 */
		public Entry getFisrtChild()
		{
			if (_children.isEmpty())
			{
				return null;
			}
			else
			{
				return (Entry) _children.getFirst();
			}
		}
		
		/**
		 * 마지막 자식 Entry를 돌려준다. 없을 경우 null을 돌려준다.
		 */
		public Entry getLastChild()
		{
			if (_children.isEmpty())
			{
				return null;
			}
			else
			{
				return (Entry) _children.getLast();
			}
		}

		/**
		 * 자식 Node를 방문한다.
		 */
		public void visitChildren(NodeVisitor visitor)
		{
			for (Entry c : _children)
			{
				visitor.visit(c._node);
			}
		}

		/**
		 * 상위부터 자기자신까지의 Node를 돌려준다.
		 */
		public void visitAncestorsOrSelf(NodeVisitor visitor)
		{
			if (_parent != null)
			{
				_parent.visitAncestorsOrSelf(visitor);
			}
			visitor.visit(_node);
		}

		/**
		 * 주어진 id가 자기 자신 혹은 상위 노드의 id인지의 여부를 돌려준다.
		 */
		public boolean isAncestorOrSelfId(Long suspectedId)
		{
			if (_node.getId().equals(suspectedId))
			{
				return true;
			}
			if (_parent != null)
			{
				return _parent.isAncestorOrSelfId(suspectedId);
			}
			return false;
		}

		/**
		 * depth를 돌려준다. root의 경우 1을 돌려준다.
		 */
		public int getAncestorsOrSelfCount()
		{
			return (_parent == null) ? 1 : _parent.getAncestorsOrSelfCount() + 1;
		}

		/**
		 * 자기자신을 포함하여 하위 노드의 객체를 순회한다.
		 */
		public void visitSelfOrDescendants(NodeVisitor visitor)
		{
			visitor.visit(_node);
			for (Entry c : _children)
			{
				c.visitSelfOrDescendants(visitor);
			}
		}

		/**
		 * 자기 자신과 하위 노드의 갯수를 돌려준다.
		 */
		public int getSelfOrDescendantsCount()
		{
			int count = 1;
			for (Entry c : _children)
			{
				count += c.getSelfOrDescendantsCount();
			}
			return count;
		}

		/**
		 * 자기자신을 포함하여 아래쪽 형제들의 Node 객체를 순회한다.
		 * <p>
		 * root일 경우는 자기 자신만을 순회한다.
		 */
		public void visitSelfOrNextSiblings(NodeVisitor visitor)
		{
			visitor.visit(_node);
			if (_parent != null)
			{
				_parent.visitNextChildren(visitor, this);
			}
		}

		/**
		 * 자식들 중에서 주어진 Node의 아래쪽 형제들의 Node 객체를 순회한다.
		 */
		private void visitNextChildren(NodeVisitor visitor, Entry child)
		{
			boolean visit = false;

			for (Entry e : _children)
			{
				if (visit)
				{
					visitor.visit(e._node);
				}
				else if (e == child)
				{
					visit = true;
				}
			}
		}

		public boolean equals(Object obj)
		{
			Entry e = (Entry) obj;
			return _node.equals(e._node);
		}

		public int hashCode()
		{
			return _node.hashCode();
		}

	}

}
