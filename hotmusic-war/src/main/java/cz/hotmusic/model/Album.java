package cz.hotmusic.model;

import java.util.Date;
import java.util.List;

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
@Table(uniqueConstraints=@UniqueConstraint(columnNames={"name"}))
public class Album {
		@Id
		@GeneratedValue(generator = "uuid")
		@GenericGenerator(name = "uuid", strategy = "uuid")
		@Column(name = "album_id")
		public String id;
		@Transient
		public String objectUUID;
		public String name;
		@OneToOne(cascade={CascadeType.ALL})
		public Artist artist;
		@OneToOne(cascade={CascadeType.ALL})
		public Genre genre;
		public Date releaseDate;
		public String itunes;
		public String googlePlay;
		public String amazon;
		public String beatport;
//		@OneToMany(cascade=CascadeType.ALL, mappedBy="album")
//		@OneToMany(cascade=CascadeType.ALL)
//		@OneToMany
//		@JoinColumn(name="album_album_id")
//		@OrderColumn
//		@LazyCollection(LazyCollectionOption.FALSE)
		@Transient
		public List<Song> songs;
		
		public Date addedDate;
		@OneToOne(cascade=CascadeType.ALL)
		public User addedByUser;
		public String addedBySession;
		
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
		public Artist getArtist() {
			return artist;
		}
		public void setArtist(Artist artist) {
			this.artist = artist;
		}
		public Genre getGenre() {
			return genre;
		}
		public void setGenre(Genre genre) {
			this.genre = genre;
		}
		public String getItunes() {
			return itunes;
		}
		public void setItunes(String itunes) {
			this.itunes = itunes;
		}
		public String getGooglePlay() {
			return googlePlay;
		}
		public void setGooglePlay(String googlePlay) {
			this.googlePlay = googlePlay;
		}
		public String getAmazon() {
			return amazon;
		}
		public void setAmazon(String amazon) {
			this.amazon = amazon;
		}
		public String getBeatport() {
			return beatport;
		}
		public void setBeatport(String beatport) {
			this.beatport = beatport;
		}
		public List<Song> getSongs() {
			return songs;
		}
		public void setSongs(List<Song> songs) {
			this.songs = songs;
		}
		public Date getReleaseDate() {
			return releaseDate;
		}
		public void setReleaseDate(Date releaseDate) {
			this.releaseDate = releaseDate;
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
}
