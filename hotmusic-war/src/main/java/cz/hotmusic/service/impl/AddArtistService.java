package cz.hotmusic.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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

import cz.hotmusic.model.AddArtist;
import cz.hotmusic.model.Artist;
import cz.hotmusic.model.Song;
import cz.hotmusic.service.IAddArtistService;
import cz.hotmusic.service.IArtistService;

@Repository
@RemotingDestination
public class AddArtistService implements IAddArtistService{
	
	Logger logger = LoggerFactory.getLogger(getClass());
	private SessionFactory sessionFactory;
	private SessionHelper sessionHelper;
	private final int count = 10; // velikost stranky
	
	//------------------------------------------------------
	//
	// PUBLIC METHODS
	//
	//------------------------------------------------------

	@Override
	@RemotingInclude
	@Transactional
	public String create(String sid, AddArtist addArtist) throws Throwable {
		// check inputs
		Assert.assertNotNull(addArtist);
		Assert.assertNotNull(addArtist.name);
		sessionHelper.checkSession(sid);
		
		addArtist.addedBySession = sid;
		addArtist.addedDate = new Date();
		addArtist.state = AddArtist.WAITING_STATE;
		Session session = sessionFactory.getCurrentSession();
		session.save(addArtist);
		
		return addArtist.id;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public void changeState(String sid, AddArtist addArtist) throws Throwable {
		// check inputs
		Assert.assertNotNull(addArtist);
		Assert.assertNotNull(addArtist.state);
		Assert.assertNotNull(addArtist.id);
		if (!addArtist.state.equals(AddArtist.ADDED_STATE) && !addArtist.state.equals(AddArtist.REJECTED_STATE))
			throw new Exception("unknown state");
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		AddArtist foundAddArtist = (AddArtist) session.load(AddArtist.class, addArtist.id);
		foundAddArtist.state = addArtist.state;
		session.update(foundAddArtist);
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<AddArtist> list(String sid, int page) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from AddArtist");
		
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<AddArtist> list = query.list();
		
		return list;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<AddArtist> list(String sid) throws Throwable {
		return list(sid, 0);
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<AddArtist> list(String sid, int page, String search, String sort) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		if (sort != null && sort.equals("Z-A"))
			sort = " order by name desc";
		else if (sort != null && sort.equals("Newest"))
			sort = " order by addedDate";
		else if (sort != null && sort.equals("Oldesd"))
			sort = " order by addedDate desc";
		else 
			sort = " order by name";
		
		if (search == null || search.equals(""))
			query = session.createQuery("from AddArtist " + sort);
		else
			query = session.createQuery("from AddArtist where name like :search" + sort).setParameter("search", "%" + search + "%");
			
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<AddArtist> list = query.list();
		
		return list;
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<AddArtist> autocomplete(String sid, String text) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(text);
		
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from AddArtist where name like :name");
		query.setParameter("name", text + "%");
		
		query.setMaxResults(7);

		@SuppressWarnings("unchecked")
		List<AddArtist> list = query.list();
		
		return list;
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Integer> listCount(String sid) throws Throwable {
		List<Integer> returnList = new ArrayList<Integer>(); 
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		
		int count = ((Long)session.createQuery("select count(*) from AddArtist").uniqueResult()).intValue();
		returnList.add(count);
		count = ((Long)session.createQuery("select count(*) from AddArtist where state = :waiting").setParameter("waiting", AddArtist.WAITING_STATE).uniqueResult()).intValue();
		returnList.add(count);
		count = ((Long)session.createQuery("select count(*) from AddArtist where state = :added").setParameter("added", AddArtist.ADDED_STATE).uniqueResult()).intValue();
		returnList.add(count);
		count = ((Long)session.createQuery("select count(*) from AddArtist where state = :rejected").setParameter("rejected", AddArtist.REJECTED_STATE).uniqueResult()).intValue();
		returnList.add(count);
		
		return returnList;
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
		int count = ((Long)session.createQuery("select count(*) from AddArtist where addedDate > :monthbefore").setParameter("monthbefore", monthBefore).uniqueResult()).intValue();;
		return count;
	}

	@Override
	@RemotingInclude
	@Transactional
	public void remove(String sid, AddArtist addArtist) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(addArtist);
		Assert.assertNotNull(addArtist.id);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("delete from AddArtist where id = :id");
		query.setParameter("id", addArtist.id);
		query.executeUpdate();
	}

	@Override
	@RemotingInclude
	@Transactional
	public void update(String sid, AddArtist addArtist) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(addArtist);
		Assert.assertNotNull(addArtist.id);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from AddArtist where id = :id");
		query.setParameter("id", addArtist.id);
		
		@SuppressWarnings("unchecked")
		List<AddArtist> list = (List<AddArtist>)query.list();
		if (list.size() != 1)
			throw new Exception("Can't find the addartist");
		AddArtist foundAddArtist = list.get(0);
		foundAddArtist.name = addArtist.name;
		
//		session.close();

		session = sessionFactory.openSession();
		Transaction tr = session.beginTransaction();
		tr.begin();
		session.update(foundAddArtist);
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
