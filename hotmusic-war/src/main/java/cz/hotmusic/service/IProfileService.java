package cz.hotmusic.service;

import java.util.List;

import cz.hotmusic.model.User;


public interface IProfileService {
	String registerUser(User user) throws Exception;
	String login(User user) throws Exception;
	Boolean forgetPassword(User user);
	List<User> autocomplete(String sid, String text) throws Throwable;
	List<User> list(String sid, int page, int count) throws Throwable;
	List<User> list(String sid) throws Throwable;
	int listCount(String sid) throws Throwable;
	void delete(String sid, User user) throws Throwable;
	void update(String sid, User user) throws Throwable;
}
