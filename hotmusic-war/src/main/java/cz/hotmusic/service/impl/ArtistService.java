package cz.hotmusic.service.impl;

import java.util.Date;
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

import cz.hotmusic.model.Artist;
import cz.hotmusic.service.IArtistService;

@Repository
@RemotingDestination
public class ArtistService implements IArtistService{
	
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
	public String create(String sid, Artist artist) throws Throwable {
		// check inputs
		Assert.assertNotNull(artist);
		Assert.assertNotNull(artist.name);
		sessionHelper.checkSession(sid);
		
		artist.addedBySession = sid;
		artist.addedDate = new Date();
		Session session = sessionFactory.getCurrentSession();
		session.save(artist);
		
		return artist.id;
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Artist> list(String sid, int page, int count) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from Artist");
		
		if (count == 0 ) count = 10;
		
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<Artist> list = query.list();
		
		return list;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<Artist> list(String sid) throws Throwable {
		return list(sid, 0, 10);
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Artist> autocomplete(String sid, String text) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(text);
		
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from Artist where name like :name");
		query.setParameter("name", text + "%");
		
		query.setMaxResults(7);

		@SuppressWarnings("unchecked")
		List<Artist> list = query.list();
		
		return list;
	}

	@Override
	@RemotingInclude
	@Transactional
	public int listCount(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		int count = ((Long)session.createQuery("select count(*) from Artist").uniqueResult()).intValue();;
		return count;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public int listLastMonth(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		Date now = new Date();
		Long nowMs = now.getTime();
		Long monthMs = 1000L*60L*60L*24L*30L;
		Date monthBefore = new Date(nowMs - monthMs);
		int count = ((Long)session.createQuery("select count(*) from Artist where addedDate > :monthbefore").setParameter("monthbefore", monthBefore).uniqueResult()).intValue();;
		return count;
	}

	@Override
	@RemotingInclude
	@Transactional
	public void remove(String sid, Artist artist) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(artist);
		Assert.assertNotNull(artist.id);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("delete from Artist where id = :id");
		query.setParameter("id", artist.id);
		query.executeUpdate();
	}

	@Override
	@RemotingInclude
	@Transactional
	public void update(String sid, Artist artist) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(artist);
		Assert.assertNotNull(artist.id);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Artist where id = :id");
		query.setParameter("id", artist.id);
		
		@SuppressWarnings("unchecked")
		List<Artist> list = (List<Artist>)query.list();
		if (list.size() != 1)
			throw new Exception("Can't find the artist");
		Artist foundArtist = list.get(0);
		foundArtist.name = artist.name;
		
//		session.close();

		session = sessionFactory.openSession();
		Transaction tr = session.beginTransaction();
		tr.begin();
		session.update(foundArtist);
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
