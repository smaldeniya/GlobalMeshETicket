<%@page import="java.util.List"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@include file="header_common.jsp" %>

				<div class="slider">					
						<a href="#"><img src="/image.do?type=hall&hall=Gold" width="960"
							height="360" alt="" /><span></span></a> 
					<div class="clr"></div>
				</div>
				<div class="clr"></div>
			</div>
		</div>

<%@include file="movieJsCommon.jsp" %>

<div class="seat_plan_header">Majestic cinema - Gold</div>
<div class="clr"></div>

<div class="infoMsg" style="margin-bottom:10px;" id="beforClickMsg">Please select a date and time to proceed with ticket booking. Note that you have <b>2 minutes</b> to select a date & time, select the seats, and pay for the selected seats.</div>

<div id="ticketForm">
  	<form action="/book.do" method="post" id="filmBookForms" name="filmBookForms">
  		<input hidden="true" style="display:none" value="gold" id="hallName" name="hallName"/>
  		<div style="margin-left:20px;">
  			<label>
	  			<span>Show Date</span>
	  			<input type="date" id="showDate" name="showDate" onblur="validate('showDate','date');"/>
	  			<span class="errorMessage" style="clear:both; margin-top:20px; line-width:15px"></span>
	  		</label>
  		</div>
  		
  		<div style="margin-left:260px">
  			<label>
	  			<span>Show Time</span>
	  			<select class="styled-select " id="showTime" name="showTime" style="font-size:18px;clear:both;margin-top:15px;width:110px;height:45px;" onblur="validate('showTime', 'showTime')">
	  			<% List<String> shows = (List<String>)request.getAttribute("shows"); 
	  				if(shows != null) {
	  					for(String show : shows){
	  			%>
	  			<option value="<% out.print(show); %>"><% out.print(show); %></option>
	  			<%		} 
	  				} %>
	  			</select>
	  			<span class="errorMessage" style="clear:both; margin-top:20px; line-width:15px"></span>
	  		</label>
  		</div>
  		
  		<div style="margin-left:430px;">
  			<label>
	  			<span>Half Ticket Count</span>
	  			<input type="number" id="halfTicket" name="halfTicket" value="0" style="width:50px" onblur="validate('halfTicket','number')"/>
	  			<span class="errorMessage" style="clear:both; margin-top:20px; line-width:15px"></span>
	  		</label>
  		</div>
  		
  		<div style="margin-left:660px;">
  			<label>
	  			<span>Ticket count</span>
	  			<span style="clear:both; margin-top:30px;font-size:30px;" id="seatCounter">0</span>
	  			<input hidden="true" id="seatSelection" name="seatSelection" value="" style="display:none;"/>
	  			<input hidden="true" id="seatCount" name="seatCount" value="0" style="display:none;"/>
	  			<span class="errorMessage" style="clear:both; margin-top:20px; line-width:15px"></span>
	  		</label>
  		</div>
  		
  		<div style="margin-left:830px;margin-top:20px">
  			<c:choose>
  				<c:when test="${sessionScope['type'] == 'admin'}">
  					<button class="submit button" type="button" onclick="btnPrintOnClick()" taret="_blank">Sale</button>
  				</c:when>
  				<c:otherwise>
  					<button class="submit button" type="button" onclick="btnBuyOnClick()">Buy</button>
  				</c:otherwise>
  			</c:choose>
  		</div>
  	</form>
</div>

<div class="clr"></div>

<div class="seatingArrangement" align="center" style="width:920px; height:620px;">
  <div style="width:920px;">
  	<div class="tLegend">
  		<span>Legend</span>
  		<div style="margin:10px 5px 5px 5px;">
  			<img src="images/blankSeat_small.png"/>
  			<span>- Empty seats</span>
  		</div>
  		<div style="margin:25px 5px 5px 5px;">
  			<img src="images/selected_small.png"/>
  			<span> - Selected seats</span>
  		</div>
  		<div style="margin:25px 5px 5px 5px;">
  			<img src="images/reserved_small.png"/>
  			<span> - Reserved seats</span>
  		</div>
  	</div>  
  
 	<div class="tLegend" style="float: left;height: 100px;padding: 10px;width: 180px;">
  		<script type="text/javascript" src="js/countdown.js"></script>
  		<script type="application/javascript">
	  		var myCountdown2 = new Countdown({
				time: 120, 
				width:170, 
				height:100, 
				onComplete	: countDownOnComplete,
				rangeHi:"minute"	// <- no comma on last item!
				});
	  		
	  		function countDownOnComplete(){
	  			cleanSeatsFromServer();	
	  			cleanSeats();
	  			seatListner();
	  			getBookedSeats();
	  		}
  		</script>
  	</div>
  
  	<div class="theater">
  	<div style="width:354px;height:224px;padding:8px 2px 6px 12px;">
  		<c:if test="${requestScope['youtubeUrl'] != 'NAN'}">
  			<iframe width="354" height="250" src="//${requestScope['youtubeUrl']}?autoplay=1&fmt=17&controls=0&iv_load_policy=3" frameborder="0" allowfullscreen></iframe>
  		</c:if>  		
  	</div>	
  	</div>
  	
    <table border="0" cellspacing="3" cellpadding="3" class="plan" style="float:left;margin-left:225px;">
      <tr>
        <td id="E10">E10</td>
        <td id="E9">E9</td>
        <td id="E8">E8</td>
        <td id="E7">E7</td>
        <td id="E6">E6</td>
      </tr>
      <tr>
        <td id="D10">D10</td>
        <td id="D9">D9</td>
        <td id="D8">D8</td>
        <td id="D7">D7</td>
        <td id="D6">D6</td>
      </tr>
      <tr>
        <td id="C10">C10</td>
        <td id="C9">C9</td>
        <td id="C8">C8</td>
        <td id="C7">C7</td>
        <td id="C6">C6</td>
      </tr>
      <tr>
        <td id="B10">B10</td>
        <td id="B9">B9</td>
        <td id="B8">B8</td>
        <td id="B7">B7</td>
        <td id="B6">B6</td>
      </tr>
      <tr>
        <td id="A10">A10</td>
        <td id="A9">A9</td>
        <td id="A8">A8</td>
        <td id="A7">A7</td>
        <td id="A6">A6</td>
      </tr>
    </table>
    <table border="0" cellspacing="3" cellpadding="3" class="plan" style="margin-left:35px; float:left;">
      <tr>
        <td id="E5">E5</td>
        <td id="E4">E4</td>
        <td id="E3">E3</td>
        <td id="E2">E2</td>
        <td id="E1">E1</td>
      </tr>
      <tr>
        <td id="D5">D5</td>
        <td id="D4">D4</td>
        <td id="D3">D3</td>
        <td id="D2">D2</td>
        <td id="D1">D1</td>
      </tr>
      <tr>
        <td id="C5">C5</td>
        <td id="C4">C4</td>
        <td id="C3">C3</td>
        <td id="C2">C2</td>
        <td id="C1">C1</td>
      </tr>
      <tr>
        <td id="B5">B5</td>
        <td id="B4">B4</td>
        <td id="B3">B3</td>
        <td id="B21">B2</td>
        <td id="B1">B1</td>
      </tr>
      <tr>
        <td id="A5">A5</td>
        <td id="A4">A4</td>
        <td id="A3">A3</td>
        <td id="A2">A2</td>
        <td id="A1">A1</td>
      </tr>	
    </table>
  </div>
  
</div>

</div>

<%@ include file="movieFooter.jsp"%>