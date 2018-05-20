package com.aon.doc;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.event.EventListener;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aon.lib.http.StartEvent;
import com.aon.lib.i18n.I18nService;
import com.aon.lib.jpa.EntityManagerService;
import com.aon.lib.repo.RepositoryFile;
import com.aon.lib.repo.RepositoryService;
import com.aon.lib.validator.ValidationException;
import com.fasterxml.jackson.databind.ObjectMapper;

public abstract class BaseController {

	/**
	 * 추가적인 initialize 작업이 필요한 경우 override한다.
	 */

	public void init() {

	}

	@EventListener
	public final void start(StartEvent e) throws Exception {
		init();
	}

	@ExceptionHandler(Exception.class)
	public @ResponseBody void handleError(HttpServletRequest req, HttpServletResponse res, Exception e)
			throws Exception {
		try {
			res.setContentType("application/json; charset=UTF-8");
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> result = new HashMap<String, Object>();
			PrintWriter out = res.getWriter();
			if (e.getClass().equals(ValidationException.class)) {
				res.setStatus(HttpStatus.BAD_REQUEST.value());
				List<ObjectError> errors = ((ValidationException) e).getBindingResult().getAllErrors();
				// 메시지처리 ....
				// 400error는 별도 처리한다. ->binding error 
				List<String> messages = new LinkedList<String>();
				for (ObjectError error : errors) {
					messages.add(
							I18nService.getMessage(error.getCode(), error.getArguments(), error.getDefaultMessage()));
				}
				result.put("messages", messages);
			} else {
				res.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
			result.put("exception", e.getClass().getName());
			result.put("exname", I18nService.getMessge(e.getClass().getSimpleName()));
			result.put("url", req.getRequestURL().append('?').append(req.getQueryString()));

			out.print(mapper.writeValueAsString(result));
			out.flush();
			out.close();
		} finally {
			// 여기까지 왔다면 오류가 발생한 상태이므로 트랜잭션을 롤백시킨다.
			EntityManagerService.setRollbackOnly();
		}
	}

	protected void checkBindingResult(BindingResult result) throws ValidationException {
		if (result.hasErrors()) {
			throw new ValidationException(result);
		}
	}

	private static final String DEFAULT_CONTENT_TYPE = "application/x-msdownload";
	private static final String HEADER = "Content-disposition";
	private static final String HEADER_INLINE = "inline;filename=";
	private static final String HEADER_ATTACH = "attachment;filename=";

	/**
	 * 첨부로 파일 다운로드
	 * 
	 * @param request
	 * @param response
	 * @param file
	 * @param inline
	 *            첨부 또는 inline으로 내려줄지 결정.
	 * @throws Exception
	 */
	protected void download(HttpServletRequest request, HttpServletResponse response, RepositoryFile file,
			boolean inline) throws Exception {
		try {
			String filename = RepositoryService.encodeFilename(file.getFilename());

			response.setHeader(HEADER, (inline ? HEADER_INLINE : HEADER_ATTACH) + "\"" + filename + "\"");
			String contentType = request.getSession().getServletContext().getMimeType(filename);
			response.setContentType((contentType == null) ? DEFAULT_CONTENT_TYPE : contentType);
			file.write(response.getOutputStream());
		} finally {
			response.getOutputStream().close();
		}
	}
}
