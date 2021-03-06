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

/**
 * @author Dil
 *
 */
@Entity
@Table( name = "User" )
public class User implements Serializable{	
	
	@Id	
	@Column(name = "UserId", nullable = false,length = 11) //NIC is the user id.
	private String userId;
	@Column(name = "FirstName", nullable = false,length = 20)
	private String firstName;
	@Column(name = "LastName", nullable = false,length = 30)
	private String lastName;
	@Column(name = "Email", nullable = false,length = 50)
	private String email;
	@Column(name = "Password", nullable = false,length = 20)
	private String password;
	@Column(name = "Gender", nullable = false,length = 1)
	private String gender;//M-Male F-Female
	@Column(name = "DOB", nullable = true)
	private Date dob;
	@Column(name = "City", nullable = true ,length = 20)
	private String city;
	@Column(name = "Address", nullable = true,length = 80)
	private String address;
	@Column(name = "MobileNo", nullable = false,length = 12)
	private String mobileNo;	
	@Column(name = "Verification", nullable = false, length = 100)
	private String verified;
	@Column(name = "Type", nullable = false, length = 10)
	private String userType;
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
	public User(final String userId,final String firstName,final String lastName,final String email,
			final String password, final String gender, Date dob, final String nicNo,
			final String city, final String address, final String mobileNo) {
		super();
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.dob = dob;
		this.city = city;
		this.address = address;
		this.mobileNo = mobileNo;
	}	
	/**
	 * @return the userId
	 */
	@Id
	public String getUserId() {
		return userId;
	}	
	/**
	 * @param userId the userId to set
	 */
	public void setUserId( final String userId) {
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
	public  void setFirstName( final String firstName) {
		this.firstName = firstName;
	}
	/**
	 * @return the lastName
	 */	
	public  String getLastName() {
		return lastName;
	}
	/**
	 * @param lastName the lastName to set
	 */
	public  void setLastName( final String lastName) {
		this.lastName = lastName;
	}
	/**
	 * @return the email
	 */	
	public  String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public  void setEmail( final String email) {
		this.email = email;
	}
	/**
	 * @return the password
	 */	
	public  String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public  void setPassword( final String password) {
		this.password = password;
	}
	/**
	 * @return the gender
	 */	
	public  String getGender() {
		return gender;
	}
	/**
	 * @param gender the gender to set
	 */
	public  void setGender( final String gender) {
		this.gender = gender;
	}
	/**
	 * @return the dob
	 */	
	public  Date getDob() {
		return dob;
	}
	/**
	 * @param dob the dob to set
	 */
	public  void setDob( final Date dob) {
		this.dob = dob;
	}
	/**
	 * @return the country
	 */	
	public  String getCity() {
		return city;
	}
	/**
	 * @param country the country to set
	 */
	public  void setCity( final String city) {
		this.city = city;
	}
	/**
	 * @return the address
	 */	
	public  String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public  void setAddress( final String address) {
		this.address = address;
	}
	/**
	 * @return the mobileNo
	 */	
	public  String getMobileNo() {
		return mobileNo;
	}
	/**
	 * @param mobileNo the mobileNo to set
	 */
	public  void setMobileNo( final String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getVerified() {
		return verified;
	}
	public void setVerified(String verified) {
		this.verified = verified;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	
}
