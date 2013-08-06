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

<%@include file="movieJsCommon.jsp" %>

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
  			<c:choose>
  				<c:when test="${sessionScope['type'] == 'admin'}">
  					<button class="submit button" type="button" onclick="btnPrintOnClick()">Sale</button>
  				</c:when>
  				<c:otherwise>
  					<button class="submit button" type="button" onclick="btnBuyOnClick()">Buy</button>
  				</c:otherwise>
  			</c:choose>
  		</div>
  	</form>
</div>

<div class="clr"></div>

<div class="seatingArrangement" align="center" style="width:920px; height:720px;">
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
  
  	<div class="theater">
  	<div style="width:354px;height:224px;padding:8px 2px 6px 12px;">
  		<iframe width="354" height="250" src="//${requestScope['youtubeUrl'] }?autoplay=1&fmt=17&controls=0&iv_load_policy=3" frameborder="0" allowfullscreen></iframe>
  	</div>
  	</div>
    <table border="0" cellspacing="2" cellpadding="2" class="ultra_plan" style="float:left;">
      <tr>
         <td class="blank"></td>
         <td id="H23">H23</td>
         <td id="H22">H22</td>
         <td id="H21">H21</td>
         <td id="H20">H20</td>
         <td id="H19">H19</td>
         <td id="H18">H18</td>
         <td id="H17">H17</td>
         <td id="H16">H16</td>
         <td id="H15">H15</td>
         <td id="H14">H14</td>
         <td id="H13">H13</td>
      </tr>
      <tr>
         <td id="G24">G24</td>
         <td id="G23">G23</td>
         <td id="G22">G22</td>
         <td id="G21">G21</td>
         <td id="G20">G20</td>
         <td id="G19">G19</td>
         <td id="G18">G18</td>
         <td id="G17">G17</td>
         <td id="G16">G16</td>
         <td id="G15">G15</td>
         <td id="G14">G14</td>
         <td id="G13">G13</td>
      </tr>
      <tr>
         <td id="F24">F24</td>
         <td id="F23">F23</td>
         <td id="F22">F22</td>
         <td id="F21">F21</td>
         <td id="F20">F20</td>
         <td id="F19">F19</td>
         <td id="F18">F18</td>
         <td id="F17">F17</td>
         <td id="F16">F16</td>
         <td id="F15">F15</td>
         <td id="F14">F14</td>
         <td id="F13">F13</td>
      </tr>
      <tr>
        <td class="blank"></td>
         <td id="E23">E23</td>
         <td id="E22">E22</td>
         <td id="E21">E21</td>
         <td id="E20">E20</td>
         <td id="E19">E19</td>
         <td id="E18">E18</td>
         <td id="E17">E17</td>
         <td id="E16">E16</td>
         <td id="E15">E15</td>
         <td id="E14">E14</td>
         <td id="E13">E13</td>
      </tr>
      <tr>
         <td id="D24">D24</td>
         <td id="D23">D23</td>
         <td id="D22">D22</td>
         <td id="D21">D21</td>
         <td id="D20">D20</td>
         <td id="D19">D19</td>
         <td id="D18">D18</td>
         <td id="D17">D17</td>
         <td id="D16">D16</td>
         <td id="D15">D15</td>
         <td id="D14">D14</td>
         <td id="D13">D13</td>
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
         <td id="B23">B23</td>
         <td id="B22">B22</td>
         <td id="B21">B21</td>
         <td id="B20">B20</td>
         <td id="B19">B19</td>
         <td id="B18">B18</td>
         <td id="B17">B17</td>
         <td id="B16">B16</td>
         <td id="B15">B15</td>
         <td id="B14">B14</td>
         <td id="B13">B13</td>
      </tr>
      <tr>
        <td class="blank"></td>
         <td id="A23">A23</td>
         <td id="A22">A22</td>
         <td id="A21">A21</td>
         <td id="A20">A20</td>
         <td id="A19">A19</td>
         <td id="A18">A18</td>
         <td id="A17">A17</td>
         <td id="A16">A16</td>
         <td id="A15">A15</td>
        <td class="blank"></td>
        <td class="blank"></td>
      </tr>
    </table>
    <table border="0" cellspacing="2" cellpadding="2" class="ultra_plan" style="float:left; margin-left:10px;">
      <tr>
         <td id="H12">H12</td>
         <td id="H11">H11</td>
         <td id="H10">H10</td>
         <td id="H9">H9</td>
         <td id="H8">H8</td>
         <td id="H7">H7</td>
         <td id="H6">H6</td>
         <td id="H5">H5</td>
         <td id="H4">H4</td>
         <td id="H3">H3</td>
         <td id="H2">H2</td>
         <td id="H1">H1</td>
      </tr>
      <tr>
         <td id="G12">G12</td>
         <td id="G11">G11</td>
         <td id="G10">G10</td>
         <td id="G9">G9</td>
         <td id="G8">G8</td>
         <td id="G7">G7</td>
         <td id="G6">G6</td>
         <td id="G5">G5</td>
         <td id="G4">G4</td>
         <td id="G3">G3</td>
         <td id="G2">G2</td>
         <td id="G1">G1</td>
      </tr>
      <tr>
         <td id="F12">F12</td>
         <td id="F11">F11</td>
         <td id="F10">F10</td>
         <td id="F9">F9</td>
         <td id="F8">F8</td>
         <td id="F7">F7</td>
         <td id="F6">F6</td>
         <td id="F5">F5</td>
         <td id="F4">F4</td>
         <td id="F3">F3</td>
         <td id="F2">F2</td>
         <td id="F1">F1</td>
      </tr>
      <tr>
         <td id="E12">E12</td>
         <td id="E11">E11</td>
         <td id="E10">E10</td>
         <td id="E9">E9</td>
         <td id="E8">E8</td>
         <td id="E7">E7</td>
         <td id="E6">E6</td>
         <td id="E5">E5</td>
         <td id="E4">E4</td>
         <td id="E3">E3</td>
         <td id="E2">E2</td>
         <td id="E1">E1</td>
      </tr>
      <tr>
         <td id="D12">D12</td>
         <td id="D11">D11</td>
         <td id="D10">D10</td>
         <td id="D9">D9</td>
         <td id="D7">D8</td>
         <td id="D7">D7</td>
         <td id="D6">D6</td>
         <td id="D5">D5</td>
         <td id="D4">D4</td>
         <td id="D3">D3</td>
         <td id="D2">D2</td>
         <td id="D1">D1</td>
      </tr>
      <tr>
         <td id="C12">C12</td>
         <td id="C11">C11</td>
         <td id="C10">C10</td>
         <td id="C9">C9</td>
         <td id="C8">C8</td>
         <td id="C7">C7</td>
         <td id="C6">C6</td>
         <td id="C5">C5</td>
         <td id="C4">C4</td>
         <td id="C3">C3</td>
         <td id="C2">C2</td>
         <td id="C1">C1</td>
      </tr>
      <tr>
         <td id="B12">B12</td>
         <td id="B11">B11</td>
         <td id="B10">B10</td>
         <td id="B9">B9</td>
        <td colspan="8" rowspan="2" class="blank"></td>
        </tr>
      <tr>
         <td id="A12">A12</td>
         <td id="A11">A11</td>
         <td id="A10">A10</td>
         <td id="A9">A9</td>
      </tr>
    </table>
  </div>
  
</div>

</div>

<%@ include file="movieFooter.jsp"%>