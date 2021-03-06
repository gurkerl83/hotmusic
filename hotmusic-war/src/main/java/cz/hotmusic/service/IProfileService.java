package cz.hotmusic.service;

import java.util.List;

import cz.hotmusic.model.User;


public interface IProfileService {
	String registerUser(User user) throws Exception, Throwable;
	User login(User user, String type) throws Exception;
	Boolean forgetPassword(User user);
	List<User> autocomplete(String sid, String text) throws Throwable;
	List<User> list(String sid, int page) throws Throwable;
	List<User> list(String sid) throws Throwable;
	int listCount(String sid) throws Throwable;
	void remove(String sid, User user) throws Throwable;
	void update(String sid, User user) throws Throwable;
	void feedback(String sid, String text) throws Throwable;
	void resetPassword(String sid, User user) throws Throwable;
	List<User> list(String sid, int page, String search, String sort)
			throws Throwable;
	int listLastMonthAddedSongs(String sid) throws Throwable;
	int listTotalAddedSongs(String sid) throws Throwable;
}
