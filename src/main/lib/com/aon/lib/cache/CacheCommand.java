package com.aon.lib.cache;

import java.io.Serializable;

/**
 * cache 서버 간의 command 인터페이스
 */
public interface CacheCommand extends Serializable
{

	public void execute();
}
