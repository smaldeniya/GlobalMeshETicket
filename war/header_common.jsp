<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>NoQueue</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/coin-slider.css" />
<link href="css/messi.css" rel="stylesheet" type="text/css" />

<%@include file="commonRef.jsp"%>

</head>

<body>
	<div class="main">
		<div class="header">
			<div class="header_resize">
					<div class="menu_nav">
					<nav>
						<ul>
							<li class="active"><a href="/init.do"><span>Ticket Dashboard</span></a></li>
							<li><a href="#" onclick="return false;"><span>Film Halls</span></a>
								<ul>
									<li style="width:152px"><a href="/gold.do"><span>Gold Cinema</span></a></li>
									<li style="width:152px"><a href="/ultra.do"><span>Ultra Cinema</span></a></li>
									<li style="width:152px"><a href="/superior.do"><span>Superior  Cinema</span></a></li>
									<li style="width:152px"><a href="/platinum.do"><span>Platinum Cinema</span></a></li>
									<li style="height:2px"></li>
								</ul>
							</li>
							<li><a href="http://www.ceylontheatres.com/"><span>Ceylon Theatres Home</span></a></li>
						</ul>
					</nav>

					<c:if test="${sessionScope['login'] == null }">
						<div class="login">
							<ul>
								<li><a href="#login-box" id="loginButton"><span>Login</span></a></li>
								<li><a href="#register-box" id="registerButton"><span>Register</span></a></li>
							</ul>
						</div>
					</c:if>
					<c:if test="${sessionScope['login'] != null }">
						<div class="post_login">
							<span style="background: none"> <span>You logged in
									as </span><span><a href="
									<c:if test="${sessionScope['type'] == 'user'}">/userg.do</c:if>
									<c:if test="${sessionScope['type'] == 'admin'}">/adminH.do</c:if>									
									" class="post_login_a"
									style="padding: 10px; color: white;">
										${sessionScope["login"]}</a> (<a href="/logout.do"
									class="post_login_a"
									style="padding-left: 5px; padding-right: 5px; color: white;">Logout</a>)
							</span>
							</span>
						</div>
					</c:if>

				</div>
				<div class="clr"></div>
				<div class="logo">
					<div style="float:left">
					<h1>
						<a href="/init.do"><span>CEYLON </span>THEATRES <small>Bring You the World of Entertainment.</small></a>
					</h1></div>
					<div style="float:right"><img src="../images/ceylon_logo.png" alt="" width="80px" height="80px"/></div>
				</div>
				<div class="clr"></div>