package com.globalmesh.dto;

import java.io.Serializable;
import java.util.Date;

import javax.jdo.annotations.Persistent;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="Sale")
public class Sale implements Serializable{

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private String id;
	
	@Column(name="SeatArrangement", nullable=false, length=100)
	private String seats;
	
	@Column(name="MovieId", nullable=false, length=100)
	private String movie;
	
	@Column(name="HallId", nullable=false, length=100)
	private String hall;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="ShowDate", nullable=false)
	private Date showDate;
	
	@Column(name="NumberOfHalfTickets", nullable=false)
	private int numOfHalfTickets;
	
	@Column(name="SeatCount", nullable=false)
	private int seatCount;
	
	@Column(name="UserId", nullable=false)
	private String UserId;

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the seats
	 */
	public String getSeats() {
		return seats;
	}

	/**
	 * @param seats the seats to set
	 */
	public void setSeats(String seats) {
		this.seats = seats;
	}

	/**
	 * @return the movie
	 */
	public String getMovie() {
		return movie;
	}

	/**
	 * @param movie the movie to set
	 */
	public void setMovie(String movie) {
		this.movie = movie;
	}

	/**
	 * @return the hall
	 */
	public String getHall() {
		return hall;
	}

	/**
	 * @param hall the hall to set
	 */
	public void setHall(String hall) {
		this.hall = hall;
	}

	/**
	 * @return the showDate
	 */
	public Date getShowDate() {
		return showDate;
	}

	/**
	 * @param showDate the showDate to set
	 */
	public void setShowDate(Date showDate) {
		this.showDate = showDate;
	}

	/**
	 * @return the numOfHalfTickets
	 */
	public int getNumOfHalfTickets() {
		return numOfHalfTickets;
	}

	/**
	 * @param numOfHalfTickets the numOfHalfTickets to set
	 */
	public void setNumOfHalfTickets(int numOfHalfTickets) {
		this.numOfHalfTickets = numOfHalfTickets;
	}

	/**
	 * @return the seatCount
	 */
	public int getSeatCount() {
		return seatCount;
	}

	/**
	 * @param seatCount the seatCount to set
	 */
	public void setSeatCount(int seatCount) {
		this.seatCount = seatCount;
	}

	/**
	 * @return the userId
	 */
	public String getUserId() {
		return UserId;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		UserId = userId;
	}
		
	
}
