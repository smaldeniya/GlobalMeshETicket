<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>

<head>
<title>NoQueue Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/login_page.css" rel="stylesheet" type="text/css" />
<%@include file="commonRef.jsp"%>

<script>
	function loginOnClick() {
		if (validate('username', 'email') && validate('password', 'loginPass')) {
			$("#loginForm").attr("action", "/login.do");

			$("form")[0].submit();
		}
	}

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
			$("#" + retypePass).parent().children("span[class=errorMessage]")
					.text(message);
		} else {
			$("#" + retypePass)
					.parent()
					.children("span[class=errorMessage]")
					.html(
							"<img src='../images/ok.png' height='16' width='16'/>");
		}

		return result;
	}

	function registerOnClick() {
		if (validate('email', 'regEmail')
				&& validate('regpassword', 'password')
				&& retypePasswordValidate('regpassword', 'repassword')
				&& validate('firstName', 'text')
				&& validate('lastName', 'text') && validate('nic', 'nic')
				&& validate('mobile', 'mobile') && validate('gender', 'gender')) { 
			$("#registerForm").attr("action", "/useri.do");

			$('#mask , #register-box').fadeOut(1000, function() {
				$('#mask').remove();
			});

			$("form")[1].submit();

		}
	}

	$(document).ready(function() {
		$('#registerButton').click(function() {

			//Fade in the Popup
			$("#register-box").fadeIn(300);

			//Set the center alignment padding + border see css style
			var popMargTop = ($(loginBox).height() + 24) / 2;
			var popMargLeft = ($(loginBox).width() + 24) / 2;

			$(loginBox).css({
				'margin-top' : -popMargTop,
				'margin-left' : -popMargLeft
			});

			// Add the mask to body
			$('body').append('<div id="mask"></div>');
			$('#mask').fadeIn(300);

			return false;
		});

		// When clicking on the button close or the mask layer the popup closed
		$('a.close, #mask').live('click', function() {
			$('#mask , #register-box').fadeOut(300, function() {
				$('#mask').remove();
			});
			return false;
		});
	});
</script>

</head>

<body>

	<div id="main">

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

		<div id="login-form" class="login-popup">
			<form method="post" class="signin" action="/login.do" id="loginForm"
				style="margin-top: 5px">
				<fieldset class="textbox">
					<label class="username"> <span>Email</span> <input
						id="username" name="username" value="" type="text"
						onblur="validate('username','email')" /> <span
						class="errorMessage"></span>
					</label> <label class="password"> <span>Password</span> <input
						id="password" name="password" value="" type="password" /> <span
						class="errorMessage"></span>
					</label>
					<input type="hidden" id="toUrl" name="toUrl" value="theater.do" style="display: none;"/>
					<button class="submit button" type="button"
						onclick="loginOnClick()">Sign in</button>
					<button class="submit button" type="button" id="registerButton"
						onclick="" style="margin-left: 40px; clear: right;">Register</button>
					<p class="forgot" style="position: relative; margin-top: 270px">
						<a href="resetPassword.jsp">Forgot your password?</a>
					</p>
				</fieldset>
			</form>
		</div>

		<div id="register-box" class="login-popup"
			style="width: 650px; height: 580px;">
			<a href="#" class="close"><img src="images/close_pop.png"
				class="btn_close" title="Close Window" alt="Close" /></a>
			<form method="post" class="signin" action="/useri.do"
				id="registerForm">
				<fieldset class="textbox">
					<label class="username"
						style="float: left; width: 250px; clear: both"> <span>Email</span>
						<input id="email" name="email" value="" type="text"
						style="width: 218px; height: 18px;"
						onblur="validate('email','regEmail')" /> <span
						class="errorMessage"></span>
					</label> <label class="username"
						style="float: left; width: 200px; clear: left; margin-right: 50px;">
						<span>Password</span> <input id="regpassword" name="regpassword"
						value="" type="password" style="width: 150px; height: 18px;"
						onblur="validate('regpassword','password')" /> <span
						class="errorMessage"></span>
					</label> <label class="username"
						style="float: left; width: 200px; clear: right"> <span>Retype
							Password</span> <input id="repassword" name="repassword" value=""
						type="password" style="width: 150px; height: 18px;"
						onblur="retypePasswordValidate('regpassword','repassword')" /> <span
						class="errorMessage"></span>
					</label> <label class="username"
						style="float: left; width: 250px; clear: left;"> <span>First
							Name</span> <input id="firstName" name="firstName" value="" type="text"
						style="width: 150px; height: 18px;"
						onblur="validate('firstName','text')" /> <span
						class="errorMessage"></span>
					</label> <label class="username"
						style="float: left; width: 200px; clear: right"> <span>Last
							Name</span> <input id="lastName" name="lastName" value="" type="text"
						style="width: 250px; height: 18px;"
						onblur="validate('lastName','text')" /> <span
						class="errorMessage"></span>
					</label> <label class="username"
						style="float: left; width: 200px; clear: left; margin-right: 18px;">
						<span>NIC Number</span> <input id="nic" name="nic" value=""
						type="text" style="width: 128px; height: 18px;" maxlength="10"
						onblur="validate('nic','nic')" /> <span class="errorMessage"></span>
					</label> <label class="username"
						style="float: left; width: 200px; clear: right;"> <span>Mobile
							Number</span> <input id="mobile" name="mobile" value="" type="text"
						style="width: 128px; height: 18px;" maxlength="10"
						onblur="validate('mobile','mobile')" /> <span class="errorMessage"></span>
					</label> <label class="username"
						style="float: left; width: 60px; clear: right; margin-left: 18px;">
						<span>Gender</span> <select id="gender" name="gender"
						class="styled-select" style="font-size: 17px"
						onblur="validate('gender','gender')">
							<option value="M" selected="selected">Male</option>
							<option value="F">Female</option>
					</select> <span class="errorMessage"></span>
					</label>
					<button class="submit button" type="button"
						onclick="registerOnClick()">Register</button>
				</fieldset>
			</form>
		</div>

	</div>



</body>

</html>