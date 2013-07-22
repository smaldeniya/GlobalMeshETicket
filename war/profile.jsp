<%@page import="com.globalmesh.dto.User"%>
<%@include file="header.jsp" %>

<h2>Update Profile</h2>
<hr/>
Please update your profile to reflect your current details. Note that you are NOT permitted to update your email.
<br/><br/>

<style type="text/css">
	div.table {border: 1px solid black; display: table; width = 400px;}
/* 	div.tr {border: 1px solid black; display: table-row; width = 400px;} */
 	span.td {display: table-cell; width = 200px; float= left;} 
	 
</style>

<% User user = (User) request.getAttribute("user"); %>

<form method="post" class="signin" action="/useru.do" id="registerForm">


<div class="table">
  <div class="tr">
  	<input type="hidden" id="email" name="email" value='<%= user.getEmail() %>'>
    <span class="td" ><label> Email </label> </span>
    <span class="td1"><input type="text" value='<%= user.getEmail() %>' disabled="disabled"></span>    
  </div>
  <div class="tr">
    <span class="td"><label> First Name </label></span>
    <span class="td1"><input type="text" id="firstName" name="firstName" value='<%= user.getFirstName() %>' ></span>
  </div>
  <div class="tr">
    <span class="td"><label> Last Name </label></span>
    <span class="td1"><input type="text"  id="lastName" name="lastName"  value='<%= user.getLastName() %>' ></span>
  </div>
  <div class="tr">
  		<% String gender = null; %>
  		<% if (user.getGender().equals("M")) { %>
		<% gender = "Male"; %>
		<% } else { %>
		<% gender = "Female"; %>
		<% } %>
  	  	
    <span class="td"><label> Gender </label></span>
    <span class="td1"><input type="text" value='<%= gender %>' disabled="disabled"></span>
  </div>
  <div class="tr">
    <span class="td"><label> NIC </label></span>
    <span class="td1"><input type="text" value='<%= user.getUserId() %>' disabled="disabled" ></span>
  </div>
  <div class="tr">
    <span class="td"><label> Mobile </label></span>
    <span class="td1"><input type="text"  id="mobile" name="mobile" value='<%= user.getMobileNo() %>' ></span>
  </div>
  <div class="tr">
  	<% String country = null; %>
 	<% if (user.getCountry() == null) { %>
	<% country = ""; %>
	<% } else { %>
	<% country = user.getCountry(); %>
	<% } %>
    <span class="td"><label> Country </label></span>
    <span class="td1"><input type="text" id="country" name="country" value='<%= country %>' ></span>
  </div>
  <div class="tr">
    <% String address = null; %>
 	<% if (user.getAddress() == null) { %>
	<% address = ""; %>
	<% } else { %>
	<% address = user.getAddress(); %>
	<% } %>
    <span class="td"><label> Address </label></span>
    <span class="td1"><input type="text" id="address" name="address" value='<%= address %>' ></span>
  </div>
  <div class="tr">
    <span class="td"><label> Password </label></span>
    <span class="td1"><input type="password" id="repassword" name="repassword" ></span>
  </div>
  <div class="tr">
    <span class="td"><label> Retype Password </label></span>
    <span class="td1"><input type="password" id="repassword" name="repassword" ></span>
  </div>
  
</div>

<input class="submit button" type="submit" value="Submit" >
		
</form>
<%@include file="footer.jsp"%>
