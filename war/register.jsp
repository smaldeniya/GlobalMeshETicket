<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>

<head>
<title>Ceylon Theatres Registration</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/login_page.css" rel="stylesheet" type="text/css" />
<link href="css/register_page.css" rel="stylesheet" type="text/css" />
<link href="css/messi.css" rel="stylesheet" type="text/css" />


<%@include file="commonRef.jsp"%>
<script type="text/javascript" src="js/messi.js"></script>
<script type="text/javascript" src="js/recaptcha_ajax.js"></script>
<%-- <script type="text/javascript" src="http://www.google.com/recaptcha/api/js/recaptcha_ajax.js"></script> --%>
<script>
	$(document).ready(function(){		
		Recaptcha.create("6LffU-kSAAAAAPWLzGqr4cJtRKW2IvLHn0eq7Fo2", "captchaMy", {
			theme : "clean",
			tabindex: 1
			//callback : Recaptcha.focus_response_field
		});
	});

	function retypePasswordValidate(password, retypePass) {
		var result = false;
		var message = "";
		var passValue = $("#" + password).val();
		var rePassValue = $("#" + retypePass).val();

		if (!isEmpty(rePassValue)) {
			if (passValue === rePassValue) {
				result = true;
			} else {
				message = "Password should be match to re typed password";
			}
		} else {
			message = "Field should not be empty";
		}

		if (!result) {
			$("#" + retypePass).parent()
					.children("span[class=regerrorMessage]").text(message);
		} else {
			$("#" + retypePass)
					.parent()
					.children("span[class=regerrorMessage]")
					.html(
							"<img src='../images/ok.png' height='8' width='11'/>");
		}

		return result;
	}

	function registerOnClick() {
		
		var captchaUrl = getURLPath() + "recap.do";	   //"http://www.google.com/recaptcha/api/verify";
		var challenge = $("[name='recaptcha_challenge_field']").val();
		var response = $("[name='recaptcha_response_field']").val();
		var remoteip = myIP();
		
		var captchaValid = false;
		
		$.ajax({
		    url : captchaUrl,
		    async : false,
		    type: "POST",
		    data : {
		    	'remoteip' : remoteip,
		    	'challenge' : challenge,
		    	'response' : response
		    },
		    success: function(data, textStatus, jqXHR)
		    {
		        if(data === "true") {
		        	captchaValid = true;
		        } else {
		        	captchaValid = false;
		        }
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	captchaValid = false;
		    }
		});
		
		if(!captchaValid) {
			new Messi('Captcha validation failed! Please fill with correct values.', {title: 'Wrong Captcha Value', titleClass: 'anim error', buttons: [{id: 0, label: 'Close', val: 'X'}]});
			Recaptcha.reload();
			Recaptcha.focus_response_field();
			
			return;
		}
		
		if (isAgreedToTerms() && captchaValid && validate('firstName','text') &&
				validate('lastName','text') && 
				validate('email','regEmail') &&
				validate('NIC','nic') &&
				validate('gender','gender') &&
				validate('birthday','birthday') &&
				validate('address','any') &&
				validate('city','text') &&
				validate('mobile','mobile') &&
				validate('password','password') &&
				retypePasswordValidate('password', 'regpassword') ) {
			
			$("#registerForm").attr("action", "/useri.do");
			$("form")[0].submit();

		}
	}
	
	function myIP() {
		    if (window.XMLHttpRequest) xmlhttp = new XMLHttpRequest();
		    else xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		 
		    xmlhttp.open("GET"," http://api.hostip.info/get_html.php ",false);
		    xmlhttp.send();
		 
		    hostipInfo = xmlhttp.responseText.split("\n");
		 
		    for (i=0; hostipInfo.length >= i; i++) {
		        ipAddress = hostipInfo[i].split(":");
		        if ( ipAddress[0] == "IP" ) return ipAddress[1];
		    }
		 
		    return false;
	}
	
	function isAgreedToTerms() {
		if($("#rg_termscond").is(':checked')){
			return true;
		} else {
			new Messi('Please read and accept the <a href="/terms.jsp" class="termAancor">Terms & Conditions</a> to proceed with registration', {title: 'Registration Abroted !', titleClass: 'anim error', buttons: [{id: 0, label: 'Close', val: 'X'}]});
			return false;
		}
	}
</script>

</head>

<body>

	<div id="main" align="center" style="padding-bottom: 40px;">

		<div id="banner" class="login_banner">
			<div style="float: left; margin-top: 5px; margin-left: 20px">
				<img src="../images/ceylon_logo.png" alt="" width="80px"
					height="80px" />
			</div>
			<div style="float: left">
				<h1 style="padding: 8px 0 0 50px;">
					<a href="/init.do"><span>CEYLON </span>THEATRES <small>Bring
							You the World of Entertainment.</small></a>
				</h1>
			</div>
			<div style="float: right; padding: 35px 40px 0 0;">
				<span
					style="color: white; font-size: 35px; font-family: Liberation sans; font-variant: small-caps;">Advance
					Ticket Booking</span>
			</div>
		</div>

		<div id="login-form" class="login-popup"
			style="width: 680px; height: 780px; padding: 10px;">
			<div class="seat_plan_header">Register with Ceylon Theatres.</div>
			<form method="post" class="signin" action="/useri.do" id="registerForm"
				style="margin-top: 5px">

				<table>
					<tr>
						<td><div class="reg_label">
								<label id="titleLable" class="hasTip required"
									title="Please Select Your Title">Title :</label>
							</div></td>
						<td><div class="reg_input">
								<select id="title" name="title" class="required">
									<option value="Mr.">Mr.</option>
									<option value="Ms.">Ms.</option>
									<option value="Dr.">Dr.</option>
									<option value="Prof.">Prof.</option>
									<option value="Rev.">Rev.</option>
								</select> <span class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="firstNameLable" class="hasTip required"
									title="Enter Your First Name">First Name :
									</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="firstName" id="firstName" value=""
									class="required" size="30"
									onblur="validate('firstName','text')" /> <span
									class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="lastNameLabel" class="hasTip required"
									title="Last Name::Enter Your Last Name">Last Name :</span>
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="lastName" id="lastName"
									onblur="validate('lastName','text')" value="" class="required"
									size="30" /> <span class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="emailLable" class="hasTip required"
									title="Enter your email address">Email Address :
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="email" id="email"
									class="validate-email required" id="jform_email1" value=""
									onblur="validate('email','regEmail')"
									<%-- regEmail is a validation type --%>
									size="30" />
								<span class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="NICLabel" class="hasTip required"
									title="Enter Your National Identity Card Number">National
									Identity Card No: 
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="NIC" id="NIC" value="" class="required"
									size="30" maxlength="10" onblur="validate('NIC','nic')" /> <span
									class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="genderLable" class="hasTip required"
									title="Gender ::Please Select Your Gender">Gender :</label>
							</div></td>
						<td><div class="reg_input">
								<select id="gender" name="gender" class="required"
									onblur="validate('gender','gender')">
									<option value="M">Male</option>
									<option value="F">Female</option>
								</select> <span class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label>Date of Birth :</label>
							</div></td>
						<td><div class="reg_input">
								<input type="date" id="birthday" name="birthday"
									onblur="validate('birthday','birthday')" /> <span
									class="small_text">(A person should be over 18 years of
									age at the date of registering)</span> <span class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="addressLabel" class="hasTip required"
									title="Enter Your Address">Address: 
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="address" id="address"
									onblur="validate('address','any')" value="" class="required"
									size="30" /> <span class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="cityLabel" class="hasTip required"
									title="Enter Your City">City : 
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="city" id="city" value=""
									onblur="validate('city','text')" class="required" size="30" />
								<span class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="mobileLable" class="hasTip"
									title="Enter Your Mobile Number">Mobile : </label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="mobile" id="mobile"
									onblur="validate('mobile','mobile')" value="" size="30"
									maxlength="12" /> <span class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="passwordLable" class="hasTip required"
									title="Enter your desired password - Password length should be between 6 to 20 and include atleast one lowercase and uppercase character and a number.">Password :</label>
							</div></td>
						<td><div class="reg_input">
								<input type="password" name="password" id="password" value=""
									autocomplete="off" class="validate-password required" size="30"
									onblur="validate('password','password')" /> <span
									class="regerrorMessage"></span>
							</div> <span class="small_text" style="font-size: 10px">(Password
								length should be between 6 to 20 and include at least one
								lowercase and uppercase character and a number.)</span></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="regpasswordLable" class="hasTip required"
									title="Confirm your password">Confirm Password :
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="password" name="regpassword" id="regpassword"
									value="" autocomplete="off" class="validate-password required"
									size="30"
									onblur="retypePasswordValidate('password', 'regpassword')" /> <span
									class="regerrorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">								
								<label id="captchaLable" class="hasTip required"
									title="Please type the values to textbox">Validation :<span
									class="star">&#160;*</span>
								</label>
							</div></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td><div class="reg_input" id="captchaMy" style="display: block;padding: 5px 0px 10px 0px;">	
							</div></td>
					</tr>
					<tr>
						<td></td>
						<td><span id="ValidCheckbox"><input type="checkbox"
								name="termscond" id="rg_termscond" /> <span class="agree">I
									Agree to <a href="/terms.jsp">Terms & Conditions</a>
							</span></td>
						</span>
					</tr>
					<tr>
						<td></td>
						<td><div id="register-button">
								<button class="submit button" type="button" id="registerButton"
									style="font-size: 14px;" onclick="registerOnClick()">Register</button>
							</div></td>
					</tr>
				</table>

			</form>
		</div>

	</div>



</body>

</html>