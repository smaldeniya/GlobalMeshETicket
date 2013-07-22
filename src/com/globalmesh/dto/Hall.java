package com.globalmesh.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Hall")
public class Hall {

	@Id
	@Column(name="HallID")
	private String hallId;
	
	@Column(name="NumberOfSeats", nullable=false)
	private int numOfSeats;
	
	@Column(name="ThreeD", nullable=false)
	private boolean threeD;

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
}
