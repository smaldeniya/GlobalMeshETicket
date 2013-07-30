package com.globalmesh.dto;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.globalmesh.util.Constants.MovieStatus;
import com.google.appengine.api.datastore.Blob;

/**
 * @author Dil
 * 
 */
@Entity
@Table(name = "MovieDetail")
public class MovieDetail implements Serializable {

	@Id
	@Column(name = "MovieId", nullable = false)
	private String movieId;

	@Column(name = "MovieName", nullable = false, length = 50)
	private String movieName;

	@Column(name = "MovieDetails", nullable = false, length = 1000)
	private String movieDetails;
	
	@Column(name = "MovieTheatre", nullable = false, length = 100)
	private String movieTheatre;
	
	@Column(name = "MovieTime1", nullable = true, length = 10)
	private Date[] movieTime1;
	
	@Column(name = "MovieTime2", nullable = true, length = 10)
	private Date[] movieTime2;
	
	@Column(name = "MovieTime3", nullable = true, length = 10)
	private Date[] movieTime3;
	
	@Column(name = "MovieTime4", nullable = true, length = 10)
	private Date[] movieTime4;
	
	@Column(name = "MovieTime5", nullable = true, length = 10)
	private Date[] movieTime5;
	
	@Column(name = "MovieStatus", nullable = false)
	private MovieStatus status;
	
	@Column(name = "YouTube", nullable = false)
	private String movieYouTube;
	
	@Column(name = "MoviePoster", nullable = true)
	private Blob moviePoster;

	public String getMovieId() {
		return movieId;
	}

	public void setMovieId(String movieId) {
		this.movieId = movieId;
	}

	public String getMovieName() {
		return movieName;
	}

	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}

	public String getMovieDetails() {
		return movieDetails;
	}

	public void setMovieDetails(String movieDetails) {
		this.movieDetails = movieDetails;
	}

	public String getMovieTheatre() {
		return movieTheatre;
	}

	public void setMovieTheatre(String movieTheatre) {
		this.movieTheatre = movieTheatre;
	}

	public Date[] getMovieTime1() {
		return movieTime1;
	}

	public void setMovieTime1(Date[] movieTime1) {
		this.movieTime1 = movieTime1;
	}

	public Date[] getMovieTime2() {
		return movieTime2;
	}

	public void setMovieTime2(Date[] movieTime2) {
		this.movieTime2 = movieTime2;
	}

	public Date[] getMovieTime3() {
		return movieTime3;
	}

	public void setMovieTime3(Date[] movieTime3) {
		this.movieTime3 = movieTime3;
	}

	public Date[] getMovieTime4() {
		return movieTime4;
	}

	public void setMovieTime4(Date[] movieTime4) {
		this.movieTime4 = movieTime4;
	}

	public Date[] getMovieTime5() {
		return movieTime5;
	}

	public void setMovieTime5(Date[] movieTime5) {
		this.movieTime5 = movieTime5;
	}

	public MovieStatus getStatus() {
		return status;
	}

	public void setStatus(MovieStatus status) {
		this.status = status;
	}

	public String getMovieYouTube() {
		return movieYouTube;
	}

	public void setMovieYouTube(String movieYouTube) {
		this.movieYouTube = movieYouTube;
	}

	/**
	 * @return the moviePoster
	 */
	public Blob getMoviePoster() {
		return moviePoster;
	}

	/**
	 * @param moviePoster the moviePoster to set
	 */
	public void setMoviePoster(Blob moviePoster) {
		this.moviePoster = moviePoster;
	}

}
