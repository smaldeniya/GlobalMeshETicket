<%@page import="com.globalmesh.dto.BookingDetails"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.globalmesh.dto.Sale"%>
<%@page import="java.util.List"%>
<%@page import="com.globalmesh.dto.User"%>
<%@include file="header.jsp" %>

<% User user = (User) request.getAttribute("user"); %>
<script>
	$(document).ready(function (){

	});
	
	function btnUpdateOnClick(casePar) {	
		switch(casePar) {
			case "password":
				if(validate('curPasswordU', 'password') && validate('newPasswordU', 'password') && validate('retypeNewPasswordU', 'password')){
					$("#userUpdateForm").attr("action", "/useru.do");
					$("form")[1].submit();
				}
				break;
			case "common":
				if(validate('firstNameU', 'text') && validate('lastNameU', 'text') && validate('mobileU', 'mobile')) {
					$("#userUpdateForm").attr("action", "/useru.do");
					$("form")[0].submit();
				}
				break;
		}
	}
	
	function retypePasswordValidate(password, retypePass){
		var result = false ;
		var message = "";
		var passValue = $("#" + password).val();
		var rePassValue = $("#" + retypePass).val();
		
		if(!isEmpty(rePassValue)){
			if(passValue === rePassValue) {
				result = true;
			} else {
				message = "Password should be match to re typed password";
			}
		} else {
			message = "Field should not be empty";
		}
		
		if(!result){
			$("#"+retypePass).parent().children("span[class=errorMessage]").text(message);
		} else {
			$("#"+retypePass).parent().children("span[class=errorMessage]").html("<img src='../images/ok.png' height='16' width='16'/>");
		}
		
		return result;
	}
	
	function shoTab(id) {
		$(id).css('display', 'block');

		$("#userNavigation li a").each(function () {
			var tabId = $(this).attr('href');
			if(tabId != id) {
				$(tabId).css('display', 'none');
				$(this).parent().css('background-color', '#fff');
			} else {
				$(this).parent().css('background-color', '#ed1c24');
			}
		});
	}
	
	function btnReSendOnClick() {
		var url = getURLPath() + "verifyMe.do";
		
		$.ajax({
			url : url,
			async : false,
			type : "POST",
			data : {
				'type' : 'resend'
			},
			success : function(data, status) {
				$("#veriCode").val("Check your emails");
			}
		});
	}
	
	function btnVerifyOnClick() {
		var url = getURLPath() + "verifyMe.do";
		var veriCode = $("#veriCode").val();
		
		$.ajax({
			url : url,
			async : false,
			type : "POST",
			data : {
				'type' : 'verify',
				'veriCode' : veriCode				
			},
			success : function(data, status) {
				var parent = $("#veriCode").parent();
				$(parent).html("");
				$(parent).html("<input type='text' value='yes' style='margin-top:28px' disabled='disabled'/>");
			}
		}); 
	}
</script>

<div class="seat_plan_header" align="center" style="width:95%;">Profile Details</div>

<div class="${requestScope['msgClass']}">${requestScope['message']}</div>

<div id="userForm" align="center" style="marigin-top:20px;height:850px;">

<div class="tabHeader">
<nav id="userNavigation">
	<ul>
		<li><a href="#accountDetails" onclick="shoTab('#accountDetails');return false;">Account Details</a></li>
		<li><a href="#purchaseHistory" onclick="shoTab('#purchaseHistory');return false;">Future Reservations</a></li>
		<li><a href="#changePassword" onclick="shoTab('#changePassword');return false;">Change Password</a></li>
	</ul>
</nav>
</div>
<div id="accountDetails">
<div class="labelDetails">
	<div>
	<fieldset class="textbox">
		<lable ><span>Email</span></lable>
		<lable ><span>Verified</span></lable>
		<lable ><span>First Name</span></lable>
		<lable ><span>Last Name</span></lable>
		<lable ><span>Gender</span></lable>
		<lable ><span>NIC</span></lable>
		<lable ><span>Mobile</span></lable>
		<lable ><span>City</span></lable>
		<lable ><span>Address</span></lable>
	</fieldset>
	</div>
</div>
<div class="devider" style="height:550px"></div>

<div class="userDetailsCommon">
	<form action="/useru.do" id="userUpdateForm" method="post">
		<input type="hidden" id="updatetype" name="updatetype" value="common" style="display: none;" />
		<label>
			<input type="hidden" id="emailU" name="emailU" value="<%=user.getEmail() %>" style="display:none;"/>
			<input type="text" value='<%= user.getEmail() %>' disabled="disabled" style="width:250px;margin-top:30px"/>
		</label>
		<label>
			<% 	boolean verified = (user.getVerified().compareTo("true") == 0);
				if(!verified) {
			%> 
				<input type="text" id="veriCode" name="veriCode" style="margin-top:28px" value='No' onfocus="if(this.value=='No')this.value='';" onblur="if(this.value=='')this.value='No';"/>
				<button class="submit button" type="button" onclick="btnReSendOnClick()" style="margin-top:30px;clear:none;margin-left:30px">Re Send</button>
				<button class="submit button" type="button" onclick="btnVerifyOnClick()" style="margin-top:30px;clear:none;margin-left:30px">Verify</button>
			<% } else { %>
				<input type="text" value="yes" style="margin-top:28px" disabled="disabled"/>
			<% } %>
			
		</label>
		<label>
			<input type="text" id="firstNameU" name="firstNameU" style="margin-top:28px" value='<%= user.getFirstName() %>' onblur="validate('firstNameU', 'text')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		<label>
			<input type="text"  id="lastNameU" name="lastNameU"  value='<%= user.getLastName() %>'  style="margin-top:25px" onblur="validate('lastNameU', 'text')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		<label>
			<% 	String gender = null;
  				if (user.getGender().equals("M")) { 
					gender = "Male";
				} else {
					gender = "Female";
				} %>
				
			<input type="text" value='<%= gender %>' disabled="disabled" style="margin-top:25px"/>
		</label>
		<label>
			<input type="text" value='<%= user.getUserId() %>' disabled="disabled" style="margin-top:25px"/>
		</label>
		<label>
			<input type="text"  id="mobileU" size="12" name="mobileU" value='<%= user.getMobileNo() %>' style="margin-top:25px" onblur="validate('mobileU', 'mobile')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		<label>			
			<input type="text"  id="cityU" size="12" name="cityU" value='<%= user.getCity() %>' style="margin-top:25px" onblur="validate('cityU', 'text')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		<label>
			<% 	String address = null;
 				if (user.getAddress() == null) {
					address = "";
 				}else {
					address = user.getAddress();
				} %>
			<input type="text" id="addressU" name="addressU" value='<%= address %>' style="margin-top:25px; width:400px;" />
		</label>
		<label>
			<button class="submit button" type="button" onclick="btnUpdateOnClick('common')" style="margin-top:25px;">Update</button>
		</label>
		
	</form>

</div>
</div>

<div id="changePassword">
		<div class="labelDetails" style=" margin-top:145px">
			<div>
				<fieldset class="textbox">
					<lable>
					<span>Currunt Password</span></lable>
					<lable>
					<span>New Password</span></lable>
					<lable>
					<span>Retype Password</span></lable>
				</fieldset>
			</div>
		</div>
		
		<div class="devider" style="height:140px; margin-top:210px"></div>
		
		<div class="userDetailsCommon" style="margin-top:160px">
		<form action="/useru.do" id="userUpdateForm" method="post">
			<input type="hidden" id="emailU" name="emailU" value="<%=user.getEmail()%>" style="display: none;" />
			<input type="hidden" id="updatetype" name="updatetype" value="password" style="display: none;" />
			<label> 
				<input id="curPasswordU" name="curPasswordU" style="margin-top: 30px" type="password" onblur="validate('curPasswordU', 'password')"/>
			</label>
			<label> 
				<input type="password" id="newPasswordU" name="newPasswordU" style="margin-top: 28px" value="" onblur="validate('newPasswordU', 'password')" /> 
				<span class="errorMessage" style="float: left; margin-left: 5px; margin-top: 35px;"></span>
			</label>
			<label> 
				<input type="password" id="retypeNewPasswordU" name="retypeNewPasswordU" value="" style="margin-top: 25px"
				onblur="retypePasswordValidate('newPasswordU', 'retypeNewPasswordU')" />
				 <span class="errorMessage" style="float: left; margin-left: 5px; margin-top: 35px;"></span>
			</label>
			<label>
				<button class="submit button" type="button" onclick="btnUpdateOnClick('password')" style="margin-top:25px;">Update</button>
			</label>
		</form>
	</div>
</div>
<%--
<script type="text/javascript">
	//$(".CSSTableGenerator").ready(function(){
	//	$(".CSSTableGenerator table button").each(function() {
	//		$(this).bind('click', function() {
	//		});
	//	});
	//});
	
	function requestRePrint(number) {
		var saleId = $("#saleId" + number).val();
		var url = getURLPath() + "reprintTicket.do";
		
		if(!isEmpty(saleId)) {
			$.ajax({
				url : url,
				async : false,
				type : "POST",
				data : {
					'saleId' : saleId				
				},
				success : function(data, status) {
					
				}
			}); 
		}
	}
</script>
--%>
<div id="purchaseHistory">
	<%
		List<BookingDetails> futureBookings = (List<BookingDetails>)request.getAttribute("bookings");
		if(futureBookings.size() > 0) {
	%>
		<div class="CSSTableGenerator" style="margin-top:150px;width:800px">
                <table border="0" cellspacing="0">
                    <tr>
                    	<td>Name of the movie</td>
                        <td>Show Date</td>
                        <td>Show Time</td>
                        <td>Tranaction Date</td>
                        <td>Seat Numbers</td>
                       <%-- <td>Re-print tickets</td> --%> 
                    </tr>
                    <% 	int i=0;
                    	for(BookingDetails b: futureBookings) {%>
                    	<tr>
                      		<td><%=b.getMovieName() %></td>
                      		<td><%=b.getShowDate() %></td>
                      		<td><%=b.getShowTime() %></td>
                      		<td><%=b.getTransactionDate() %></td>
                      		<td><%=b.getSeatNumbers() %></td>
                      <%--		<td>
                      			<input type="hidden" value="<%=b.getSaleId()%>" id="saleId<%=i%>"/>
                      			<button id="reqTicket<%=i%>" class="submit button" type="button" onclick="requestRePrint(<%=i%>)">Request Ticket</button>
                      		</td> --%>
                    	</tr>
                    <%	i++;
                    	} %>
                </table>
            </div>
            
	<% } else { %>
		<div class="infoMsg" style="margin-top:150px">You do not have any future bookings for movies.</div>
	<%} %>
</div>

</div>

<%@include file="footer.jsp"%>