/**
 * 
 */
package com.globalmesh.dto;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.globalmesh.util.Constants.MovieStatus;

/**
 * @author Dil
 *
 */
@Entity
@Table( name = "MovieDetail" )
public class MovieDetail implements Serializable{

	@Id	
	@Column(name = "MovieId", nullable = false)
	private String movieId;
	@Column(name = "MovieName", nullable = false,length = 50)
	private String movieName;
	@Column(name = "MovieDetails", nullable = false,length = 1000)
	private String movieDetails;
	@Column(name = "MovieTheatre", nullable = false,length = 100)
	private String movieTheatre;
	@Column(name = "MovieTime1", nullable = true,length = 10)
	private Date movieTime1;
	@Column(name = "MovieTime2", nullable = true,length = 10)
	private Date movieTime2;
	@Column(name = "MovieTime3", nullable = true,length = 10)
	private Date movieTime3;
	@Column(name = "MovieTime4", nullable = true,length = 10)
	private Date movieTime4;
	@Column(name = "MovieTime5", nullable = true,length = 10)
	private Date movieTime5;
	@Column(name = "MovieStatus", nullable = false)
	private MovieStatus status;
	@Column(name = "YouTube", nullable = false)
	private String movieYouTube;
	/**
	 * @return the movieId
	 */
	public String getMovieId() {
		return movieId;
	}
	/**
	 * @return the movieYouTube
	 */
	public String getMovieYouTube() {
		return movieYouTube;
	}
	/**
	 * @param movieYouTube the movieYouTube to set
	 */
	public void setMovieYouTube(String movieYouTube) {
		this.movieYouTube = movieYouTube;
	}
	/**
	 * @return the movieName
	 */
	public String getMovieName() {
		return movieName;
	}
	/**
	 * @param movieName the movieName to set
	 */
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	/**
	 * @return the movieDetails
	 */
	public String getMovieDetails() {
		return movieDetails;
	}
	/**
	 * @param movieDetails the movieDetails to set
	 */
	public void setMovieDetails(String movieDetails) {
		this.movieDetails = movieDetails;
	}
	/**
	 * @return the movieTheatre
	 */
	public String getMovieTheatre() {
		return movieTheatre;
	}
	/**
	 * @param movieTheatre the movieTheatre to set
	 */
	public void setMovieTheatre(String movieTheatre) {
		this.movieTheatre = movieTheatre;
	}
	/**
	 * @return the movieTime1
	 */
	public Date getMovieTime1() {
		return movieTime1;
	}
	/**
	 * @param movieTime1 the movieTime1 to set
	 */
	public void setMovieTime1(Date movieTime1) {
		this.movieTime1 = movieTime1;
	}
	/**
	 * @return the movieTime2
	 */
	public Date getMovieTime2() {
		return movieTime2;
	}
	/**
	 * @param movieTime2 the movieTime2 to set
	 */
	public void setMovieTime2(Date movieTime2) {
		this.movieTime2 = movieTime2;
	}
	/**
	 * @return the movieTime3
	 */
	public Date getMovieTime3() {
		return movieTime3;
	}
	/**
	 * @param movieTime3 the movieTime3 to set
	 */
	public void setMovieTime3(Date movieTime3) {
		this.movieTime3 = movieTime3;
	}
	/**
	 * @return the movieTime4
	 */
	public Date getMovieTime4() {
		return movieTime4;
	}
	/**
	 * @param movieTime4 the movieTime4 to set
	 */
	public void setMovieTime4(Date movieTime4) {
		this.movieTime4 = movieTime4;
	}
	/**
	 * @return the movieTime5
	 */
	public Date getMovieTime5() {
		return movieTime5;
	}
	/**
	 * @param movieTime5 the movieTime5 to set
	 */
	public void setMovieTime5(Date movieTime5) {
		this.movieTime5 = movieTime5;
	}
	/**
	 * @return the movieStatus
	 */
	public MovieStatus getMovieStatus() {
		return status;
	}
	/**
	 * @param nowshowing the movieStatus to set
	 */
	public void setMovieStatus(MovieStatus nowshowing) {
		status = nowshowing;
	}
	/**
	 * @param movieId the movieId to set
	 */
	public void setMovieId(String movieId) {
		this.movieId = movieId;
	}
}
