package com.aon.sys.category;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.lib.tree.Node;
import com.querydsl.jpa.impl.JPAQuery;

@Service
public class CategoryQuery extends Query{

	@SuppressWarnings("unchecked")
	public List<Node> getAllList() throws Exception{
		List<Node> list = createNamedQuery("com.aon.sys.category.Category.allList").getResultList();
		return list;
		 	
	}

	@SuppressWarnings("unchecked")
	public List<Category> getList() throws Exception{
		QCategory category = QCategory.category;
		JPAQuery<?> query = getQuery();
		return (List<Category>) query.from(category).orderBy(category.sort.asc()).orderBy(category.id.asc()).fetch();
	}
	
	@SuppressWarnings("unchecked")
	public List<Category> getAllListByRootId(Long rootId) throws Exception{
		QCategory category = QCategory.category;
		JPAQuery<?> query = getQuery();
		return (List<Category>) query.from(category).where(category.rootId.eq(rootId)).orderBy(category.sort.asc()).fetch();
	}
	
	@SuppressWarnings("unchecked")
	public List<Category> getListByParent(Long pid) throws Exception{
		QCategory category = QCategory.category;
		JPAQuery<?> query = getQuery();
		return (List<Category>) query.from(category).where(category.parentId.eq(pid)).orderBy(category.sort.asc()).fetch();
	}
}
