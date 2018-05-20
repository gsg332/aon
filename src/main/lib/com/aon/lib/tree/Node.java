package com.aon.lib.tree;


public interface Node
{
	/**
	 * 노드의 id를 돌려준다.
	 * 
	 * @return 노드의 id
	 */
    public Long getId();

	/**
	 * 상위 노드의 id를 돌려준다.
	 * 
	 * @return 상위 노드의 id
	 */
	public Long getParentId();

}
