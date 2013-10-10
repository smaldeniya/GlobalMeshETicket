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
	
</script>

</head>

<body>

	<div id="Main">

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

		<div class="login-popup" id="hallSelector" style="width: 550px;height: 300px">
			
			<div class="row">
				<span class="username">Select Theater :</span>
				<select id="Theater">
				
				</select>
			</div>
		
		</div>

	</div>
</body>

</html>