package com.aon.junit;

import com.aon.lib.cache.CacheCommand;
import com.hazelcast.config.Config;
import com.hazelcast.config.JoinConfig;
import com.hazelcast.config.NetworkConfig;
import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.core.ITopic;
import com.hazelcast.core.MessageListener;

public class Test2 {

	public static void main(String args[]) throws InterruptedException {
		Config config = new Config();
		config.setInstanceName("whatinfo");
		config.getGroupConfig().setName("whatinfouser").setPassword("rhdqnwhagofk");
		NetworkConfig network = config.getNetworkConfig();
		JoinConfig join = network.getJoin();
		join.getMulticastConfig().setEnabled(true);

		HazelcastInstance hz = Hazelcast.newHazelcastInstance(config);
		ITopic<CacheCommand> topic = hz.getTopic("default");
		topic.addMessageListener(new MessageListener<CacheCommand>() {

			@Override
			public void onMessage(com.hazelcast.core.Message<CacheCommand> message) {
				((CacheCommand) message.getMessageObject()).execute();
			}
		});

		topic.publish(new CacheCommand() {
			@Override
			public void execute() {
				System.out.println("잘해라..");

			}
		});
		topic.publish(new CacheCommand() {
			@Override
			public void execute() {
				System.out.println("공부도 하고 .....");

			}
		});
		topic.publish(new CacheCommand() {
			@Override
			public void execute() {
				System.out.println("술 끊고 .....");

			}
		});

		topic.publish(new CacheCommand() {
			@Override
			public void execute() {
				System.out.println("밥먹으로 갑시다.  -,.-");

			}
		});
		topic.publish(new CacheCommand() {
			@Override
			public void execute() {
				System.out.println(".....................................................");

			}
		});
		topic.publish(new CacheCommand() {
			@Override
			public void execute() {
				System.out.println("....................................................");

			}
		});

	}
}
