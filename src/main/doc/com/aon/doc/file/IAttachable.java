package com.aon.doc.file;

import java.util.List;


public interface IAttachable<T extends BaseAttachment> {

	public void setAttachments(List<T> attachments);

	public List<T> getAttachments();

	public void setFileExt(String ext);
	
	public String getFileExt();
	
	public default void updateAttachments(List<T> list) {
		 setFileExt(null);
		if (list != null) {
			// 파일 목록 중에서 첫번째 파일의 확장자를 설정한다.
			for (BaseAttachment att : list) {
				if (att.getType() != null && att.getType().intValue() != 7000 && att.getFilename() != null
						&& att.getFilename().indexOf("CONTENTIMAGEHIDDEN") != 0) {
					 setFileExt(att.getExtension());
					break;
				}
			}
		}
		setAttachments(list);
	}
}
