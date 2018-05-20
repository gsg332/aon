package com.aon.doc;

import com.aon.sys.usr.UserPermission;

public class Permission extends UserPermission{

	/**
	 * 조회가능여부
	 * 
	 * @throws Exception
	 */
	public void read(BaseDoc doc) throws Exception{
		int status = doc.getStatus();
		if (status != BaseDoc.REGISTERED_STATUS )
		{
			throw new InvalidStatusException();
		}
	}

	/**
	 * 작성자 본인이 맞는지
	 * 
	 * @param server
	 * @throws com.aon.doc.PermissionDeniedException 
	 */
	public void checkOwner(BaseDoc doc) throws Exception{

		if (!isOwner(doc)) {
			throw new PermissionDeniedException();
		}
	}

	public static boolean isOwner(BaseDoc doc) throws Exception{
		if (doc.isCurrentRgstUser()) {
			return true;
		}
		
		return false;
	}

}
