package com.aon.lib.tree;

/**
 * 다수의 Node를 순회하는 visitor를 위한 interface이다.
 */
public interface NodeVisitor
{
	public void visit(Node node);
	
}
