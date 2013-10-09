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
	if(validate('username','email') && validate('password', 'loginPass')){
		$("#loginForm").attr("action", "/login.do");
				
		$("form")[0].submit();	
	}
}

</script>

</head>

<body>

	<div id="main">
	
	<div id="banner" class="login_banner">
		
	</div>
	
		<div id="login-form" class="login-popup">
			<form method="post" class="signin" action="/login.do" id="loginForm" style="margin-top: 5px">
				<fieldset class="textbox">
					<label class="username"> <span>Email</span> <input
						id="username" name="username" value="" type="text" onblur="validate('username','email')"/>
						<span class="errorMessage"></span>
					</label> <label class="password"> <span>Password</span> <input
						id="password" name="password" value="" type="password" />
						<span class="errorMessage"></span>
					</label>
					<button class="submit button" type="button" onclick="loginOnClick()">Sign in</button>
					<button class="submit button" type="button" onclick="loginOnClick()" style="margin-left: 40px;clear: right;">Register</button>
					<p class="forgot" style="position: relative;margin-top: 270px">
						<a href="resetPassword.jsp">Forgot your password?</a>
					</p>
				</fieldset>
			</form>
		</div>
	
	</div>

</body>

</html>