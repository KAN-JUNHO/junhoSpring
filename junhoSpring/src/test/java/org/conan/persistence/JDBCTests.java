package org.conan.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	@Test
	public void testConnection() {
		try(Connection conn = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:XE",
				"scott",
				"tiger")) {log.info(conn);} catch (Exception e) {
		}
	}
	@Setter(onMethod_ = {@Autowired})
	private SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void testMyBatis() {
		try(SqlSession session = sqlSessionFactory.openSession();
				Connection conn = session.getConnection();){
				log.info(session);log.info(conn);}
		catch (Exception e) {
			fail(e.getMessage());
		}
	}
	@Test
	public void testTimeMapper() {
		try(SqlSession session = sqlSessionFactory.openSession();
				Connection conn = session.getConnection();){
				log.info(session);log.info(conn);}
		catch (Exception e) {
			fail(e.getMessage());
		}
	}
}
