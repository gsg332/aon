package com.aon.module.doc;

import java.util.List;

import com.aon.doc.BaseDoc;
import com.aon.doc.BaseJsonView;
import com.aon.doc.category.BaseCategory;
import com.aon.doc.category.ICategorizable;
import com.aon.doc.file.BaseAttachment;
import com.aon.doc.file.IAttachable;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class DocItem extends BaseDoc implements IAttachable<DocItem.Attachment>,ICategorizable<DocItem.Category> {

	private static final long serialVersionUID = 5537868369345430410L;
	
	@JsonView(BaseJsonView.Detail.class)
	private List<Attachment> attachments;
	
	
	@JsonView(BaseJsonView.Detail.class)
	private List<Category>   categories;
	
	@JsonView(BaseJsonView.Summary.class)
	private String fileExt;
	
	@Override
	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	@Override
	public List<Attachment> getAttachments() {
		return this.attachments;
	}
	
	@Override
	public void setFileExt(String ext) {
		fileExt = ext;
	}

	@Override
	public String getFileExt() {
		return fileExt;
	}
	
	@Override
	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	@Override
	public List<Category> getCategories() {
		return categories;
	}
	
	@QueryEntity
	public static class Attachment extends BaseAttachment
	{

		private static final long serialVersionUID = 6241106030746596266L;
		
	}
	
	public static class Category extends BaseCategory{

		private static final long serialVersionUID = 6420285434632855283L;
		
	}

	
}
