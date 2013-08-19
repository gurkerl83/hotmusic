package cz.hotmusic.service.impl;

import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cz.hotmusic.model.User;
import cz.hotmusic.service.IProfileService;

@Repository
@RemotingDestination
public class ProfileService implements IProfileService{
	
	Logger logger = LoggerFactory.getLogger(getClass());
	private SessionFactory sessionFactory;
	private SessionHelper sessionHelper;
	
	//------------------------------------------------------
	//
	// PUBLIC METHODS
	//
	//------------------------------------------------------

	@Override
	@RemotingInclude
	@Transactional
	public String registerUser(User user) throws Exception {
		// check inputs
		Assert.assertNotNull(user);
		Assert.assertNotNull(user.email);
//		Assert.assertNotNull(user.nick);
//		Assert.assertNotNull(user.password);
//		Assert.assertNotNull(user.male);
		
		if (user.version != 0)
			throw new Exception("Wrong client version. Please download newest version.");
		
//		if ((user.facebookId == null || user.facebookId.length() <= 0) && 
//			 (user.password == null || user.password.length() <= 0))
//			throw new Exception("You have to fill facebooId or password");
		
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
//				throw new Exception("user already registered. User.facebookId=" + user.facebookId);
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
		
//		if (query == null) {
//			throw new Exception("you have to fill mandatory attributes like nick or facebookId");
//		}
//		
//		List<Model> list = query.list();
//		
//		if (list != null && list.size() > 0) {
//			throw new Exception("user already registered. User.email=" + user.email);
//		}
		
		//store md5 password
//		user.password = DigestUtils.md5Hex(user.password);
		
		session = sessionFactory.openSession();
		Transaction transaction = session.beginTransaction();
		transaction.begin();
		session.save(user);
		transaction.commit();
	    session.close();
		
		return user.id;
		
	}

	@SuppressWarnings("unchecked")
	@Override
	@RemotingInclude
	@Transactional
	public User login(User user) throws Exception {
		// check inputs
		Assert.assertNotNull(user);
//		Assert.assertNotNull(user.password);
		if (user.email == null && user.facebookId == null) {
			logger.debug("You have to fill users email or facebookId");
			return null;
		}
		
		if (user.version != 0)
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
		foundUser.session = UUID.randomUUID().toString();
		
		session = sessionFactory.openSession();
		Transaction tr = session.beginTransaction();
		tr.begin();
		session.update(foundUser);
		tr.commit();
	    session.close();
		
		return foundUser;
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
	public List<User> list(String sid, int page, int count) throws Throwable {
		Assert.assertNotNull(sid);
		sessionHelper.checkSession(sid);
		
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		
		query = session.createQuery("from User");
		
		if (count == 0 ) count = 10;
		
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
		return list(sid, 0, 10);
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
