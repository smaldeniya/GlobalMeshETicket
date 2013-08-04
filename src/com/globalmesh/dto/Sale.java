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
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
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
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="TransactionDate", nullable=false)
	private Date transactionDate;
	
	@Column(name="NumberOfHalfTickets", nullable=false)
	private int numOfHalfTickets;
	
	@Column(name="NumberOfFullTickets", nullable=false) // fullTickets = seatCount - halftickets
	private int numOfFullfTickets;
	
	@Column(name="SeatCount", nullable=false)
	private int seatCount;
	
	@Column(name="UserId", nullable=false)
	private String UserId;
	
	@Column(name="HalfTicketPrice", nullable=false)
	private double halfTicketPrice;
	
	@Column(name="FullTicketPrice", nullable=false)
	private double fullTicketPrice;
	
	@Column(name="Total", nullable=false) // total = fullticket * fullticetPrice + halfTicket * halfTicketPrice
	private double total;
	
	@Column(name="IsOnline", nullable=false)
	private boolean online;
	
	@Column(name="HasPaid", nullable=false)
	private boolean paid;
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

	/**
	 * @return the transactionDate
	 */
	public Date getTransactionDate() {
		return transactionDate;
	}

	/**
	 * @param transactionDate the transactionDate to set
	 */
	public void setTransactionDate(Date transactionDate) {
		this.transactionDate = transactionDate;
	}

	/**
	 * @return the numOfFullfTickets
	 */
	public int getNumOfFullfTickets() {
		return numOfFullfTickets;
	}

	/**
	 * @param numOfFullfTickets the numOfFullfTickets to set
	 */
	public void setNumOfFullfTickets(int numOfFullfTickets) {
		this.numOfFullfTickets = numOfFullfTickets;
	}

	/**
	 * @return the halfTicketPrice
	 */
	public double getHalfTicketPrice() {
		return halfTicketPrice;
	}

	/**
	 * @param halfTicketPrice the halfTicketPrice to set
	 */
	public void setHalfTicketPrice(double halfTicketPrice) {
		this.halfTicketPrice = halfTicketPrice;
	}

	/**
	 * @return the fullTicketPrice
	 */
	public double getFullTicketPrice() {
		return fullTicketPrice;
	}

	/**
	 * @param fullTicketPrice the fullTicketPrice to set
	 */
	public void setFullTicketPrice(double fullTicketPrice) {
		this.fullTicketPrice = fullTicketPrice;
	}

	/**
	 * @return the total
	 */
	public double getTotal() {
		return total;
	}

	/**
	 * @param total the total to set
	 */
	public void setTotal(double total) {
		this.total = total;
	}

	/**
	 * @return the online
	 */
	public boolean isOnline() {
		return online;
	}

	/**
	 * @param online the online to set
	 */
	public void setOnline(boolean online) {
		this.online = online;
	}

	/**
	 * @return the paid
	 */
	public boolean isPaid() {
		return paid;
	}

	/**
	 * @param paid the paid to set
	 */
	public void setPaid(boolean paid) {
		this.paid = paid;
	}
		
	
}
