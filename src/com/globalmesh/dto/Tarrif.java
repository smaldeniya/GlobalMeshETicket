package com.globalmesh.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Tariff")
public class Tarrif {

	@Id
	@Column(name="saleId", nullable=false)
	private String saleId;	//id=2
	
	@Column(name="cinema_id", nullable=false)
	private String cinema_id; //1
	
	@Column(name="opening", nullable=false)
	private int opening; //0
	
	@Column(name="rate", nullable=false)
	private double rate; //0.0
	
	@Column(name="ticket_type", nullable=false)
	private String ticket_type; //box_full, balcony_full, balcony_half, balcony_service, balcony_complimentary, odc_full, odc_half, odc_service, odc_complimentary, firstclass_full, firstclass_half, firstclass_service, firstclass_complimentary,box_full_late, balcony_full_late, balcony_half_late, balcony_service_late, balcony_complimentary_late, odc_full_late, odc_half_late, odc_service_late, odc_complimentary_late, firstclass_full_late, firstclass_half_late, firstclass_service_late, firstclass_complimentary_late,
	
	@Column(name="type", nullable=false)
	private String type; //basic, ent
	
	@Column(name="upadte", nullable=false)
	private String upadte; //date time 2013-07-16 08:46:41.204160
	
	/**
	 * @return the saleId
	 */
	public String getSaleId() {
		return saleId;
	}

	/**
	 * @param saleId the saleId to set
	 */
	public void setSaleId(String saleId) {
		this.saleId = saleId;
	}

	/**
	 * @return the cinema_id
	 */
	public String getCinema_id() {
		return cinema_id;
	}

	/**
	 * @param cinema_id the cinema_id to set
	 */
	public void setCinema_id(String cinema_id) {
		this.cinema_id = cinema_id;
	}

	/**
	 * @return the opening
	 */
	public int getOpening() {
		return opening;
	}

	/**
	 * @param opening the opening to set
	 */
	public void setOpening(int opening) {
		this.opening = opening;
	}

	/**
	 * @return the rate
	 */
	public double getRate() {
		return rate;
	}

	/**
	 * @param rate the rate to set
	 */
	public void setRate(double rate) {
		this.rate = rate;
	}

	/**
	 * @return the ticket_type
	 */
	public String getTicket_type() {
		return ticket_type;
	}

	/**
	 * @param ticket_type the ticket_type to set
	 */
	public void setTicket_type(String ticket_type) {
		this.ticket_type = ticket_type;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the upadte
	 */
	public String getUpadte() {
		return upadte;
	}

	/**
	 * @param upadte the upadte to set
	 */
	public void setUpadte(String upadte) {
		this.upadte = upadte;
	}
	
}
