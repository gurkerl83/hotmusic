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

import cz.hotmusic.model.Song;
import cz.hotmusic.service.ISongService;

@Repository
@RemotingDestination
public class SongService implements ISongService{
	
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
	public String create(String sid, Song song) throws Throwable {
		// check inputs
		Assert.assertNotNull(song);
		Assert.assertNotNull(song.name);
		Assert.assertNotNull(song.artist);
		Assert.assertNotNull(song.genre);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		session.save(song);
		
		return song.id;
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Song> list(String sid, int page, int count) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from Song");
		
		if (count == 0 ) count = 10;
		
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<Song> list = query.list();
		
		return list;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<Song> list(String sid) throws Throwable {
		return list(sid, 0, 10);
	}


	@Override
	@RemotingInclude
	@Transactional
	public int listCount(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		int count = ((Long)session.createQuery("select count(*) from Song").uniqueResult()).intValue();;
		return count;
	}

	@Override
	@RemotingInclude
	@Transactional
	public void delete(String sid, Song song) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(song);
		Assert.assertNotNull(song.id);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("delete from Song where id = :id");
		query.setParameter("id", song.id);
		query.executeUpdate();
	}

	@Override
	@RemotingInclude
	@Transactional
	public void update(String sid, Song song) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(song);
		Assert.assertNotNull(song.id);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Song where id = :id");
		query.setParameter("id", song.id);
		
		@SuppressWarnings("unchecked")
		List<Song> list = (List<Song>)query.list();
		if (list.size() != 1)
			throw new Exception("Can't find the user");
		Song foundSong = list.get(0);
		foundSong.album = song.album;
		foundSong.amazon = song.amazon;
		foundSong.artist = song.artist;
		foundSong.beatport = song.beatport;
		foundSong.genre = song.genre;
		foundSong.googlePlay = song.googlePlay;
		foundSong.itunes = song.itunes;
		foundSong.name = song.name;
		foundSong.releaseDate = song.releaseDate;
		foundSong.soundcloud = song.soundcloud;
		foundSong.youtube = song.youtube;
		
//		session.close();

		session = sessionFactory.openSession();
		Transaction tr = session.beginTransaction();
		tr.begin();
		session.update(foundSong);
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
