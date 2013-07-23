<%@page import="com.globalmesh.dto.User"%>
<%@include file="header.jsp" %>

<script>
	function btnUpdateOnClick() {
		

	}
</script>

<div class="seat_plan_header" align="center" style="width:95%">Profile Details</div>

<div class="${requestScope['msgClass']}">${requestScope['message']}</div>
<% User user = (User) request.getAttribute("user"); %>

<div id="userForm" align="center">

<div class="tabHeader">
<nav>
	<ul>
		<li><a href="#">Account Details</a></li>
		<li><a href="#">Purchase History</a></li>
	</ul>
</nav>
</div>
<div id="accountDetails">
<div class="labelDetails">
	<div>
	<fieldset class="textbox">
		<lable class="username"><span>Email</span></lable> <!-- include class which make fonts larger -->
	</fieldset>
	</div>
</div>
<div class="devider"></div>

<div class="userDetailsCommon"></div>
</div>

</div>

<%@include file="footer.jsp"%>


<!-- 


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

<button class="submit button" type="button" onclick="btnUpdateOnClick()">Buy</button>
		
</form>

 -->