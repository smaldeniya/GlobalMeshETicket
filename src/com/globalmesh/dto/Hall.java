package com.globalmesh.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.google.appengine.api.datastore.Blob;

@Entity
@Table(name="Hall")
public class Hall implements Serializable{

	@Id
	@Column(name="HallID")
	private String hallId;
	
	@Column(name="NumberOfSeats", nullable=false)
	private int numOfSeats;
	
	@Column(name="ThreeD", nullable=false)
	private boolean threeD;
	
	@Column(name="OdcFull", nullable=false)
	private double odcFull;
	
	@Column(name="OdcHalf", nullable=false)
	private double odcHalf;

	@Column(name="MovieBanner", nullable=false)
	private Blob movieBanner;
	
	@Column(name="SeatPlanURI", nullable=false)
	private String seatPlanUrl;
	
	@Column(name="SeatLimit", nullable=false)
	private int seatLimit;
	
	@Column(name="3DPrice", nullable=false)
	private double price3D;
	
	/**
	 * 
	 * @return 3D Price
	 */
	public double getPrice3D() {
		return price3D;
	}

	/**
	 * 
	 * @param price3d value of 3D addition
	 */
	public void setPrice3D(double price3d) {
		price3D = price3d;
	}

	/**
	 * @return the hallId
	 */
	public String getHallId() {
		return hallId;
	}

	/**
	 * @param hallId the hallId to set
	 */
	public void setHallId(String hallId) {
		this.hallId = hallId;
	}

	/**
	 * @return the numOfSeats
	 */
	public int getNumOfSeats() {
		return numOfSeats;
	}

	/**
	 * @param numOfSeats the numOfSeats to set
	 */
	public void setNumOfSeats(int numOfSeats) {
		this.numOfSeats = numOfSeats;
	}

	/**
	 * @return the threeD
	 */
	public boolean isThreeD() {
		return threeD;
	}

	/**
	 * @param threeD the threeD to set
	 */
	public void setThreeD(boolean threeD) {
		this.threeD = threeD;
	}

	/**
	 * @return the odcFull
	 */
	public double getOdcFull() {
		return odcFull;
	}

	/**
	 * @param odcFull the odcFull to set
	 */
	public void setOdcFull(double odcFull) {
		this.odcFull = odcFull;
	}

	/**
	 * @return the odcHalf
	 */
	public double getOdcHalf() {
		return odcHalf;
	}

	/**
	 * @param odcHalf the odcHalf to set
	 */
	public void setOdcHalf(double odcHalf) {
		this.odcHalf = odcHalf;
	}

	/**
	 * @return the movieBanner
	 */
	public Blob getMovieBanner() {
		return movieBanner;
	}

	/**
	 * @param movieBanner the movieBanner to set
	 */
	public void setMovieBanner(Blob movieBanner) {
		this.movieBanner = movieBanner;
	}

	/**
	 * 
	 * @return seat plan url
	 */
	public String getSeatPlanUrl() {
		return seatPlanUrl;
	}

	/**
	 * to set the URL of seat plan
	 * @param seatPlanUrl 
	 */
	public void setSeatPlanUrl(String seatPlanUrl) {
		this.seatPlanUrl = seatPlanUrl;
	}

	/**
	 * return the maximum number of seats that can be sell via online booking for this hall
	 * @return
	 */
	public int getSeatLimit() {
		return seatLimit;
	}

	/**
	 * set the maximum number of seats that can be sell via online booking for this hall
	 * @param seatLimit
	 */
	public void setSeatLimit(int seatLimit) {
		this.seatLimit = seatLimit;
	}
}
