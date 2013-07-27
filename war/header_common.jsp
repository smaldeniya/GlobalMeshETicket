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
				
			case "any":
				result = true;
				break;
				
			case "utube":
				var re = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
				result = re.test(value);
				message = "Enter a valid youtube embade url";
				break;
				
			case "showTime":
				var re = /^(0?[1-9]|1[012])(:[0-5]\d) [APap][mM]$/;
				result = re.test(value);
				message = "Enter a valid time (Eg. 10:30 PM)";
				break;
				
			case "number":
				var re = /^[0-9]+$/;
				result = re.test(value);
				message = "This field should only include numbers";
				break;
				
			case "curruncy":
				var re = /^[0-9]+$/;
				result = re.test(value);
				message = "Curruncy should only include numbers";
				break;
				
			case "date":
				var re = /\d{4}-\d{2}-\d{2}/;
				result = re.test(value);
				if(!result){
					message = "Please enter a valid date. Eg: 2013-01-01";
					break;
				}
				var dateParts = value.split("-");
				var today = new Date();
				
				if(today.getFullYear() === parseInt(dateParts[0])){					
					result = result && true;
				}else {
					result = result && false;
					message =" Year should be currunt year.";
					break;
				}
				
				if((today.getMonth() + 1) <= parseInt(dateParts[1]) && (today.getMonth() + 2) >= parseInt(dateParts[1]) ){					
					result = result && true;
				}else {
					result = result && false;
					message = " Month should not be before the currunt month or after two months.";
					break;
				}
								
				if((today.getMonth() + 1) === parseInt(dateParts[1])) {
					if(today.getDate() <= parseInt(dateParts[2])  ){					
						result = result && true;
					}else {
						result = result && false;
						message = " Date should be greater than or equal currunt date.";
						break;
					}
				}
				
				break;
			}

		} else {
			message = "Field should not be empty";
		}

		if (!result) {
			$("#" + id).focus();
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
					<nav>
						<ul>
							<li class="active"><a href="index.jsp"><span>Home
										Page</span></a></li>
							<li><a href=""><span>Film Halls</span></a>
								<ul>
									<li style="width:152px"><a href="/gold.do"><span>MC - Gold</span></a></li>
									<li style="width:152px"><a href="/ultra.do"><span>MC - Ultra</span></a></li>
									<li style="width:152px"><a href="/superior.do"><span>MC - Superior</span></a></li>
									<li style="width:152px"><a href="/platinum.do"><span>MC - Platinum</span></a></li>
									<li style="height:2px"></li>
								</ul>
							</li>
							<li><a href="about.html"><span>About Us</span></a></li>
							<li><a href="contact.html"><span>Contact Us</span></a></li>
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
					<h1>
						<a href="index.html"><span>Majestic </span>Cinema <small>A ceylon theaters company...</small></a>
					</h1>
				</div>
				<div class="clr"></div>