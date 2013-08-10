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

import cz.hotmusic.model.Album;
import cz.hotmusic.model.Artist;
import cz.hotmusic.model.Genre;
import cz.hotmusic.service.IAlbumService;

@Repository
@RemotingDestination
public class AlbumService implements IAlbumService{
	
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
	public String create(String sid, Album album) throws Throwable {
		// check inputs
		Assert.assertNotNull(album);
		Assert.assertNotNull(album.name);
		Assert.assertNotNull(album.artist);
		Assert.assertNotNull(album.genre);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		session.save(album);
		
		return album.id;
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Album> list(String sid, int page, int count) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from Album");
		
		if (count == 0 ) count = 10;
		
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<Album> list = query.list();
		
		return list;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<Album> list(String sid) throws Throwable {
		return list(sid, 0, 10);
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Album> autocomplete(String sid, String text) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(text);
		
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from Album where name like :name");
		query.setParameter("name", text + "%");
		
		query.setMaxResults(7);

		@SuppressWarnings("unchecked")
		List<Album> list = query.list();
		
		return list;
	}

	@Override
	@RemotingInclude
	@Transactional
	public int listCount(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		int count = ((Long)session.createQuery("select count(*) from Album").uniqueResult()).intValue();;
		return count;
	}

	@Override
	@RemotingInclude
	@Transactional
	public void delete(String sid, Album album) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(album);
		Assert.assertNotNull(album.id);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("delete from Album where id = :id");
		query.setParameter("id", album.id);
		query.executeUpdate();
	}

	@Override
	@RemotingInclude
	@Transactional
	public void update(String sid, Album album) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(album);
		Assert.assertNotNull(album.id);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Album where id = :id");
		query.setParameter("id", album.id);
		
		@SuppressWarnings("unchecked")
		List<Album> list = (List<Album>)query.list();
		if (list.size() != 1)
			throw new Exception("Can't find the Album");
		Album foundAlbum = list.get(0);
		
		if (album.name != null)
			foundAlbum.name = album.name;
		if (album.artist != null) 
			foundAlbum.artist = (Artist) session.load(Artist.class, album.artist.id);
		if (album.genre != null)
			foundAlbum.genre = (Genre) session.load(Genre.class, album.genre.id);
		if (album.releaseDate != null)
			foundAlbum.releaseDate = album.releaseDate;
		if (album.itunes != null)
			foundAlbum.itunes = album.itunes;
		if (album.googlePlay != null)
			foundAlbum.googlePlay = album.googlePlay;
		if (album.amazon != null)
			foundAlbum.amazon = album.amazon;
		if (album.beatport != null)
			foundAlbum.beatport = album.beatport;
		
//		session.close();

//		session = sessionFactory.openSession();
//		session.beginTransaction();
		session.update(foundAlbum);
//		session.getTransaction().commit();
//		session.close();
		session.flush();
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