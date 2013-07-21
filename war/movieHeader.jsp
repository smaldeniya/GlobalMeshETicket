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
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/cufon-marketingscript.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/coin-slider.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		setActivePage();
	});

	function setActivePage() {
		var path = $(location).attr('href');
		var urlLength = $(location).attr('hostname').length
				+ $(location).attr('port').length
				+ $(location).attr('protocol').length + 4;
		var page = path.substring(urlLength, path.length);

		if (page != 'index.jsp' && page != 'movie.jsp' && page != 'about.jsp'
				&& page != 'contact.jsp') {
			$('.active').attr('class', '');
		}
	}

	function getURLPath() {
		return $(location).attr('protocol') + "//" + $(location).attr('hostname') + ":" + $(location).attr('port') + "/";
	}
	
	function validate(id, type) {
		var result = false;
		var message = "";
		var value = $("#" + id).val();

		if (!isEmpty(value)) {
			switch (type) {

			case "email":
				var re = /\S+@\S+\.\S+/;
				result = re.test(value);
				message = "Please enter a valid Email address";
				break;

			case "password":
				var re = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
				result = re.test(value);
				message = "Password length should be between 6 to 20 and include atleast one lowercase and uppercase character and a number.";
				break;

			case "text":
				var re = /^[a-zA-z]+$/;
				result = re.test(value);
				message = "Name should only contain text characters";
				break;

			case "gender":
				result = true;
				break;

			case "mobile":
				var re = /^\d{10}$/;
				result = re.test(value);
				message = "Mobile number shoiuld only contain numbers";
				break;

			case "nic":
				var re = /^\d{9}\S{1}$/;
				result = re.test(value);
				message = "Please enter a valid nic number.";
				break;

			case "regEmail":
				var re = /\S+@\S+\.\S+/;
				result = re.test(value);
				if(!result){
					message = "Please enter a valid Email address.";
				}
				
				var checkURL = getURLPath() + "userCheck.do?by=email&value=" + value;
				$.ajax({
					url:checkURL,
					async:false,
					type : "GET",
					success: function(data,status){
						if(data == "null"){
							result = result && true;
						} else {
							result = result && false;
							message = message + " This email is already registered.";
						}
					}
				});
				break;

			case "loginPass":
				result = true;
				break;
			}

		} else {
			message = "Field should not be empty";
		}

		if (!result) {
			$("#" + id).parent().children("span[class=errorMessage]").text(
					message);
		} else {
			$("#" + id).parent().children("span[class=errorMessage]").html(
					"<img src='../images/ok.png' height='16' width='16'/>");
		}

		return result;
	}

	function isEmpty(str) {
		return (!str || 0 === str.length);
	}
</script>

</head>

<body>
	<div class="main">
		<div class="header">
			<div class="header_resize">
				<div class="menu_nav">
					<div>
						<ul>
							<li class="active"><a href="index.jsp"><span>Home
										Page</span></a></li>
							<li><a href=""><span>Film Halls</span></a>
								<ul>
									<li><a href="gold_seatPlan.jsp"><span>MC - Gold</span></a></li>
								</ul>
							</li>
							<li><a href="about.html"><span>About Us</span></a></li>
							<li><a href="contact.html"><span>Contact Us</span></a></li>
						</ul>
					</div>

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
									as </span><span><a href="profile.jsp" class="post_login_a"
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
					<h1>
						<a href="index.html"><span>Creative</span>World <small>Company
								Slogan Here</small></a>
					</h1>
				</div>
				<div class="clr"></div>
				<div class="slider">
					<div id="coin-slider">
						<a href="#"><img src="images/MC_Gold.jpg" width="960"
							height="360" alt="" /><span></span></a> 
					</div>
					<div class="clr"></div>
				</div>
				<div class="clr"></div>
			</div>
		</div>

		<div class="content">
			<div class="content_resize">
				<div class="mainbar">