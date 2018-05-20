package com.aon.doc.category;

import java.util.List;


public interface ICategorizable<T extends BaseCategory> {
	public void setCategories(List<T> categories);

	public List<T> getCategories();
	
	default public void updateFolderLevel()
	{
		
		if (getCategories() != null)
		{
			for (BaseCategory c : getCategories())
			{
				c.updateLevel();
			}
		}
	}
}
