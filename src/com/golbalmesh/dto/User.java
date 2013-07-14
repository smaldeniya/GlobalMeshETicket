/**
 * 
 */
package com.golbalmesh.dto;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * @author Dil
 *
 */
@Entity
public class User {

	@Id
	private String userId;
	private String firstName;
	private String lastName;
	private String email;
	private String password;
	private char gender;//M-Male F-Female
	private Date dob;	
	private String nicNo;	
	private String country;
	private String address;
	private String mobileNo;	
	/**
	 * 
	 */
	public User() {
		super();
	}
	/**
	 * @param userId
	 * @param firstName
	 * @param lastName
	 * @param email
	 * @param password
	 * @param gender
	 * @param dob
	 * @param nicNo
	 * @param country
	 * @param address
	 * @param mobileNo
	 */
	public User(String userId, String firstName, String lastName, String email,
			String password, char gender, Date dob, String nicNo,
			String country, String address, String mobileNo) {
		super();
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.dob = dob;
		this.nicNo = nicNo;
		this.country = country;
		this.address = address;
		this.mobileNo = mobileNo;
	}	
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}	
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}
	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	/**
	 * @return the lastName
	 */
	public String getLastName() {
		return lastName;
	}
	/**
	 * @param lastName the lastName to set
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the gender
	 */
	public char getGender() {
		return gender;
	}
	/**
	 * @param gender the gender to set
	 */
	public void setGender(char gender) {
		this.gender = gender;
	}
	/**
	 * @return the dob
	 */
	public Date getDob() {
		return dob;
	}
	/**
	 * @param dob the dob to set
	 */
	public void setDob(Date dob) {
		this.dob = dob;
	}
	/**
	 * @return the nicNo
	 */
	public String getNicNo() {
		return nicNo;
	}
	/**
	 * @param nicNo the nicNo to set
	 */
	public void setNicNo(String nicNo) {
		this.nicNo = nicNo;
	}
	/**
	 * @return the country
	 */
	public String getCountry() {
		return country;
	}
	/**
	 * @param country the country to set
	 */
	public void setCountry(String country) {
		this.country = country;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return the mobileNo
	 */
	public String getMobileNo() {
		return mobileNo;
	}
	/**
	 * @param mobileNo the mobileNo to set
	 */
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	
	
}
