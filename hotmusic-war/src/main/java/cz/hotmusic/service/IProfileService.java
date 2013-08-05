package cz.hotmusic.service;

import java.util.List;

import cz.hotmusic.model.User;


public interface IProfileService {
	String registerUser(User user) throws Exception;
	String login(User user) throws Exception;
	Boolean forgetPassword(User user);
	List<User> list(User user, int page, int count) throws Exception, Throwable;
	List<User> list(User user) throws Exception, Throwable;
	int listCount(User user) throws Exception, Throwable;
	void delete(User user) throws Exception, Throwable;
	void update(User user) throws Exception, Throwable;
}
