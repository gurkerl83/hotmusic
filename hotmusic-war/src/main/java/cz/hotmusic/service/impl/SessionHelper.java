package cz.hotmusic.service.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cz.hotmusic.model.User;

@Repository
public class SessionHelper {
	public SessionHelper() {
	}

	Logger logger = LoggerFactory.getLogger(getClass());
	private SessionFactory sessionFactory;
//	private static SessionHelper instance;

//	public static SessionHelper getInstance() {
//		if (instance == null) {
//			instance = new SessionHelper();
//		}
//		return instance;
//	}

	@Transactional
	public Boolean checkSession(String userSession) throws Throwable {
//		Session session = sessionFactory.openSession();
//		Transaction transaction = session.beginTransaction();
//		transaction.begin();
		Assert.assertNotNull(userSession);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User where session = :session");
		query.setParameter("session", userSession);
		
		List<User> list = query.list();
		if (list != null && list.size() > 0)
			return true;
		
		throw new Exception("Error: user session is not valid or expired");
//		return false;
	}

	// ---------------------------------------------------
	//
	// GETTERS and SETTERS
	//
	// ---------------------------------------------------

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
}
