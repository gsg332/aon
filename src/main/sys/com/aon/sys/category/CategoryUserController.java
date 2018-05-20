package com.aon.sys.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.doc.Permission;
import com.aon.lib.event.EventPublisher;
import com.aon.lib.i18n.I18nService;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
@RequestMapping("/sys/category")
public class CategoryUserController extends BaseController{

	@Autowired
	private CategoryQuery query;
	
	@Autowired
	private CategoryService service;
	
	@Autowired
	private EventPublisher publisher;
	
	@Autowired
	private ICategoryRepository repository;
	
	private Permission permission;
	
	@Override
	public void init() {
		permission = new Permission();
	}
	
	/**
	 * 인자로 전달받은 rootId 하위의 전체 분류를 반환한다.
	 *
	 * @param rootId
	 * @param m
	 * @return Model
	 * @throws Exception
	 */
	@RequestMapping(value = "/listByrootId")
	@JsonView(BaseJsonView.Summary.class)
	public Model listByrootId(Long rootId, Model m) throws Exception {
		m.addAttribute("list", query.getAllListByRootId(rootId));
		return m;
	}
	
	/**
	 * 인자로 전달받은 부모id 하위 분류를 반환한다.
	 *
	 * @param pid
	 * @param m
	 * @return Model
	 * @throws Exception
	 */
	@RequestMapping(value = "/getListByParent")
	@JsonView(BaseJsonView.Summary.class)
	public Model getListByParent(String pid, Model m) throws Exception {
		String root = Category.getCategoryRoot().get(pid);
		pid = root != null ? root : pid; 
		m.addAttribute("list", query.getListByParent((long) Integer.parseInt(pid)));
		return m;
	}
	
	/**
	 * 전체 분류를 반환한다.
	 * 
	 * @param m
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	@JsonView(BaseJsonView.Summary.class)
	public Model getJsonList(Model m) throws Exception {
		List<Category> categoryList = query.getList();
		m.addAttribute("list", categoryList);
		return m;
	}
	
	/**
	 * 분류를 추가한다.
	 *
	 * @param client
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value = "/addNode")
	@JsonView(BaseJsonView.Summary.class)
	public Category addNode(HttpServletRequest request, Category client) throws Exception {
		if(client.getParentId() > 0){
			service.CategoryCache(client.getParentId());
		}
		Category server = service.loadOrCreate(client.getId());
		Category parent = repository.findOne(client.getParentId());
		permission.checkAdmin();
		if (parent == null)
		{
			client.setSort(0);
		}
		else
		{
			Category lastChild = CategoryCache.getLastChild(parent.getId());
			if (null == lastChild)
			{
				client.setSort(0);
			}
			else
			{
				client.setSort(lastChild.getSort() + 1);
			}
		}
		List<String> locales = I18nService.getLocales();
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < locales.size(); i++) {
			map.put(locales.get(i), request.getParameter(locales.get(i)));
		}
		ObjectMapper mapper = new ObjectMapper();
		client.setName(mapper.writeValueAsString(map));
		if(client.getParentId() > 0){
			service.register(server, client);
		}else{
			service.addAsRoot(server, client);
		}
		return server;
	}
	
	/**
	 * 수정을 위한 조회
	 * 
	 * @param client
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readForUpdate")
	@JsonView(BaseJsonView.Detail.class)
	public Model readForUpdate(Long id, Model m) throws Exception {
		Category server = repository.findOne(id);
		permission.checkAdmin();
		m.addAttribute("item", server);
		return m;
	}
	
	/**
	 * 분류를 수정한다.
	 *
	 * @param id
	 * @param client
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateNode", method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)
	public void update(HttpServletRequest request, Long id, Category client) throws Exception {
		service.CategoryCache(id);
		Category server = repository.loadWithLock(id);
		permission.checkAdmin();
		List<String> locales = I18nService.getLocales();
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < locales.size(); i++) {
			map.put(locales.get(i), request.getParameter(locales.get(i)));
		}
		ObjectMapper mapper = new ObjectMapper();
		client.setName(mapper.writeValueAsString(map));
		service.update(server, client);
	}
	
	/**
	 * 분류를 삭제한다.
	 *
	 * @param id
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteNode")
	@JsonView(BaseJsonView.Summary.class)
	public void deleteNode(Long id, Long parentId) throws Exception {
		service.CategoryCache(id, parentId);
		Category server = repository.findOne(id);
		permission.checkAdmin();
		service.remove(server);
	}
	
	/**
	 * 형제 node의 위아래 위치를 변경한다.
	 *
	 * @param upId
	 * @param downId
	 * @throws Exception
	 */
	@RequestMapping(value = "/swapNode")
	@JsonView(BaseJsonView.Summary.class)
	public void swapNode(Long upId, Long upParentId, int upSort, Long downId, Long downParentId, int downSort) throws Exception {
		service.CategoryCache(upId, upParentId);
		service.CategoryCache(upId, upSort);
		service.CategoryCache(downId, downParentId);
		service.CategoryCache(downId, downSort);
		Category moveDown = repository.findOne(downId);
		Category moveUp = repository.findOne(upId);
		permission.checkAdmin();
		service.swapCategory(moveUp, moveDown);
	}
	
	/**
	 * 선택한 분류를 타분류 하위로 이동한다.
	 *
	 * @param id
	 * @param targetId
	 * @throws Exception
	 */
	@RequestMapping(value = "/moveNode")
	@JsonView(BaseJsonView.Summary.class)
	public void moveNode(Long id, Long parentId, Long targetId, Long targetParentId) throws Exception {
		service.CategoryCache(id, parentId);
		service.CategoryCache(targetId, targetParentId);
		Category child = repository.findOne(id);
		Category srcParent = repository.findOne(child.getParentId());
		Category dstParent = repository.findOne(targetId);
		permission.checkAdmin();
		service.moveCategory(child, srcParent, dstParent);
	}
	
	/**
	 * 선택한 분류를 최상위로 이동한다.
	 * 
	 * @param id
	 * @throws Exception
	 */
	@RequestMapping(value = "/topNode")
	@JsonView(BaseJsonView.Summary.class)
	public void topNode(Long id, Long parentId) throws Exception {
		service.CategoryCache(id, parentId);
		Category server = repository.findOne(id);
		permission.checkAdmin();
		service.topCategory(server);
	}
	
	/**
	 * 선택한 분류를 최하위로 이동한다.
	 * 
	 * @param id
	 * @throws Exception
	 */
	@RequestMapping(value = "/bottomNode")
	@JsonView(BaseJsonView.Summary.class)
	public void bottomNode(Long id, Long parentId) throws Exception {
		service.CategoryCache(id, parentId);
		Category server = repository.findOne(id);
		permission.checkAdmin();
		service.bottomCategory(server);
	}
}
