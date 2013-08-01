<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.globalmesh.dto.MovieDetail"%>
<%@include file="header.jsp" %>
<%@include file="popup.jsp" %>
<!--  put the content in the middle -->
<% MovieDetail[] mArr = (MovieDetail[])request.getAttribute("movieArray");
	int today = (Integer)request.getAttribute("today");
	DateFormat showFormat = new SimpleDateFormat("hh:mm a");
%>

<div id="commingSoon">

</div>

<div class="movieBoard">
	<div class="movieSection" style="float:left;">
		<% if(mArr.length > 0){ %>
			<div class="movieSectionHeader">
			 <%=mArr[0].getMovieName() %>
			</div>
			
			<div>
				<div class="movieSectionImage">
					<img src="/image.do?type=movie&hall=<%=mArr[0].getMovieTheatre()%>"	width="214px" height="317px">
				</div>
				<div class="showDetails">
					<%=mArr[0].getMovieDetails() %>
				</div>
			</div>
			
			<div class="showTimes">
				<% 
					if(mArr[0].getMovieTime1() != null && mArr[0].getMovieTime1().length > 0) out.print("<div>" + showFormat.format(mArr[0].getMovieTime1()[today]) + "</div>");
					if(mArr[0].getMovieTime2() != null && mArr[0].getMovieTime2().length > 0) out.print("<div>" + showFormat.format(mArr[0].getMovieTime2()[today]) + "</div>");
					if(mArr[0].getMovieTime3() != null && mArr[0].getMovieTime3().length > 0) out.print("<div>" + showFormat.format(mArr[0].getMovieTime3()[today]) + "</div>");
					if(mArr[0].getMovieTime4() != null && mArr[0].getMovieTime4().length > 0) out.print("<div>" + showFormat.format(mArr[0].getMovieTime4()[today]) + "</div>");
					if(mArr[0].getMovieTime5() != null && mArr[0].getMovieTime5().length > 0) out.print("<div>" + showFormat.format(mArr[0].getMovieTime5()[today]) + "</div>");
				%>
			</div>
			
		<%} %>
	</div>
	
	<div class="movieSection" style="float:right; clear:right;">
		<% if(mArr.length > 1){ %> 
			<div class="movieSectionHeader">
			 <%=mArr[1].getMovieName() %>
			</div>
		
			<div>
				<div class="movieSectionImage">
					<img src="/image.do?type=movie&hall=<%=mArr[1].getMovieTheatre()%>"	width="214px" height="317px">
				</div>
				<div class="showDetails">
					<%=mArr[1].getMovieDetails() %>
				</div>
			</div>
			
			<div class="showTimes">
				<% 
					if(mArr[1].getMovieTime1() != null && mArr[1].getMovieTime1().length > 0) out.print("<div>" + showFormat.format(mArr[1].getMovieTime1()[today]) + "</div>");
					if(mArr[1].getMovieTime2() != null && mArr[1].getMovieTime2().length > 0) out.print("<div>" + showFormat.format(mArr[1].getMovieTime2()[today]) + "</div>");
					if(mArr[1].getMovieTime3() != null && mArr[1].getMovieTime3().length > 0) out.print("<div>" + showFormat.format(mArr[1].getMovieTime3()[today]) + "</div>");
					if(mArr[1].getMovieTime4() != null && mArr[1].getMovieTime4().length > 0) out.print("<div>" + showFormat.format(mArr[1].getMovieTime4()[today]) + "</div>");
					if(mArr[1].getMovieTime5() != null && mArr[1].getMovieTime5().length > 0) out.print("<div>" + showFormat.format(mArr[1].getMovieTime5()[today]) + "</div>");
				%>
			</div>
		<% } %>
	</div>
	
	<div class="movieSection" style="float:left;">
		<% if(mArr.length > 2){ %>
			<div class="movieSectionHeader">
			 <%=mArr[2].getMovieName() %>
			</div>
					
			<div>
				<div class="movieSectionImage">
					<img src="/image.do?type=movie&hall=<%=mArr[2].getMovieTheatre()%>"	width="214px" height="317px"	>
				</div>
				<div class="showDetails">
					<%=mArr[2].getMovieDetails() %>
				</div>
			</div>
			
			<div class="showTimes">
				<% 
					if(mArr[2].getMovieTime1() != null && mArr[2].getMovieTime1().length > 0) out.print("<div>" + showFormat.format(mArr[2].getMovieTime1()[today]) + "</div>");
					if(mArr[2].getMovieTime2() != null && mArr[2].getMovieTime2().length > 0) out.print("<div>" + showFormat.format(mArr[2].getMovieTime2()[today]) + "</div>");
					if(mArr[2].getMovieTime3() != null && mArr[2].getMovieTime3().length > 0) out.print("<div>" + showFormat.format(mArr[2].getMovieTime3()[today]) + "</div>");
					if(mArr[2].getMovieTime4() != null && mArr[2].getMovieTime4().length > 0) out.print("<div>" + showFormat.format(mArr[2].getMovieTime4()[today]) + "</div>");
					if(mArr[2].getMovieTime5() != null && mArr[2].getMovieTime5().length > 0) out.print("<div>" + showFormat.format(mArr[2].getMovieTime5()[today]) + "</div>");
				%>
			</div>
		<%} %>
	</div>
		
	<div class="movieSection" style="float:right; clear:right;">
		<% if(mArr.length > 3){ %>
			<div class="movieSectionHeader">
			 <%=mArr[3].getMovieName() %>
			</div>
			
			<div>
				<div class="movieSectionImage">
					<img src="/image.do?type=movie&hall=<%=mArr[3].getMovieTheatre()%>"	width="214px" height="317px"	>
				</div>
				<div class="showDetails">
					<%=mArr[3].getMovieDetails() %>
				</div>
			</div>
			
			<div class="showTimes">
				<% 
					if(mArr[3].getMovieTime1() != null && mArr[3].getMovieTime1().length > 0) out.print("<div>" + showFormat.format(mArr[3].getMovieTime1()[today]) + "</div>");
					if(mArr[3].getMovieTime2() != null && mArr[3].getMovieTime2().length > 0) out.print("<div>" + showFormat.format(mArr[3].getMovieTime2()[today]) + "</div>");
					if(mArr[3].getMovieTime3() != null && mArr[3].getMovieTime3().length > 0) out.print("<div>" + showFormat.format(mArr[3].getMovieTime3()[today]) + "</div>");
					if(mArr[3].getMovieTime4() != null && mArr[3].getMovieTime4().length > 0) out.print("<div>" + showFormat.format(mArr[3].getMovieTime4()[today]) + "</div>");
					if(mArr[3].getMovieTime5() != null && mArr[3].getMovieTime5().length > 0) out.print("<div>" + showFormat.format(mArr[3].getMovieTime5()[today]) + "</div>");
				%>
			</div>
			
		<%} %>
	</div>
</div>

<%@include file="footer.jsp"%>