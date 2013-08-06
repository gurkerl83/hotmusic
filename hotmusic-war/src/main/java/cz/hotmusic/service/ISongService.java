package cz.hotmusic.service;

import java.util.List;

import cz.hotmusic.model.Song;

public interface ISongService {

	String create(String sid, Song song) throws Exception, Throwable;

	List<Song> list(String sid, int page, int count) throws Throwable;

	List<Song> list(String sid) throws Throwable;

	int listCount(String sid) throws Throwable;

	void delete(String sid, Song song) throws Throwable;

	void update(String sid, Song song) throws Throwable;

	List<Song> autocomplete(String sid, String text) throws Throwable;

}
