package cz.hotmusic.service.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
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
import cz.hotmusic.model.Song;
import cz.hotmusic.model.User;
import cz.hotmusic.model.Vote;
import cz.hotmusic.service.ISongService;

@Repository
@RemotingDestination
public class SongService implements ISongService{
	
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
	public String create(String sid, Song song) throws Throwable {
		// check inputs
		Assert.assertNotNull(song);
		Assert.assertNotNull(song.name);
		Assert.assertNotNull(song.artist);
		Assert.assertNotNull(song.genre);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		
		cz.hotmusic.model.Session sess = (cz.hotmusic.model.Session)session.createQuery("from Session where sid = :sid").setParameter("sid", sid).list().get(0);
		song.addedBySession = sid;
		song.addedDate = new Date();
		song.addedByUser = sess.user;
		
		if (song.artist != null && song.artist.id == null && song.artist.addedDate == null) {
			song.artist.addedBySession = sid;
			song.artist.addedDate = new Date();
		}
		if (song.album != null && song.album.id == null) {
			song.album.addedDate = new Date();
			song.album.addedBySession = sid;
			song.album.releaseDate = new Date();
			session.save(song.album);
		}
		
//		if (song.album.songs == null)
//			song.album.songs = new ArrayList<Song>();
//		song.album.songs.add(song);
		
		if (song.genre != null && song.genre.id == null) {
			song.genre.addedDate = new Date();
			song.genre.addedBySession = sid;
		}
		
		
		session.save(song);
		
		return song.id;
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Song> list(String sid, int page) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		// seznam songu
		
		query = session.createQuery("from Song");
		
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<Song> listSong = query.list();
		
		setCanVote(sid, listSong, session);
		
		return listSong;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<Song> listReleased(String sid, int page) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		// seznam songu
		
		query = session.createQuery("from Song where releaseDate <= :releaseDate").setParameter("releaseDate", new Date());
		
		query.setFirstResult(page * 100);
		query.setMaxResults(count);
		
		@SuppressWarnings("unchecked")
		List<Song> listSong = query.list();
		
		setCanVote(sid, listSong, session);
		
		return listSong;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<Song> list(String sid, int page, String search, String sort) throws Throwable {
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
			query = session.createQuery("from Song " + sort);
		else
			query = session.createQuery("from Song where name like :search" + sort).setParameter("search", "%" + search + "%");
			
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<Song> list = query.list();
		
		setCanVote(sid, list, session);
		
		return list;
	}
	
	private void setCanVote(String sid, List<Song> listSong, Session session) throws Exception {
		@SuppressWarnings("unchecked")
		List<User> listUser = (List<User>)session.createQuery("from User where sessionAdmin = :sid or sessionMobile = :sid").setParameter("sid", sid).list();
		if (listUser.size() != 1)
			throw new Exception("Can't find the user");
		User foundUser = listUser.get(0);
		
		// nastaveni canVote pro prihlasenyho usera
		
		for (Song song : listSong) {
			@SuppressWarnings("unchecked")
			List<Vote> listVote = session.createQuery("from Vote where song_song_id = :songId and user_user_id = :userId").setParameter("songId", song.id).setParameter("userId", foundUser.id).list();
			if (listVote.size() == 0)
				song.canVote = true;
			else
				song.canVote = false;
		}
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<Song> list(String sid) throws Throwable {
		return list(sid, 0);
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Song> listReleased(String sid) throws Throwable {
		return listReleased(sid, 0);
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<Song> autocomplete(String sid, String text) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(text);
		
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from Song where name like :name");
		
		query.setParameter("name", text + "%");
		
		query.setMaxResults(7);

		@SuppressWarnings("unchecked")
		List<Song> list = query.list();
		
		return list;
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
	public int listLastMonth(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		Date now = new Date();
		Long nowMs = now.getTime();
		Long monthMs = 1000L*60L*60L*24L*30L;
		Date monthBefore = new Date(nowMs - monthMs);
		int count = ((Long)session.createQuery("select count(*) from Song where addedDate > :monthbefore").setParameter("monthbefore", monthBefore).uniqueResult()).intValue();;
		return count;
	}

	@Override
	@RemotingInclude
	@Transactional
	public void remove(String sid, Song song) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(song);
		Assert.assertNotNull(song.id);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
//		Query query = null;
		
		session.createQuery("delete from Vote where song = :song").setParameter("song", song).executeUpdate();
		session.createQuery("delete from Song where id = :id").setParameter("id", song.id).executeUpdate();
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
			throw new Exception("Can't find the song");
		Song foundSong = list.get(0);
		
		if (song.album != null) {
			if (song.album.id != null)
				foundSong.album = (Album) session.load(Album.class, song.album.id);
			else if (song.album.name != null && song.album.name.length() > 0) {
				song.album.addedBySession = sid;
				song.album.addedDate = new Date();
				song.album.releaseDate = new Date();
				session.save(song.album);
				foundSong.album = song.album;
			}
		}
		if (song.amazon != null)
			foundSong.amazon = song.amazon;
		if (song.artist != null) {
			if (song.artist.id != null)
				foundSong.artist = (Artist) session.load(Artist.class, song.artist.id);
			else if (song.artist.name != null && song.artist.name.length() > 0) {
				song.artist.addedBySession = sid;
				song.artist.addedDate = new Date();
				session.save(song.artist);
				foundSong.artist = song.artist;
			}
		}
		if (song.beatport != null)
			foundSong.beatport = song.beatport;
		if (song.genre != null) {
			if (song.genre.id != null)
				foundSong.genre = (Genre) session.load(Genre.class, song.genre.id);
			else if (song.genre.name != null && song.genre.name.length() > 0) {
				song.genre.addedBySession = sid;
				song.genre.addedDate = new Date();
				session.save(song.genre);
				foundSong.genre = song.genre;
			}
		}
		if (song.googlePlay != null)
			foundSong.googlePlay = song.googlePlay;
		if (song.itunes != null)
			foundSong.itunes = song.itunes;
		if (song.name != null)
			foundSong.name = song.name;
		if (song.releaseDate != null)
			foundSong.releaseDate = song.releaseDate;
		if (song.soundcloud != null)
			foundSong.soundcloud = song.soundcloud;
		if (song.youtube != null)
			foundSong.youtube = song.youtube;
		
//		session.close();

//		session = sessionFactory.openSession();
//		Transaction tr = session.beginTransaction();
//		tr.begin();
		session.update(foundSong);
//		tr.commit();
//		session.close();
		session.flush();
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public void vote(String sid, Vote vote_) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(vote_);
		Assert.assertNotNull(vote_.song);
		Assert.assertNotNull(vote_.song.id);
		Assert.assertTrue(vote_.rate == -1 || vote_.rate == 1);
		sessionHelper.checkSession(sid);
		
		// LOAD USER
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User where sessionAdmin = :sid or sessionUser = :sid");
		query.setParameter("sid", sid);
		
		@SuppressWarnings("unchecked")
		List<User> list = (List<User>)query.list();
		if (list.size() != 1)
			throw new Exception("Can't find the user");
		User foundUser = list.get(0);
		
		// RATE SONG
		@SuppressWarnings("unchecked")
		List<Song> listSong = (List<Song>)session.createQuery("from Song where song_id = :songId").setParameter("songId", vote_.song.id).list();
		if (listSong.size() != 1)
			throw new Exception("Can't find the song");
		Song foundSong = listSong.get(0);
		
		// SAVE USER VOTE
		Vote v = new Vote();
		v.addedDate = new Date();
		v.rate = vote_.rate;
		v.user = foundUser; 
		v.song = foundSong;
		
		session.save(v);
		
		if (vote_.rate.intValue() > 0) {
			if (foundSong.rateUp == null) foundSong.rateUp = 0;
			foundSong.rateUp++;
		} else {
			if (foundSong.rateDown == null) foundSong.rateDown = 0;			
			foundSong.rateDown++;
		}
		
		session.save(foundSong);
		
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
