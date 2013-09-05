package cz.hotmusic.service;

import java.util.List;

import cz.hotmusic.model.AddArtist;

public interface IAddArtistService {

	String create(String sid, AddArtist addArtist) throws Throwable;

	List<AddArtist> list(String sid, int page) throws Throwable;

	List<AddArtist> list(String sid) throws Throwable;

	List<AddArtist> list(String sid, int page, String search, String sort)
			throws Throwable;

	List<AddArtist> autocomplete(String sid, String text) throws Throwable;

	List<Integer> listCount(String sid) throws Throwable;

	int listLastMonth(String sid) throws Throwable;

	void remove(String sid, AddArtist addArtist) throws Throwable;

	void update(String sid, AddArtist addArtist) throws Throwable;

	void changeState(String sid, AddArtist addArtist) throws Throwable;

}
