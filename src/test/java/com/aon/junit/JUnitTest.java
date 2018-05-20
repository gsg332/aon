package com.aon.junit;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import junit.framework.TestCase;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		 ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public abstract class JUnitTest extends TestCase{

}
