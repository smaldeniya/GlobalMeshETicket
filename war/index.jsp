<%@page import="com.globalmesh.dto.MovieDetail"%>
<%@include file="header.jsp" %>
<%@include file="popup.jsp" %>
<!--  put the content in the middle -->
<% MovieDetail[] mArr = (MovieDetail[])request.getAttribute("movieArray");%>

<div id="commingSoon">

</div>

<div class="movieBoard">
	<div class="movieSection" style="float:left;">
		<% if(mArr.length > 0){ %>
			<div class="movieSectionHeader">
			 <%=mArr[0].getMovieName() %>
			</div>
			
			<div class="movieSectionImage">
				<img src="/image.do?type=movie&hall=gold">
			</div>
			
			<div class="showDetails">
			
			</div>
			
		<%} %>
	</div>
	
	<div class="movieSection" style="float:right; clear:right;">
		<% if(mArr.length > 1){ %>
			<div class="movieSectionHeader">
			 <%=mArr[1].getMovieName() %>
			</div>
		<%} %>
	</div>
	
	<div class="movieSection" style="float:left;">
		<% if(mArr.length > 2){ %>
			<div class="movieSectionHeader">
			 <%=mArr[2].getMovieName() %>
			</div>
		<%} %>
	</div>
		
	<div class="movieSection" style="float:right; clear:right;">
		<% if(mArr.length > 3){ %>
			<div class="movieSectionHeader">
			 <%=mArr[3].getMovieName() %>
			</div>
		<%} %>
	</div>
</div>

<%@include file="footer.jsp"%>