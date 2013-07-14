<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	$(document).ready(function (){
		setActivePage();
	});
	
	function setActivePage() {
		var path = $(location).attr('href');
		var urlLength = $(location).attr('hostname').length + $(location).attr('port').length + $(location).attr('protocol').length + 4;
		var page = path.substring(urlLength, path.length);
		
		if(page != 'index.jsp' && page != 'movie.jsp' && page != 'about.jsp' && page != 'contact.jsp') { 
			$('.active').attr('class','');
		}
	}
	
	function validate(id,type){
		var result ;
		
		switch(type) {
		
			case "email":
				var re = /\S+@\S+\.\S+/;
				result = re.test($("#" + id).val());
				break;
		}
		
		return result;
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
							<li><a href="movies.html"><span>Movie Details</span></a></li>
							<li><a href="about.html"><span>About Us</span></a></li>
							<li><a href="contact.html"><span>Contact Us</span></a></li>
						</ul>
					</div>
					<div class="login">
						<ul>
							<li><a href="#login-box" id="loginButton"><span>Login</span></a></li>
							<li><a href="movies.html"><span>Register</span></a></li>
						</ul>
					</div>
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
							height="360" alt="" /><span></span></a> <a href="#"><img
							src="images/MC_Platinum.jpg" width="960" height="360" alt="" /><span></span></a>
						<a href="#"><img src="images/MC_Superior.jpg" width="960"
							height="360" alt="" /><span></span></a> <a href="#"><img
							src="images/MC_Ultra.jpg" width="960" height="360" alt="" /><span></span></a>
					</div>
					<div class="clr"></div>
				</div>
				<div class="clr"></div>
			</div>
		</div>
		
<div class="content_resize">
