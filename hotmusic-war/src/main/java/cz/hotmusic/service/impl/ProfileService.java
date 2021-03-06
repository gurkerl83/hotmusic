package cz.hotmusic.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.google.gson.Gson;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingExclude;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cz.hotmusic.model.Feedback;
import cz.hotmusic.model.Song;
import cz.hotmusic.model.User;
import cz.hotmusic.service.IProfileService;
import org.springframework.web.bind.annotation.*;

@Repository
@RemotingDestination
@RequestMapping("profile")
@Controller
public class ProfileService implements IProfileService{
	
	private static final String DEFAULT_PASSWORD = "hotmusic";
	Logger logger = LoggerFactory.getLogger(getClass());
	private SessionFactory sessionFactory;
	private SessionHelper sessionHelper;
	private final int count = 10; // velikost stranky
	
	private final String MOBILE_TYPE = "MOBILE_TYPE";
	private final String ADMIN_TYPE = "ADMIN_TYPE";
	
	//------------------------------------------------------
	//
	// PUBLIC METHODS
	//
	//------------------------------------------------------

	@Override
	@RemotingInclude
	@Transactional
	public String registerUser(User user) throws Throwable {
		return registerUser(null, user);
	}
	
	public String registerUser(String sid, User user) throws Throwable {
		// check inputs
				Assert.assertNotNull(user);
				Assert.assertNotNull(user.email);

				if (sid != null)
					sessionHelper.checkSession(sid);
				
				if (user.version != 0)
					throw new Exception("Wrong client version. Please download newest version.");
				
				// check previous registration
				Session session = sessionFactory.getCurrentSession();
				Query query = null;
				
				if (user.facebookId != null && user.facebookId.length() > 0) {
					query = session.createQuery("from User where facebookId = :facebookId");
					query.setParameter("facebookId", user.facebookId);
				
					@SuppressWarnings("unchecked")
					List<User> list = query.list();
					
					if (list != null && list.size() > 0) {
						return list.get(0).id;
//						throw new Exception("user already registered. User.facebookId=" + user.facebookId);
					}
				} 
				
				if (user.email != null && user.email.length() > 0) {
					query = session.createQuery("from User where email = :email");
					query.setParameter("email", user.email);
					
					@SuppressWarnings("unchecked")
					List<User> list = query.list();
					
					if (list != null && list.size() > 0) {
						throw new Exception("user already registered. User.email=" + user.email);
					}
				}
				
				//store md5 password
//				user.password = DigestUtils.md5Hex(user.password);
				
				// store default password
				if (user.password == null || user.password.length() == 0)
					user.password = DEFAULT_PASSWORD;
				user.addedBySession = sid;
				user.addedDate = new Date();
				
				if (sid == null)
					user.adminRights = false;
				
				session = sessionFactory.openSession();
				Transaction transaction = session.beginTransaction();
				transaction.begin();
				session.save(user);
				transaction.commit();
			    session.close();
				
				return user.id;
	}

    // call url http://localhost:8080/hotmusic-war/sample/profile/test/blabla
    @RequestMapping(value="test/{s}")
    @RemotingExclude
    @ResponseBody
    public String testJSON(@PathVariable String s) {
        return toJson(s);
    }

    private String toJson(Object o) {
        Gson gson = new Gson();
        return gson.toJson(o);
    }

	@SuppressWarnings("unchecked")
	@Override
	@RemotingInclude
	@Transactional
    @RequestMapping(value="login", method=RequestMethod.POST)
	public User login(User user, String type) throws Exception {
		// check inputs
		Assert.assertNotNull(user);
		if (type.equals(MOBILE_TYPE) && type.equals(ADMIN_TYPE))
			throw new Exception("Wrong type. Please specify MOBILE_TYPE or ADMIN_TYPE.");
//		Assert.assertNotNull(user.password);
		if (user.email == null && user.facebookId == null) {
			logger.debug("You have to fill users email or facebookId");
			return null;
		}
		
		if (user.version != 0 && type.equals(MOBILE_TYPE))
			throw new Exception("Wrong client version. Please download newest version.");
			
//		user.canPlay = true;
		
		// prepare db query
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		// facebook login
		if (user.facebookId != null)
		{
			logger.debug("Trying to find user with facebookId " + user.facebookId);
			query = session.createQuery("from User where facebookId = :facebookId");
			query.setParameter("facebookId", user.facebookId);
		}
		
		// normal login
		else if (user.email != null && user.email != "") {
			logger.debug("Trying to find user with email " + user.email);
			query = session.createQuery("from User where email = :email");
			query.setParameter("email", user.email);
		}

		// db call
		List<User> list = query.list();
		
		if (list == null || list.size() != 1) {
			logger.debug("Can not find user with email or facebookId");
			return null;
		}
		
		// check users password
		User foundUser = (User)list.get(0);

		// password mismatch
//		if (DigestUtils.md5Hex(user.password).equals(foundUser.password) || user.facebookId != null) {
		if (!user.password.equals(foundUser.password) && 
			(user.facebookId == null || user.facebookId.length() <= 0)) {
			
			logger.debug("Password mismatch");
			return null;
		}

		// login success
		logger.debug("Login success");
		
		// create and save new user session
		if (type.equals(MOBILE_TYPE)) {
			foundUser.sessionMobile = UUID.randomUUID().toString();
			saveSession(foundUser, foundUser.sessionMobile);
		} else {
			foundUser.sessionAdmin = UUID.randomUUID().toString();
			saveSession(foundUser, foundUser.sessionAdmin);
		}
		
		session = sessionFactory.openSession();
		Transaction tr = session.beginTransaction();
		tr.begin();
		session.update(foundUser);
		tr.commit();
	    session.close();
	    
	    // maping with only one session (mobile/admin)
	    
	    User returnUser = new User();
	    returnUser.addArtistAuthorized = foundUser.addArtistAuthorized;
	    returnUser.adminRights = foundUser.adminRights;
	    returnUser.email = foundUser.email;
	    returnUser.facebookId = foundUser.facebookId;
	    returnUser.firstname = foundUser.firstname;
	    returnUser.genresAuthorized = foundUser.genresAuthorized;
	    returnUser.id = foundUser.id;
	    returnUser.male = foundUser.male;
	    returnUser.nick= foundUser.nick;
	    returnUser.surname = foundUser.surname;
	    returnUser.usersAuthorized = foundUser.usersAuthorized;
	    returnUser.version = foundUser.version;
	    returnUser.sessionAdmin = type.equals(ADMIN_TYPE) ? foundUser.sessionAdmin:null;
	    returnUser.sessionMobile = type.equals(MOBILE_TYPE) ? foundUser.sessionMobile:null;
		
		return returnUser;
	}
	
	private void saveSession(User user, String sid) {
		cz.hotmusic.model.Session session = new cz.hotmusic.model.Session();
		session.user = user;
		session.sid = sid;
		session.addedDate = new Date();
		sessionFactory.getCurrentSession().save(session);
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public int listLastMonthAddedSongs(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		cz.hotmusic.model.Session sess = (cz.hotmusic.model.Session)session.createQuery("from Session where sid = :sid").setParameter("sid", sid).list().get(0);
		Date now = new Date();
		Long nowMs = now.getTime();
		Long monthMs = 1000L*60L*60L*24L*30L;
		Date monthBefore = new Date(nowMs - monthMs);
		int count = ((Long)session.createQuery("select count(*) from Song where addedDate > :monthbefore and addedByUser = :user").setParameter("monthbefore", monthBefore).setParameter("user", sess.user).uniqueResult()).intValue();;
		return count;
	}

	@Override
	@RemotingInclude
	@Transactional
	public int listTotalAddedSongs(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		cz.hotmusic.model.Session sess = (cz.hotmusic.model.Session)session.createQuery("from Session where sid = :sid").setParameter("sid", sid).list().get(0);
		int count = ((Long)session.createQuery("select count(*) from Song where addedByUser = :user").setParameter("user", sess.user).uniqueResult()).intValue();;
		return count;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public void resetPassword(String sid, User user) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(user);
		Assert.assertNotNull(user.id);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User where id = :id");
		query.setParameter("id", user.id);
		
		@SuppressWarnings("unchecked")
		List<User> list = (List<User>)query.list();
		if (list.size() != 1)
			throw new Exception("Can't find the user");
		
		User foundUser = list.get(0);
		
		// reset password
		
		if (user.password != null && user.password.length() > 0)
			foundUser.password = user.password;
		else
			foundUser.password = DEFAULT_PASSWORD;

		session = sessionFactory.openSession();
		Transaction tr = session.beginTransaction();
		tr.begin();
		session.update(foundUser);
		tr.commit();
		
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public Boolean forgetPassword(User user) {
		// check inputs
		Assert.assertNotNull(user);
		if (user.nick == null && user.email == null) {
			logger.debug("You have to fill users email or nick");
			return null;
		}
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from User where email = :email");
		query.setParameter("email", user.email);

		@SuppressWarnings("unchecked")
		List<User> list = query.list();
		
		if ((list == null || list.size() != 1) && !user.email.equals("michal@zeleny-ctverec.cz")) {
			logger.debug("Can not find user with email");
			return null;
		}
		
		User foundUser = (User)list.get(0);
//		String plainPassword = UUID.randomUUID().toString().substring(0, 5); 
//		foundUser.password = DigestUtils.md5Hex(plainPassword);
//		sessionFactory.getCurrentSession().update(foundUser);
		
		sendMail(foundUser.email, foundUser.password);
		return false;
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<User> list(String sid, int page) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from User");
		
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<User> list = query.list();
		
		return list;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<User> list(String sid) throws Throwable {
		return list(sid, 0);
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public List<User> list(String sid, int page, String search, String sort) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		if (sort != null && sort.equals("Z-A"))
			sort = " order by surname,firstname desc";
		else if (sort != null && sort.equals("Newest"))
			sort = " order by addedDate desc";
		else if (sort != null && sort.equals("Oldest"))
			sort = " order by addedDate ";
		else 
			sort = " order by surname,firstname";
		
		if (search == null || search.equals(""))
			query = session.createQuery("from User " + sort);
		else
			query = session.createQuery("from User where firstname like :search or surname like :search or email like :search" + sort).setParameter("search", "%" + search + "%");
			
		query.setFirstResult(page * count);
		query.setMaxResults(count);

		@SuppressWarnings("unchecked")
		List<User> list = query.list();
		
		return list;
	}

	@Override
	@RemotingInclude
	@Transactional
	public List<User> autocomplete(String sid, String text) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(text);
		
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from User where firstname like :text or surname like :text");
		
		query.setParameter("text", text + "%");
		
		query.setMaxResults(7);

		@SuppressWarnings("unchecked")
		List<User> list = query.list();
		
		return list;
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public int listCount(String sid) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		int count = ((Long)session.createQuery("select count(*) from User").uniqueResult()).intValue();;
		return count;
	}

	@Override
	@RemotingInclude
	@Transactional
	public void remove(String sid, User user) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(user);
		Assert.assertNotNull(user.id);
		sessionHelper.checkSession(sid);
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("delete from User where id = :id");
		query.setParameter("id", user.id);
		query.executeUpdate();
	}

	@Override
	@RemotingInclude
	@Transactional
	public void update(String sid, User user) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(user);
		Assert.assertNotNull(user.id);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User where id = :id");
		query.setParameter("id", user.id);
		
		@SuppressWarnings("unchecked")
		List<User> list = (List<User>)query.list();
		if (list.size() != 1)
			throw new Exception("Can't find the user");
		User foundUser = list.get(0);
		foundUser.firstname = user.firstname;
		foundUser.surname = user.surname;
		foundUser.email = user.email;
		foundUser.adminRights = user.adminRights;
		foundUser.genresAuthorized = user.genresAuthorized;
		foundUser.usersAuthorized = user.usersAuthorized;
		foundUser.addArtistAuthorized = user.addArtistAuthorized;
		
//		session.close();

		session = sessionFactory.openSession();
		Transaction tr = session.beginTransaction();
		tr.begin();
		session.update(foundUser);
		tr.commit();
//		session.close();
	}
	
	@Override
	@RemotingInclude
	@Transactional
	public void feedback(String sid, String text) throws Throwable {
		Assert.assertNotNull(sid);
		Assert.assertNotNull(text);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User where sessionAdmin = :sid or sessionMobile = :sid");
		query.setParameter("sid", sid);
		
		@SuppressWarnings("unchecked")
		List<User> list = (List<User>)query.list();
		if (list.size() != 1)
			throw new Exception("Can't find the user");
		User foundUser = list.get(0);
		
		Feedback fb = new Feedback();
		fb.addedDate = new Date();
		fb.text = text;
		fb.user = foundUser; 
		
		session = sessionFactory.openSession();
		Transaction tr = session.beginTransaction();
		tr.begin();
		session.save(fb);
		tr.commit();
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

	public void sendMail(String to, String password)
	{
	      // Sender's email ID needs to be mentioned
	      String from = "hotmusic@hotmusic.cz";

	      // Assuming you are sending email from localhost
	      String host = "localhost";

	      // Get system properties
	      Properties properties = System.getProperties();

	      // Setup mail server
	      properties.setProperty("mail.smtp.host", host);
	      properties.setProperty("mail.debug", "true");

	      // Get the default Session object.
	      javax.mail.Session session = javax.mail.Session.getDefaultInstance(properties);

	      try{
	         // Create a default MimeMessage object.
	         MimeMessage message = new MimeMessage(session);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));

	         // Set To: header field of the header.
	         message.addRecipient(Message.RecipientType.TO,
	                                  new InternetAddress(to));

	         String charset = "UTF-8";
	         String subject = "Heslo hotmusic.cz";
	         String mailcontent = "Vaše heslo je: " + password; 
	         // Set Subject: header field
//	         message.setSubject(new String(subject.getBytes(charset), charset), charset);
	         message.setSubject(subject, charset);

	         // Now set the actual message
//	         message.setText(new String(mailcontent.getBytes(charset), charset), charset);
	         message.setText(mailcontent, charset);
//	         message.setHeader("Content-Type", "text/html; charset=\"UTF-8\"");
//	         message.setHeader("Content-Transfer-Encoding", "8bit");

	         // Send message
	         Transport.send(message);
	         System.out.println("Sent message successfully....");
	      }catch (MessagingException mex) {
	         mex.printStackTrace();
//	      } catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
		}
	}
	

	
}
