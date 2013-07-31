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

		<div class="content">
			<div class="content_resize">
				<div class="mainbar">



<script type="text/javascript">
$(".seatingArrangement").ready(function (){
	
	$("#showDate").bind("blur",function() {
		cleanSeats();
		seatListner();
		if(validate('showDate','date')){
			getBookedSeats();
		} else {
			$(".seatingArrangement").children().find("table td").each(function (){
				$(this).unbind("click");
			});
		}
	});
	
	$("#showTime").bind("change",function() {
		cleanSeats();
		seatListner();
		getBookedSeats();
	});
	//function too change resered seats.
});

function btnBuyOnClick() {
	if(validate('showDate','date') && validate('showTime', 'showTime') && validate('halfTicket','number') && validate('seatCount', 'seatCount')){
		$("#filmBookForms").attr("action", "/book.do");
		$("form")[0].submit();
	}
}

function cleanSeats(){
	$(".seatingArrangement").children().find("table td").each(function (){
		if(!$(this).hasClass("blank") && !$(this).hasClass("ctmgmt") && !$(this).hasClass("sampath")) {
			$(this).removeAttr( 'style' );
			$(this).unbind("click");
			$("#seatCount").val("0");
			$("#seatCounter").text("0");
			$("#seatSelection").val("");
		}			
	});
}

function seatListner() {
		$(".seatingArrangement").children().find("table td").each(function (){
			
			if(!$(this).hasClass("blank") && !$(this).hasClass("ctmgmt") && !$(this).hasClass("sampath")) {
				$(this).click(function () {				
					if($(this).css("background-image").indexOf("selected_small.png") == -1){
						
						$(this).css("background-image", "url(../images/selected_small.png)");
						
						var seats = $("#seatSelection").val();
						if(isEmpty(seats)){
							seats = $(this).text();
						} else {
							seats = seats + ";" + $(this).text();
						}
						$("#seatSelection").val(seats);
						
						var seatCount = $("#seatCount").val();
						if(!isEmpty(seatCount)) {
							seatCount = parseInt(seatCount);
							seatCount += 1;
						} else {
							seatCount = 1;
						}
						$("#seatCount").val(seatCount);
						$("#seatCounter").text(seatCount);
						
					}else {
						$(this).removeAttr( 'style' );
						var removeVal = $(this).text();
						var seats = $("#seatSelection").val();
						var removeValIndex = seats.indexOf(removeVal);
						var lastIndexOfdel = seats.lastIndexOf(";")
						//if last index is greater than remov index then remove with ; else remove without ;
						if(lastIndexOfdel > removeValIndex) {
							removeVal = removeVal + ";";
						}
						
						$("#seatSelection").val(seats.replace(removeVal, ""));
						
						var seatCount = $("#seatCount").val();
						if(!isEmpty(seatCount)) {
							seatCount = parseInt(seatCount);
							if(seatCount >0){
								seatCount -= 1;
							}						
						}
						$("#seatCount").val(seatCount);
						$("#seatCounter").text(seatCount);
											
					}
				});
			}
			
		});			
}

function getBookedSeats() {
	
var showDate = $("#showDate").val();
	var showTime = $("#showTime").val();
	var hall = $("#hallName").val();

	var urlGet = getURLPath() + "getReserved.do";

	$.ajax({
		url : urlGet,
		async : false,
		type : "POST",
		data : {
			'showDate' : showDate,
			'showTime' : showTime,
			'hallName' : hall
		},
		success : function(data, status) {
			if (!isEmpty(data)) {
				var bookedSeats = data.split(";");
				for ( var i = 0; i < bookedSeats.length; i++) {
					$("#" + bookedSeats[i]).unbind("click");
					$("#" + bookedSeats[i]).css("background-image",
							"url(../images/reserved_small.png)");
				}
			}
		}
	});

}
</script>

<div align="center">

<div class="seat_plan_header">Majestic cinema - Gold</div>
<div class="clr"></div>

<div class="infoMsg" style="margin-bottom:10px;" id="beforClickMsg">Please select a date and time to proceed with ticket booking.</div>

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
  			<button class="submit button" type="button" onclick="btnBuyOnClick()">Buy</button>
  		</div>
  	</form>
</div>

<div class="clr"></div>

<div class="seatingArrangement" align="center" style="width:920px; height:620px;">
  <div style="width:920px;">
  	<div class="theater">
  	<div style="width:354px;height:224px;padding:8px 2px 6px 12px;">
  		<iframe width="354" height="250" src="//${requestScope['youtubeUrl']}?autoplay=1&fmt=17&controls=0&iv_load_policy=3" frameborder="0" allowfullscreen></iframe>
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