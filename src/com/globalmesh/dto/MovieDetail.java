/**
 * 
 */
package com.globalmesh.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author Dil
 *
 */
@Entity
@Table( name = "MovieDetail" )
public class MovieDetail {

	@Id	
	@Column(name = "MovieId", nullable = false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)//Movie Id is auto generated
	private Long movieId;
	@Column(name = "MovieName", nullable = false,length = 50)
	private String movieName;
	@Column(name = "MovieDetails", nullable = false,length = 1000)
	private String movieDetails;
	@Column(name = "MovieTheatre", nullable = false,length = 100)
	private String movieTheatre;
	@Column(name = "MovieTime1", nullable = true,length = 10)
	private String movieTime1;
	@Column(name = "MovieTime2", nullable = true,length = 10)
	private String movieTime2;
	@Column(name = "MovieTime3", nullable = true,length = 10)
	private String movieTime3;
	@Column(name = "MovieTime4", nullable = true,length = 10)
	private String movieTime4;
	@Column(name = "MovieTime5", nullable = true,length = 10)
	private String movieTime5;
	@Column(name = "MovieStatus", nullable = false)
	private int MovieStatus;
	@Column(name = "YouTube", nullable = false)
	private String movieYouTube;
	/**
	 * @return the movieId
	 */
	public Long getMovieId() {
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
	 * @param movieId the movieId to set
	 */
	public void setMovieId(Long movieId) {
		this.movieId = movieId;
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
	public String getMovieTime1() {
		return movieTime1;
	}
	/**
	 * @param movieTime1 the movieTime1 to set
	 */
	public void setMovieTime1(String movieTime1) {
		this.movieTime1 = movieTime1;
	}
	/**
	 * @return the movieTime2
	 */
	public String getMovieTime2() {
		return movieTime2;
	}
	/**
	 * @param movieTime2 the movieTime2 to set
	 */
	public void setMovieTime2(String movieTime2) {
		this.movieTime2 = movieTime2;
	}
	/**
	 * @return the movieTime3
	 */
	public String getMovieTime3() {
		return movieTime3;
	}
	/**
	 * @param movieTime3 the movieTime3 to set
	 */
	public void setMovieTime3(String movieTime3) {
		this.movieTime3 = movieTime3;
	}
	/**
	 * @return the movieTime4
	 */
	public String getMovieTime4() {
		return movieTime4;
	}
	/**
	 * @param movieTime4 the movieTime4 to set
	 */
	public void setMovieTime4(String movieTime4) {
		this.movieTime4 = movieTime4;
	}
	/**
	 * @return the movieTime5
	 */
	public String getMovieTime5() {
		return movieTime5;
	}
	/**
	 * @param movieTime5 the movieTime5 to set
	 */
	public void setMovieTime5(String movieTime5) {
		this.movieTime5 = movieTime5;
	}
	/**
	 * @return the movieStatus
	 */
	public int getMovieStatus() {
		return MovieStatus;
	}
	/**
	 * @param movieStatus the movieStatus to set
	 */
	public void setMovieStatus(int movieStatus) {
		MovieStatus = movieStatus;
	}
}
