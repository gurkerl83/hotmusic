package cz.hotmusic.service.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cz.hotmusic.model.Genre;
import cz.hotmusic.service.IGenreService;

@Repository
@RemotingDestination
public class GenreService implements IGenreService{
	
	Logger logger = LoggerFactory.getLogger(getClass());
	private SessionFactory sessionFactory;
	private SessionHelper sessionHelper;
	
	//------------------------------------------------------
	//
	// PUBLIC METHODS
	//
	//------------------------------------------------------

	@Override
	@RemotingInclude
	@Transactional
	public String create(String sid, Genre genre) throws Throwable {
		// check inputs
		Assert.assertNotNull(genre);
		Assert.assertNotNull(genre.name);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		session.save(genre);
		
		return genre.id;
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Genre> list(String sid, int page, int count) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from Genre");
		
		if (count == 0 ) count = 10;
		
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<Genre> list = query.list();
		
		return list;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<Genre> list(String sid) throws Throwable {
		return list(sid, 0, 10);
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Genre> autocomplete(String sid, String text) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(text);
		
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from Genre where name like :name");
		query.setParameter("name", text + "%");
		
		query.setMaxResults(7);

		@SuppressWarnings("unchecked")
		List<Genre> list = query.list();
		
		return list;
	}

	@Override
	@RemotingInclude
	@Transactional
	public int listCount(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		int count = ((Long)session.createQuery("select count(*) from Genre").uniqueResult()).intValue();;
		return count;
	}

	@Override
	@RemotingInclude
	@Transactional
	public void delete(String sid, Genre genre) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(genre);
		Assert.assertNotNull(genre.id);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("delete from Genre where id = :id");
		query.setParameter("id", genre.id);
		query.executeUpdate();
	}

	@Override
	@RemotingInclude
	@Transactional
	public void update(String sid, Genre genre) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(genre);
		Assert.assertNotNull(genre.id);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Genre where id = :id");
		query.setParameter("id", genre.id);
		
		@SuppressWarnings("unchecked")
		List<Genre> list = (List<Genre>)query.list();
		if (list.size() != 1)
			throw new Exception("Can't find the Genre");
		Genre foundGenre = list.get(0);
		foundGenre.name = genre.name;
		
//		session.close();

		session = sessionFactory.openSession();
		Transaction tr = session.beginTransaction();
		tr.begin();
		session.update(foundGenre);
		tr.commit();
//		session.close();
	}
	
	//---------------------------------------------------
	//
	// GETTERS and SETTERS
	//
	//---------------------------------------------------

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public SessionHelper getSessionHelper() {
		return sessionHelper;
	}

	@Autowired
	public void setSessionHelper(SessionHelper sessionHelper) {
		this.sessionHelper = sessionHelper;
	}

}
