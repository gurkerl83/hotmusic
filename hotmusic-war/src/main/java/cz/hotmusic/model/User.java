package cz.hotmusic.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.GenericGenerator;

/**
 * @author kolisko
 * @version 1.0
 * @created 06-II-2013 18:58:51
 */
@Entity
@Table(uniqueConstraints=@UniqueConstraint(columnNames={"email"}))
public class User {
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "user_id")
	public String id;
	@Transient
	public String objectUUID;
	public String nick;
	public String email;
	public String firstname;
	public String surname;
	public int version;
	public Boolean male;
	public String password;
	public Boolean facebook;
	public String facebookId;
	public String session;
	public String lastSession;
	/**
	 * true = admin, false = user
	 */
	public Boolean rights;
	
	public String getFacebookId() {
		return facebookId;
	}
	public void setFacebookId(String facebookId) {
		this.facebookId = facebookId;
	}
	public String getId() {
		return id;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public Boolean getFacebook() {
		return facebook;
	}
	public void setFacebook(Boolean facebook) {
		this.facebook = facebook;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Boolean getMale() {
		return male;
	}
	public void setMale(Boolean male) {
		this.male = male;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getObjectUUID() {
		return objectUUID;
	}
	public void setObjectUUID(String objectUUID) {
		this.objectUUID = objectUUID;
	}
	public String getSession() {
		return session;
	}
	public void setSession(String session) {
		this.session = session;
	}
	public String getLastSession() {
		return lastSession;
	}
	public void setLastSession(String lastSession) {
		this.lastSession = lastSession;
	}
}