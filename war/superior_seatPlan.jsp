<%@page import="java.util.List"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@include file="header_common.jsp" %>

				<div class="slider">					
						<a href="#"><img src="/image.do?type=hall&hall=Superior" width="960"
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

<div class="seat_plan_header">Majestic cinema - Superior</div>
<div class="clr"></div>
<div class="infoMsg" style="margin-bottom:10px;" id="beforClickMsg">Please select a date and time to proceed with ticket booking.</div>

<div id="ticketForm">
  	<form action="/book.do" method="post" id="filmBookForms" name="filmBookForms">
  		<input hidden="true" style="display:none" value="superior" id="hallName" name="hallName"/>
  		<div style="margin-left:20px;">
  			<label>
	  			<span>Show Date</span>
	  			<input type="date" id="showDate" name="showDate" onblur="validate('showDate','date')"/>
	  			<span class="errorMessage" style="clear:both; margin-top:20px; line-width:15px"></span>
	  		</label>
  		</div>
  		
  		<div style="margin-left:260px">
  			<label>
	  			<span>Show Time</span>
	  			<select class="styled-select " id="showTime" name="showTime" style="font-size:18px;clear:both;margin-top:15px;width:110px;height:45px;" onblur="validate('showTime', 'showTime')">
	  			<%List<String> shows = (List<String>)request.getAttribute("shows"); 
	  				if(shows != null) {
	  					for(String show : shows){
	  			%>
	  			<option value="<% out.print(show); %>"><% out.print(show); %></option>
	  			<%		}
		  			}%>
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

<div class="seatingArrangement" align="center" style="width:920px; height:720px;">
  <div style="width:920px;">
  	<div class="theater">
  	<div style="width:354px;height:224px;padding:8px 2px 6px 12px;">
  		<iframe width="354" height="250" src="//${requestScope['youtubeUrl'] }?autoplay=1&fmt=17&controls=0&iv_load_policy=3" frameborder="0" allowfullscreen></iframe>
  	</div>
  	</div>
    <table border="0" cellspacing="2" cellpadding="2" class="ultra_plan" style="float:left;">
      <tr>
        <td class="blank"></td>
        <td>H23</td>
        <td>H22</td>
        <td>H21</td>
        <td>H20</td>
        <td>H19</td>
        <td>H18</td>
        <td>H17</td>
        <td>H16</td>
        <td>H15</td>
        <td>H14</td>
        <td>H13</td>
      </tr>
      <tr>
        <td>G24</td>
        <td>G23</td>
        <td>G22</td>
        <td>G21</td>
        <td>G20</td>
        <td>G19</td>
        <td>G18</td>
        <td>G17</td>
        <td>G16</td>
        <td>G15</td>
        <td>G14</td>
        <td>G13</td>
      </tr>
      <tr>
        <td>F24</td>
        <td>F23</td>
        <td>F22</td>
        <td>F21</td>
        <td>F20</td>
        <td>F19</td>
        <td>F18</td>
        <td>F17</td>
        <td>F16</td>
        <td>F15</td>
        <td>F14</td>
        <td>F13</td>
      </tr>
      <tr>
        <td class="blank"></td>
        <td>E23</td>
        <td>E22</td>
        <td>E21</td>
        <td>E20</td>
        <td>E19</td>
        <td>E18</td>
        <td>E17</td>
        <td>E16</td>
        <td>E15</td>
        <td>E14</td>
        <td>E13</td>
      </tr>
      <tr>
        <td>D24</td>
        <td>D23</td>
        <td>D22</td>
        <td>D21</td>
        <td>D20</td>
        <td>D19</td>
        <td>D18</td>
        <td>D17</td>
        <td>D16</td>
        <td>D15</td>
        <td>D14</td>
        <td>D13</td>
      </tr>
      <tr>
        <td class="ctmgmt">C24</td>
        <td class="ctmgmt">C23</td>
        <td class="ctmgmt">C22</td>
        <td class="ctmgmt">C21</td>
        <td class="ctmgmt">C20</td>
        <td class="ctmgmt">C19</td>
        <td class="ctmgmt">C18</td>
        <td class="ctmgmt">C17</td>
        <td class="ctmgmt">C16</td>
        <td class="ctmgmt">C15</td>
        <td class="ctmgmt">C14</td>
        <td class="ctmgmt">C13</td>
      </tr>
      <tr>
        <td class="blank"></td>
        <td>B23</td>
        <td>B22</td>
        <td>B21</td>
        <td>B20</td>
        <td>B19</td>
        <td>B18</td>
        <td>B17</td>
        <td>B16</td>
        <td>B15</td>
        <td>B14</td>
        <td>B13</td>
      </tr>
      <tr>
        <td class="blank"></td>
        <td>A23</td>
        <td>A22</td>
        <td>A21</td>
        <td>A20</td>
        <td>A19</td>
        <td>A18</td>
        <td>A17</td>
        <td>A16</td>
        <td>A15</td>
        <td class="blank"></td>
        <td class="blank"></td>
      </tr>
    </table>
    <table border="0" cellspacing="2" cellpadding="2" class="ultra_plan" style="float:left; margin-left:10px;">
      <tr>
        <td>H12</td>
        <td>H11</td>
        <td>H10</td>
        <td>H9</td>
        <td>H8</td>
        <td>H7</td>
        <td>H6</td>
        <td>H5</td>
        <td>H4</td>
        <td>H3</td>
        <td>H2</td>
        <td>H1</td>
      </tr>
      <tr>
        <td>G12</td>
        <td>G11</td>
        <td>G10</td>
        <td>G9</td>
        <td>G8</td>
        <td>G7</td>
        <td>G6</td>
        <td>G5</td>
        <td>G4</td>
        <td>G3</td>
        <td>G2</td>
        <td>G1</td>
      </tr>
      <tr>
        <td>F12</td>
        <td>F11</td>
        <td>F10</td>
        <td>F9</td>
        <td>F8</td>
        <td>F7</td>
        <td>F6</td>
        <td>F5</td>
        <td>F4</td>
        <td>F3</td>
        <td>F2</td>
        <td>F1</td>
      </tr>
      <tr>
        <td>E12</td>
        <td>E11</td>
        <td>E10</td>
        <td>E9</td>
        <td>E8</td>
        <td>E7</td>
        <td>E6</td>
        <td>E5</td>
        <td>E4</td>
        <td>E3</td>
        <td>E2</td>
        <td>E1</td>
      </tr>
      <tr>
        <td>D12</td>
        <td>D11</td>
        <td>D10</td>
        <td>D9</td>
        <td>D8</td>
        <td>D7</td>
        <td>D6</td>
        <td>D5</td>
        <td>D4</td>
        <td>D3</td>
        <td>D2</td>
        <td>D1</td>
      </tr>
      <tr>
        <td>C12</td>
        <td>C11</td>
        <td>C10</td>
        <td>C9</td>
        <td>C8</td>
        <td>C7</td>
        <td>C6</td>
        <td>C5</td>
        <td>C4</td>
        <td>C3</td>
        <td>C2</td>
        <td>C1</td>
      </tr>
      <tr>
        <td>B12</td>
        <td>B11</td>
        <td>B10</td>
        <td>B9</td>
        <td colspan="8" rowspan="2" class="blank"></td>
        </tr>
      <tr>
        <td>A12</td>
        <td>A11</td>
        <td>A10</td>
        <td>A9</td>
      </tr>
    </table>
  </div>
  
</div>

</div>

<%@ include file="movieFooter.jsp"%>