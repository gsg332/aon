package com.aon.sys.category;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.aon.lib.event.EventPublisher;
import com.aon.lib.tree.Node;

@Service
public class CategoryService {
   
	@Autowired
	private  CategoryQuery query;
	
	@Autowired
	private EventPublisher publisher;
	
	@Autowired
	private ICategoryRepository repository;
	
	public  List<Node> list() throws Exception {
		return query.getAllList();
	}
	
	public Category loadOrCreate(Long id) {
		if (id == null) {
			return repository.create(new Category());
		}
		return repository.loadWithLock(id);
	}

	/**
	 * 분류를 추가한다. 
	 *
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void register(Category server, Category client) throws Exception {
		Category parent = repository.findOne(client.getParentId());
		parent.setFlagCode(Category.LEAF_FLAG, false);
		parent.setUpdateDate(new Date());
		
		server.setName(client.getName());
		server.setClassName(client.getClassName());
		server.setFlagCode(Category.LEAF_FLAG, true);
		server.setParentId(client.getParentId());
		server.setRootId(parent.getRootId() == null ? parent.getId() : parent.getRootId());
		server.setSort(client.getSort());
		server.setUpdateDate(new Date());
		publisher.broadcast(new CategoryEvent.Create(server));
		CategoryRemote.added(server, parent);
	}
	
	/**
	 * 추가할 부모 Node가 미존재 시, root로 등록한다.
	 *
	 * @param server
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void addAsRoot(Category server, Category client) throws Exception {
		server.setName(client.getName());
		server.setFlagCode(Category.LEAF_FLAG, true);
		server.setParentId(client.getParentId());
		server.setRootId(server.getId());
		server.setSort(Integer.parseInt(server.getId().toString()));
		server.setUpdateDate(new Date());
		publisher.broadcast(new CategoryEvent.Create(server));
		CategoryRemote.addedRoot(server);
	}
	
	/**
	 * 분류를 수정한다.
	 *
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void update(Category server, Category client) throws Exception {
		server.setName(client.getName());
		server.setClassName(client.getClassName());
		server.setUpdateDate(new Date());
		publisher.broadcast(new CategoryEvent.Update(server));
		CategoryRemote.updated(server);
	}

	/**
	 * 분류를 삭제한다. <br> DB의 row를 제거한다.
	 *
	 * @param server
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void remove(Category server) throws Exception {
		Category parent = repository.findOne(server.getParentId());
		if(parent == null){
			repository.delete(server);
			publisher.broadcast(new CategoryEvent.Delete(server));
			CategoryRemote.removedRoot(server);
			CategoryCache.refresh();
		}else{
			int childCount = CategoryCache.getChildrenCount(server.getParentId());
			if (childCount == 1) {
				parent.setFlagCode(Category.LEAF_FLAG, true);
				parent.setUpdateDate(new Date());
			}
			repository.delete(server);
			publisher.broadcast(new CategoryEvent.Delete(server));
			CategoryRemote.removed(server, parent);
		}
	}
	
	/**
	 * 형제 node의 위아래 위치를 변경한다.
	 *
	 * @param moveUp
	 * @param moveDown
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void swapCategory(Category moveUp, Category moveDown) throws Exception {
		int temp = moveDown.getSort();
		moveDown.setSort(moveUp.getSort());
		moveDown.setUpdateDate(new Date());
		moveUp.setSort(temp);
		moveUp.setUpdateDate(new Date());
		CategoryRemote.swapped(moveUp, moveDown);
	}
	
	/**
	 * 선택한 분류를 타분류 하위로 이동한다.
	 *
	 * @param child
	 * @param srcParent
	 * @param dstParent
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void moveCategory(Category child, Category srcParent, Category dstParent) throws Exception {
		removeChild(srcParent, child);
		addChild(dstParent, child);
		// 리스너 구현
		publisher.broadcast(new CategoryEvent.Move(child));
		CategoryRemote.moved(child, srcParent, dstParent);
	}
	
	/**
	 * 분류를 이동 후, 부모 Node와 자식 Node의 정보를 변경한다.
	 *
	 * @param parent
	 * @param child
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void removeChild(Category parent, Category child) throws Exception {
		int count = CategoryCache.getChildrenCount(parent.getId());
		parent.setFlagCode(Category.LEAF_FLAG, (count == 1));
		parent.setUpdateDate(new Date());
		count = CategoryCache.getChildrenCount(child.getId());
		child.setFlagCode(Category.LEAF_FLAG, (count == 0));
		child.setUpdateDate(new Date());
	}
	
	/**
	 * 분류를 이동 후, 부모 Node와 자식 Node의 정보를 변경한다.
	 *
	 * @param parent
	 * @param child
	 * @return 
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void addChild(Category parent, Category child) throws Exception {
		parent.setFlagCode(Category.LEAF_FLAG, false);
		parent.setUpdateDate(new Date());
		Category lastChild = CategoryCache.getLastChild(parent.getId());
		if (null == lastChild)
		{
			child.setSort(0);
		}
		else
		{	
			if(parent.getId().equals(child.getParentId())){
				child.setSort(CategoryCache.getChildrenCount(parent.getId()) - 1);
			}else{
				child.setSort(lastChild.getSort() + 1);
			}
		}
		child.setParentId(parent.getId());
		child.setRootId(parent.getRootId());
		child.setUpdateDate(new Date());
	}
	
	/**
	 * 선택한 분류를 분류 최상위로 이동한다.
	 * 
	 * @param server
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void topCategory(Category server) throws Exception {
		Category fisrtChild = CategoryCache.getFisrtChild(server.getParentId());
		server.setSort(fisrtChild.getSort() - 1);
		server.setUpdateDate(new Date());
		CategoryRemote.updated(server);
		CategoryCache.refresh();
	}
	
	/**
	 * 선택한 분류를 분류 최하위로 이동한다.
	 * 
	 * @param server
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void bottomCategory(Category server) throws Exception {
		Category lastChild = CategoryCache.getLastChild(server.getParentId());
		server.setSort(lastChild.getSort() + 1);
		server.setUpdateDate(new Date());
		CategoryRemote.updated(server);
		CategoryCache.refresh();
	}
	
	/**
	 * 입력할 데이터와 캐시된 데이터의 부모값이 같은지 확인
	 * 
	 * @param id
	 * @param parentId
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void CategoryCache(Long id, Long parentId) throws Exception {
		Category cache = CategoryCache.getCategory(id);
		if(!cache.getParentId().equals(parentId)){
			throw new Exception();
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void CategoryCache(Long parentId) throws Exception {
		Category cache = CategoryCache.getCategory(parentId);
		if(cache == null){
			throw new Exception();
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void CategoryCache(Long id, int sort) throws Exception {
		Category cache = CategoryCache.getCategory(id);
		if(cache.getSort() != sort){
			throw new Exception();
		}
	}
}
