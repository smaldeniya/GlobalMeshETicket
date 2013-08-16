package com.globalmesh.dto;

public class BookingDetails {

	private String movieName;
	
	private String showDate;
	
	private String showTime;
	
	private String transactionDate;
	
	private String seatNumbers;
	
	private String saleId;
	
	

	public String getSaleId() {
		return saleId;
	}

	public void setSaleId(String saleId) {
		this.saleId = saleId;
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
	 * @return the showDate
	 */
	public String getShowDate() {
		return showDate;
	}

	/**
	 * @param showDate the showDate to set
	 */
	public void setShowDate(String showDate) {
		this.showDate = showDate;
	}

	/**
	 * @return the showTime
	 */
	public String getShowTime() {
		return showTime;
	}

	/**
	 * @param showTime the showTime to set
	 */
	public void setShowTime(String showTime) {
		this.showTime = showTime;
	}

	/**
	 * @return the transactionDate
	 */
	public String getTransactionDate() {
		return transactionDate;
	}

	/**
	 * @param transactionDate the transactionDate to set
	 */
	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}

	/**
	 * @return the seatNumbers
	 */
	public String getSeatNumbers() {
		return seatNumbers;
	}

	/**
	 * @param seatNumbers the seatNumbers to set
	 */
	public void setSeatNumbers(String seatNumbers) {
		this.seatNumbers = seatNumbers;
	}
	
	
	
}
