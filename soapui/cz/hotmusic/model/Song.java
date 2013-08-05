package cz.hotmusic.model;

import java.util.Date;

public class Song {
	public String id;
	public String objectUUID; 
	public String name;
	public Artist artist;
	public Album album;
	public Genre genre;
	public Date releaseDate;
	public String itunes;
	public String googlePlay;
	public String amazon;
	public String beatport;
	public String soundcloud;
	public String youtube;
	
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
	public Album getAlbum() {
		return album;
	}
	public void setAlbum(Album album) {
		this.album = album;
	}
	public Genre getGenre() {
		return genre;
	}
	public void setGenre(Genre genre) {
		this.genre = genre;
	}
	public Date getRelease() {
		return releaseDate;
	}
	public void setRelease(Date release) {
		this.releaseDate = release;
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
	public String getSoundcloud() {
		return soundcloud;
	}
	public void setSoundcloud(String soundcloud) {
		this.soundcloud = soundcloud;
	}
	public String getYoutube() {
		return youtube;
	}
	public void setYoutube(String youtube) {
		this.youtube = youtube;
	}
}
