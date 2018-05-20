package com.aon.sys.category;

import java.util.Date;
import java.util.Map;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.aon.lib.tree.Node;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Category extends BaseObject implements Node{

	private static final long serialVersionUID = 460082874485978059L;
	
	public static final int LEAF_FLAG = 0x0001; 
	
	@JsonView(BaseJsonView.Summary.class)
	private Long parentId;
	
	@JsonView(BaseJsonView.Summary.class)
	private Long rootId;
	
	@JsonView(BaseJsonView.Summary.class)
	private int sort;
	
	@JsonView(BaseJsonView.Summary.class)
	private String name;
	
	@JsonView(BaseJsonView.Detail.class)
	private Date updateDate;
	
	@JsonView(BaseJsonView.Summary.class)
	private int flagCode;
	
	@JsonView(BaseJsonView.Summary.class)
	private String className;
	
	public Long getParentId() {
		return parentId;
	}
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	public Long getRootId() {
		return rootId;
	}
	public void setRootId(Long rootId) {
		this.rootId = rootId;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getName(){
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate){
		this.updateDate = updateDate;
	}
	public int getFlagCode() {
		return flagCode;
	}
	public void setFlagCode(int flagCode) {
		this.flagCode = flagCode;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public void setFlagCode(int code, boolean set)
	{
		if (set)
		{
			flagCode |= code;
		}
		else
		{
			flagCode &= ~code;
		}
	}
	
	public static Map<String, String> categoryRoot;

	public static Map<String, String> getCategoryRoot() {
		return categoryRoot;
	}
	public void setCategoryRoot(Map<String, String> categoryRoot) {
		this.categoryRoot = categoryRoot;
	}

}
