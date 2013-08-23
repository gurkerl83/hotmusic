package cz.hotmusic.service;

import java.util.List;

import cz.hotmusic.model.Song;
import cz.hotmusic.model.Vote;

public interface ISongService {
	String create(String sid, Song song) throws Exception, Throwable;
	List<Song> list(String sid) throws Throwable;
	int listCount(String sid) throws Throwable;
	void remove(String sid, Song song) throws Throwable;
	void update(String sid, Song song) throws Throwable;
	List<Song> autocomplete(String sid, String text) throws Throwable;
	int listLastMonth(String sid) throws Throwable;
	void vote(String sid, Vote vote_) throws Throwable;
	List<Song> list(String sid, int page) throws Throwable;
	List<Song> list(String sid, int page, String search, String sort)
			throws Throwable;
}
