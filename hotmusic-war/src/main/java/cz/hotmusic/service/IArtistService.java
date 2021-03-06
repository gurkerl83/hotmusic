package cz.hotmusic.service;

import java.util.List;

import cz.hotmusic.model.Artist;

public interface IArtistService {
	String create(String sid, Artist artist) throws Throwable;
	List<Artist> list(String sid) throws Throwable;
	int listCount(String sid) throws Throwable;
	void remove(String sid, Artist artist) throws Throwable;
	void update(String sid, Artist artist) throws Throwable;
	List<Artist> autocomplete(String sid, String text) throws Throwable;
	int listLastMonth(String sid) throws Throwable;
	List<Artist> list(String sid, int page, String search, String sort)
			throws Throwable;
	List<Artist> list(String sid, int page) throws Throwable;
}
