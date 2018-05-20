package com.aon.sys.member;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aon.lib.tree.Node;
import com.aon.lib.tree.NodeVisitor;
import com.aon.sys.category.Category;
import com.aon.sys.category.CategoryCache;
import com.aon.sys.category.CategoryEvent.Delete;
import com.aon.sys.category.CategoryEvent.Move;
import com.aon.sys.category.CategoryException;
import com.aon.sys.category.ICategoryListener;

@Component
public class MemberCategoryListener implements ICategoryListener {
	
	@Autowired
	MemberService service;
	
	@Override
	public void move(Move e) throws Exception {
		Category category = (Category)e.getSource();
		
		// qa_item_category level update
		final List<Node> l = new LinkedList<Node>();
		CategoryCache.visitAncestorsOrSelf(category.getId(), new NodeVisitor()
		{
			public void visit(Node node)
			{
				l.add(node);
			}
		});

		service.updateCategoriesByListener(category.getId(), l);
	}
	
	@Override
	public void delete(Delete e) throws Exception {
		Category category = (Category)e.getSource();
		
		List<Object> contentsCount = service.getContentsCount(category.getId());
		int count = Integer.parseInt(contentsCount.get(0).toString());
		if (count > 0) {
			throw new CategoryException.DenyRemoveException();
		}
	}
}
