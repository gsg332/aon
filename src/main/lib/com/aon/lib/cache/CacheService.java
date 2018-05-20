package com.aon.lib.cache;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.PreDestroy;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aon.lib.app.AppSpring;
import com.aon.sys.lock.LockService;
import com.hazelcast.config.Config;
import com.hazelcast.config.JoinConfig;
import com.hazelcast.config.NetworkConfig;
import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.core.ITopic;
import com.hazelcast.core.Message;
import com.hazelcast.core.MessageListener;


public class CacheService {

	private static final Logger logger = LoggerFactory.getLogger(CacheService.class);
	
	private static List<ICacheListener> listeners = new LinkedList<ICacheListener>();

	private static Map<Class<?>, Object> cache = new HashMap<Class<?>, Object>();
	private static HazelcastInstance hz = null;
	private static ITopic<CacheCommand> topic = null;
	private static boolean isClustered = false;
	private static int PORT_NUMBER = 54327;
	private static String MULTICAST_ADDRESS = "224.2.2.3";
	
	public static void init() throws Exception {
		CacheService.isClustered = CacheSpring.isClustered();
		
		if(isClustered){
			try{
				LockService.lock("start cluster...");
				if (hz != null)
					destory();
				
				Config config = new Config();
				logger.debug("application name = " + AppSpring.getApplicationName());
				logger.debug("cache user= {} pwd= {}",CacheSpring.getUser(),CacheSpring.getPassword());
				config.setInstanceName(AppSpring.getApplicationName());
				//config.setProperty("hazelcast.logging.type", "slf4j");
				config.getGroupConfig().setName(CacheSpring.getUser()).setPassword(CacheSpring.getPassword());
		
				NetworkConfig network = config.getNetworkConfig();
				JoinConfig join = network.getJoin();
				//join.getTcpIpConfig().setEnabled(false);
				//join.getAwsConfig().setEnabled(false);
				join.getMulticastConfig().setEnabled(true);
		
				//join.getMulticastConfig().setMulticastGroup(MULTICAST_ADDRESS);
		        //join.getMulticastConfig().setMulticastPort(PORT_NUMBER);
		        ///join.getMulticastConfig().setMulticastTimeoutSeconds(200);
				
				hz = Hazelcast.newHazelcastInstance(config);
				topic = hz.getTopic("default");
				topic.addMessageListener(new MessageListener<CacheCommand>() {
		
					@Override
					public void onMessage(Message<CacheCommand> message) {
						((CacheCommand) message.getMessageObject()).execute();
					}
				});
			}finally{
				LockService.unlock();
			}

		}

	}

	public static void put(Class<?> clazz, Object object) {
		cache.put(clazz, object);
	}
	
	public static Object get(Class<?> clazz) {
		return cache.get(clazz);
	}
	
	/**
	 * cache listener를 등록한다.
	 * <p>
	 * clustering이 되어 있지 않아도 변경사항을 통보받는다.
	 */
	public static synchronized void addListener(ICacheListener listener)
	{
		listeners.add(listener);
	}

	public static void send(CacheCommand cmd) throws Exception {
		// TODO:동기화 서버에 cmd를 발송하고
		// cmd를 실행한다.
		if (topic != null)
			topic.publish(cmd);
		else
			cmd.execute();
	}

	@PreDestroy
	public static void destory() {
		logger.debug("Cluster destory.............................. ---,.---");
		if (hz != null) {
			topic.destroy();
			hz.shutdown();
			topic = null;
			hz = null;
		}
	}

}
