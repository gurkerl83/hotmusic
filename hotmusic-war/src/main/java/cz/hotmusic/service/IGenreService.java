package cz.hotmusic.service;

import java.util.List;

import cz.hotmusic.model.Genre;

public interface IGenreService {

	String create(String sid, Genre genre) throws Throwable;

	List<Genre> list(String sid, int page, int count) throws Throwable;

	List<Genre> list(String sid) throws Throwable;

	List<Genre> autocomplete(String sid, String text) throws Throwable;

	int listCount(String sid) throws Throwable;

	void remove(String sid, Genre genre) throws Throwable;

	void update(String sid, Genre genre) throws Throwable;


}
