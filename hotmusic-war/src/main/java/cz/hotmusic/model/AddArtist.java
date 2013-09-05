package cz.hotmusic.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.GenericGenerator;

@Entity
//@Table(uniqueConstraints=@UniqueConstraint(columnNames={"name"}))
public class AddArtist {
	public static final String WAITING_STATE = "WAITING_STATE";
	public static final String ADDED_STATE = "ADDED_STATE";
	public static final String REJECTED_STATE = "REJECTED_STATE";
	
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "artist_id")
	public String id;
	@Transient
	public String objectUUID;
	public String name;
	public Date addedDate;
	@OneToOne
	public User addedByUser;
	public String addedBySession;
	public String state; // waiting, rejected, added
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getObjectUUID() {
		return objectUUID;
	}
	public void setObjectUUID(String objectUUID) {
		this.objectUUID = objectUUID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getAddedDate() {
		return addedDate;
	}
	public void setAddedDate(Date addedDate) {
		this.addedDate = addedDate;
	}
	public User getAddedByUser() {
		return addedByUser;
	}
	public void setAddedByUser(User addedByUser) {
		this.addedByUser = addedByUser;
	}
	public String getAddedBySession() {
		return addedBySession;
	}
	public void setAddedBySession(String addedBySession) {
		this.addedBySession = addedBySession;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
}
