<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>

<head>
<title>Ceylon Theatres Login</title>
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
			window.location.href = "/register.jsp";
		});

	});
</script>

</head>

<body>

	<div id="main" align="center">

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
						onclick="" style="margin-left: 40px; clear: none;">Register</button>
					<p class="forgot" style="float: right; clear: right; margin-top: 20px;">
						<a href="resetPassword.jsp">Forgot your password?</a>
					</p>
				</fieldset>
			</form>
		</div>

	</div>



</body>

</html>