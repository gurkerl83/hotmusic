package cz.hotmusic.service;

import java.util.List;

import cz.hotmusic.model.Album;

public interface IAlbumService {
	String create(String sid, Album album) throws Throwable;
	List<Album> list(String sid, int page, int count) throws Throwable;
	List<Album> list(String sid) throws Throwable;
	List<Album> autocomplete(String sid, String text) throws Throwable;
	int listCount(String sid) throws Throwable;
	void delete(String sid, Album album) throws Throwable;
	void update(String sid, Album album) throws Throwable;
}
