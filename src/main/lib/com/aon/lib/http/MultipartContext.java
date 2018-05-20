package com.aon.lib.http;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;


/**
 * HTTP File Upload를 처리한다.
 * <p>
 * <ul>
 * <li>같은 이름의 GET 변수와 POST 변수가 존재하는 경우, 둘은 합쳐지며 GET 방식이 우선된다.
 * <li>input type="file"에서 실제 file이 없는 경우에는 무시한다.
 * </ul>
 */
class MultipartContext {
	private static ThreadLocal<Object> _requests = new ThreadLocal<Object>() {
		protected Object initialValue() {
			return new MultipartContext();
		}
	};

	/**
	 * 현재 thread의 MultipartRequest 객체를 돌려준다.
	 */
	static MultipartContext getMultipartContext() {
		return (MultipartContext) _requests.get();
	}

	private MultipartServletRequest _request;


	/**
	 * multipart request를 parsing하여 request parameter를 돌려준다. 첨부파일은
	 * MultipartRepository에 저장한다.
	 */
	public void activate(MultipartServletRequest request, HttpServletResponse response) throws Exception {
		_request = request;
		
	}

	/**
	 * Request를 종료한다.
	 * <p>
	 * upload된 임시파일을 삭제한다.
	 */
	public void passivate() {
		try {
			deleteFiles();
		} finally {
			_request = null;
			}
	}

	/**
	 * FileItem의 List를 돌려준다.
	 */
	List<MultipartFile> getFiles(String key) {
		return (List<MultipartFile>) _request.getFiles(key);
	}

	/**
	 * FileItem을 돌려준다.
	 */
	MultipartFile getFile(String key) {
		return (MultipartFile) getFiles(key).get(0);
	}

	
	private void deleteFiles() {
		for (MultipartFile value : _request.getFileMap().values()) {
				CommonsMultipartFile file = (CommonsMultipartFile) value;
				file.getFileItem().delete();
		}
	}
}
