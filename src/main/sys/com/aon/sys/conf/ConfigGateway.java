package com.aon.sys.conf;

import java.sql.SQLException;
import java.util.List;

import javax.persistence.Query;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.aon.lib.jpa.EntityManagerService;

class ConfigGateway
{
	private static final String INSERT = "INSERT INTO sa_config (code, value) VALUES (?, ?)";
	private static final String DELETE = "DELETE FROM sa_config WHERE code LIKE ?";

	private Query _ins;
	private Query _del;

	ConfigGateway() throws Exception
	{
		_ins = EntityManagerService.getEntityManager().createNativeQuery(INSERT);
		_del = EntityManagerService.getEntityManager().createNativeQuery(DELETE);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	void update(List<Config> l) throws Exception
	{
		for (Config c : l)
		{
			String key = c.getKey();
			String value = c.getValue();
			delete(key);
			delete(key + "[%]");
			if (value.length() <= 1000)
			{
				insert(key, value);
			}
			else
			{
				decompose(key, value);
			}
			//bService.commit();
			//EntityManagerService.getEntityManager().getTransaction().commit();
		}
	}

	private void insert(String key, String value) throws SQLException
	{
		_ins.setParameter(1, key);
		_ins.setParameter(2, value);
		_ins.executeUpdate();
	}

	private void decompose(String key, String value) throws SQLException
	{
		int l = value.length();
		insert(key + "[]", Integer.toString((int) Math.ceil(l / 1000.0)));
		for (int i = 0; i < l; i += 1000)
		{
			int end = (i + 1000 < l) ? (i + 1000) : l;
			insert(key + '[' + (i / 1000) + ']', value.substring(i, end));
		}
	}

	private void delete(String key) throws SQLException
	{
		_del.setParameter(1, key);
		_del.executeUpdate();
	}

}