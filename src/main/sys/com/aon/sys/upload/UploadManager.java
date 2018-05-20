package com.aon.sys.upload;

import org.springframework.stereotype.Service;

import com.aon.lib.jpa.TxListener;
import com.aon.lib.jpa.TxService;
import com.aon.lib.repo.RepositoryService;

@Service
public class UploadManager {

	
	public Upload update(Upload upload) throws Exception {
		if (upload == null || upload.getPath() == null)
			return null;

		handleXA(upload);
		return upload;
	}

	
	private void handleXA(Upload upload) throws Exception {
		storeXA(upload);
	}

	/**
	 * 첨부파일을 repository에 저장한다. rollback할 경우 다시 삭제된다.
	 * <p>
	 * 새로운 저장 정보가 pict에 설정된다.
	 */
	public void storeXA(Upload upload) throws Exception {
		storeXA(upload, RepositoryService.getDefaultRepositoryType());
	}

	public void storeXA(Upload image, final Integer type) throws Exception {
		final String path = RepositoryService.getRepository(type).store(image);
		image.setType(type);
		image.setPath(path);

		TxService.addTxListener(new TxListener() {
			public void commit() {
			}

			public void rollback() {
				try {
					RepositoryService.getRepository(type).delete(path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * 파일을 삭제한다.
	 */
	public void deleteXA(Upload upload) throws Exception {
		final Integer type = upload.getType();
		final String path = upload.getPath();

		if (type == null || path == null)
			return;

		TxService.addTxListener(new TxListener() {
			public void commit() {
				try {
					RepositoryService.getRepository(type).delete(path);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			public void rollback() {
			}
		});
	}

}