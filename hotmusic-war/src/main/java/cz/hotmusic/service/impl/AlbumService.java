package cz.hotmusic.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.access.SingletonBeanFactoryLocator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cz.hotmusic.model.Album;
import cz.hotmusic.model.Artist;
import cz.hotmusic.model.Genre;
import cz.hotmusic.model.Song;
import cz.hotmusic.service.IAlbumService;
import cz.hotmusic.service.ISongService;

@Repository
@RemotingDestination
public class AlbumService implements IAlbumService{
	
	Logger logger = LoggerFactory.getLogger(getClass());
	private SessionFactory sessionFactory;
	private SessionHelper sessionHelper;
	private final int count = 10; // velikost stranky
	private ISongService songService;
	
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

		album.addedBySession = sid;
		album.addedDate = new Date();
		
		if (album.artist != null && album.artist.id == null && album.artist.addedDate == null) {
			album.artist.addedBySession = sid;
			album.artist.addedDate = new Date();
		}
		
		if (album.genre != null && album.genre.id == null) {
			album.genre.addedDate = new Date();
			album.genre.addedBySession = sid;
		}
		
		if (album.songs != null && album.songs.size() > 0) {
			for (Song song : album.songs) {
				// if song exists in db do song update
				if (song != null && song.id != null && song.id.length() > 0) {
					songService.update(sid, song);
				} else {
					songService.create(sid, song);
				}
			}
		}
		
		session.save(album);
		
		return album.id;
	}

	@SuppressWarnings("unchecked")
	@Override
	@RemotingInclude
	@Transactional
	public List<Album> list(String sid, int page) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from Album");
		
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		List<Album> list = query.list();
		
		for (Album album : list) {
			album.songs = new ArrayList<Song>();
			album.songs.addAll((List<Song>)session.createQuery("from Song where album = :album").setParameter("album", album).list());
		}
		
		return list;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<Album> list(String sid) throws Throwable {
		return list(sid, 0);
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<Album> list(String sid, int page, String search, String sort) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		if (sort != null && sort.equals("Z-A"))
			sort = " order by name desc";
		else if (sort != null && sort.equals("Newest"))
			sort = " order by releaseDate desc";
		else if (sort != null && sort.equals("Oldest"))
			sort = " order by releaseDate";
		else 
			sort = " order by name";
		
		if (search == null || search.equals(""))
			query = session.createQuery("from Album " + sort);
		else
			query = session.createQuery("from Album where name like :search" + sort).setParameter("search", "%" + search + "%");
			
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<Album> list = query.list();
		
		return list;
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
	public int listLastMonth(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		Date now = new Date();
		Long nowMs = now.getTime();
		Long monthMs = 1000L*60L*60L*24L*30L;
		Date monthBefore = new Date(nowMs - monthMs);
		int count = ((Long)session.createQuery("select count(*) from Album where addedDate > :monthbefore").setParameter("monthbefore", monthBefore).uniqueResult()).intValue();;
		return count;
	}

	@Override
	@RemotingInclude
	@Transactional
	public void remove(String sid, Album album) throws Throwable {
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
		@SuppressWarnings("unchecked")
		List<Song> foundSongs = session.createQuery("from Song where album = :album").setParameter("album", foundAlbum).list();
		
		if (album.name != null)
			foundAlbum.name = album.name;
		if (album.artist != null) {
			if (album.artist.id != null)
				foundAlbum.artist = (Artist) session.load(Artist.class, album.artist.id);
			else if (album.artist.name != null && album.artist.name.length() > 0) {
				album.artist.addedBySession = sid;
				album.artist.addedDate = new Date();
				session.save(album.artist);
				foundAlbum.artist = album.artist;
			}
		}
		if (album.genre != null) {
			if (album.genre.id != null)
				foundAlbum.genre = (Genre) session.load(Genre.class, album.genre.id);
			else if (album.genre.name != null && album.genre.name.length() > 0) {
				album.genre.addedBySession = sid;
				album.genre.addedDate = new Date();
				session.save(album.genre);
				foundAlbum.genre = album.genre;
			}
		}
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
		
		if (album.songs != null && album.songs.size() > 0) {
			for (Song song : album.songs) {
				song.artist = foundAlbum.artist;
				// if song exists in db do song update
				if (song != null && song.id != null && song.id.length() > 0) {
					songService.update(sid, song);
				} else {
					songService.create(sid, song);
				}
			}
		}
		
		if (foundSongs != null) { 
			for (Song songold : foundSongs) {
				Boolean isMatch = false;
				for (Song songnew : album.songs) {
					if (songnew == songold || songnew != null && songnew.id != null && songnew.id.equals(songold.id)) {
						isMatch  = true;
						break;
					}
				}
				// odstran vazbu na album
				if (!isMatch) {
					songold.album = null;
					songService.update(sid, songold);
				}
			}
		}
		
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

	public ISongService getSongService() {
		return songService;
	}

	@Autowired
	public void setSongService(ISongService songService) {
		this.songService = songService;
	}

}
