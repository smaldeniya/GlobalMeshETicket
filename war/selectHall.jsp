<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.globalmesh.dto.Hall"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.globalmesh.dto.MovieDetail"%>
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
	$(document).ready(function() {
		$("#imageSlider").carouFredSel({
			circular : false,
			infinite : false,
			auto : false,
			prev : {
				button : "#imageSlider_prev",
				key : "left"
			},
			next : {
				button : "#imageSlider_next",
				key : "right"
			}
		});
	});
</script>

</head>

<body>

	<div id="Main" align="center">

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


		<%
			MovieDetail[] mArr = (MovieDetail[]) request.getAttribute("nowShowing");
			Map<String, Hall> hallDetails = (Map<String, Hall>) request.getAttribute("hallDetails");
		%>

		<div id="commingSoon" style="left: 13%;height: 280px;" align="center">
			<span class="commingSoonTitle" style="float: left; margin-left: 290px;">Select
				a movie to proceed with ticket booking.</span>
			<div class="image_carousel" style="padding: 10px 0 15px 40px;">
				<div id="imageSlider" style="height: 230px;">
					<%
						for (MovieDetail movie : mArr) {
					%>
					<div class="show_item">
						<a href="/<%=hallDetails.get(movie.getMovieTheatre()).getSeatPlanUrl()%>"> <span><%=movie.getMovieTheatre()%> Cinema</span>
							<img
							src="/image.do?type=commingSoon&movieId=<%=movie.getMovieId()%>"
							width="120px" height="180px" />
						</a>
					</div>
					<%
						}
					%>
				</div>
				<div class="clearfix"></div>
				<a class="prev" id="imageSlider_prev" href="#"><span>prev</span></a>
				<a class="next" id="imageSlider_next" href="#"><span>next</span></a>
			</div>
		</div>

	</div>
</body>

</html>