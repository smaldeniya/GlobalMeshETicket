<%@page import="java.util.List"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@include file="header_common.jsp" %>

				<div class="slider">					
						<a href="#"><img src="/image.do?type=hall&hall=Platinum" width="960"
							height="360" alt="" /><span></span></a> 
					<div class="clr"></div>
				</div>
				<div class="clr"></div>
			</div>
		</div>

<%@include file="movieJsCommon.jsp" %>

<div class="seat_plan_header">Majestic cinema - Platinum</div>
<div class="clr"></div>

<div class="infoMsg" style="margin-bottom:10px;" id="beforClickMsg">Please select a date and time to proceed with ticket booking. Note that you have <b>2 minutes</b> to select a date & time, select the seats, and pay for the selected seats.</div>

<div id="ticketForm">
  	<form action="/book.do" method="post" id="filmBookForms" name="filmBookForms">
  		<input hidden="true" style="display:none" value="platinum" id="hallName" name="hallName"/>
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
		  			}	%>
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

<div class="seatingArrangement" align="center" style="width:920px; height:870px;">
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
    <table border="0" cellspacing="1" cellpadding="1" class="platinum_plan" style="float:left;">
    <tr>
      <td class="blank"></td>
      <td id="P28">P28</td>
      <td id="P27">P27</td>
      <td id="P26">P26</td>
      <td id="P25">P25</td>
      <td id="P24">P24</td>
      <td id="P23">P23</td>
    </tr>
    <tr>
      <td id="O29">O29</td>
      <td id="O2">O28</td>
      <td id="O27">O27</td>
      <td id="O26">O26</td>
      <td id="O25">O25</td>
      <td id="O24">O24</td>
      <td id="O23">O23</td>
    </tr>
    <tr>
      <td id="N29">N29</td>
      <td id="N28">N28</td>
      <td id="N27">N27</td>
      <td id="N26">N26</td>
      <td id="N25">N25</td>
      <td id="N24">N24</td>
      <td id="N23">N23</td>
    </tr>
    <tr>
      <td id="M29">M29</td>
      <td id="M28">M28</td>
      <td id="M27">M27</td>
      <td id="M26">M26</td>
      <td id="M25">M25</td>
      <td id="M24">M24</td>
      <td id="M23">M23</td>
    </tr>
    <tr>
      <td id="L2">L29</td>
      <td id="L28">L28</td>
      <td id="L27">L27</td>
      <td id="L26">L26</td>
      <td id="L25">L25</td>
      <td id="L24">L24</td>
      <td id="L23">L23</td>
    </tr>
    <tr>
      <td id="K29">K29</td>
      <td id="K28">K28</td>
      <td id="K27">K27</td>
      <td id="K26">K26</td>
      <td id="K25">K25</td>
      <td id="K24">K24</td>
      <td id="K23">K23</td>
    </tr>
    <tr>
      <td id="J29">J29</td>
      <td id="J28">J28</td>
      <td id="J27">J27</td>
      <td id="J26">J26</td>
      <td id="J25">J25</td>
      <td id="J24">J24</td>
      <td id="J23">J23</td>
    </tr>
    <tr>
      <td id="I29">I29</td>
      <td id="I28">I28</td>
      <td id="I27">I27</td>
      <td id="I26">I26</td>
      <td id="I25">I25</td>
      <td id="I24">I24</td>
      <td id="I23">I23</td>
    </tr>
    <tr>
      <td id="H29">H29</td>
      <td id="H28">H28</td>
      <td id="H27">H27</td>
      <td id="H26">H26</td>
      <td id="H25">H25</td>
      <td id="H24">H24</td>
      <td id="H23">H23</td>
    </tr>
    <tr>
      <td class="blank"></td>
      <td id="G28">G28</td>
      <td id="G27">G27</td>
      <td id="G26">G26</td>
      <td id="G25">G25</td>
      <td id="G24">G24</td>
      <td id="G23">G23</td>
    </tr>
    <tr>
      <td class="blank"></td>
      <td id="F28">F28</td>
      <td id="F27">F27</td>
      <td id="F26">F26</td>
      <td id="F25">F25</td>
      <td id="F24">F24</td>
      <td id="F23">F23</td>
    </tr>
    <tr>
      <td id="E29">E29</td>
      <td id="E28">E28</td>
      <td id="E27">E27</td>
      <td id="E26">E26</td>
      <td id="E25">E25</td>
      <td id="E24">E24</td>
      <td id="E23">E23</td>
    </tr>
    <tr>
      <td id="D29">D29</td>
      <td id="D28">D28</td>
      <td id="D27">D27</td>
      <td id="D26">D26</td>
      <td id="D25">D25</td>
      <td id="D24">D24</td>
      <td id="D23">D23</td>
    </tr>
    <tr>
      <td id="C29">C29</td>
      <td id="C28">C28</td>
      <td id="C27">C27</td>
      <td id="C26">C26</td>
      <td id="C25">C25</td>
      <td id="C24">C24</td>
      <td id="C23">C23</td>
    </tr>
    <tr>
      <td id="B29">B29</td>
      <td id="B28">B28</td>
      <td id="B27">B27</td>
      <td id="B26">B26</td>
      <td id="B25">B25</td>
      <td id="B24">B24</td>
      <td id="B23">B23</td>
    </tr>
    <tr>
      <td class="blank"></td>
      <td id="A28">A28</td>
      <td id="A27">A27</td>
      <td id="A26">A26</td>
      <td id="A25">A25</td>
      <td id="A24">A24</td>
      <td id="A23">A23</td>
    </tr>
  </table>
  <table border="0" cellspacing="1" cellpadding="1" class="platinum_plan" style="float:left; margin-left:10px;">
    <tr>
      <td id="P22">P22</td>
      <td id="P21">P21</td>
      <td id="P20">P20</td>
      <td id="P19">P19</td>
      <td id="P18">P18</td>
      <td id="P17">P17</td>
      <td id="P16">P16</td>
      <td id="P15">P15</td>
      <td id="P14">P14</td>
      <td id="P13">P13</td>
      <td id="P12">P12</td>
      <td id="P11">P11</td>
      <td id="P10">P10</td>
      <td id="P9">P9</td>
    </tr>
    <tr>
      <td id="O22">O22</td>
      <td id="O21">O21</td>
      <td id="O20">O20</td>
      <td id="O19">O19</td>
      <td id="O18">O18</td>
      <td id="O17">O17</td>
      <td id="O16">O16</td>
      <td id="O15">O15</td>
      <td id="O14">O14</td>
      <td id="O13">O13</td>
      <td id="O12">O12</td>
      <td id="O11">O11</td>
      <td id="O10">O10</td>
      <td id="O9">O9</td>
    </tr>
    <tr>
      <td id="N22">N22</td>
      <td id="N21">N21</td>
      <td id="N20">N20</td>
      <td id="N19">N19</td>
      <td id="N18">N18</td>
      <td id="N17">N17</td>
      <td id="N16">N16</td>
      <td id="N15">N15</td>
      <td id="N14">N14</td>
      <td id="N13">N13</td>
      <td id="N12">N12</td>
      <td id="N11">N11</td>
      <td id="N10">N10</td>
      <td id="N9">N9</td>
    </tr>
    <tr>
      <td id="M22">M22</td>
      <td id="M21">M21</td>
      <td id="M20">M20</td>
      <td id="M19">M19</td>
      <td id="M18">M18</td>
      <td id="M17">M17</td>
      <td id="M16">M16</td>
      <td id="M15">M15</td>
      <td id="M14">M14</td>
      <td id="M13">M13</td>
      <td id="M12">M12</td>
      <td id="M11">M11</td>
      <td id="M10">M10</td>
      <td id="M9">M9</td>
    </tr>
    <tr>
      <td id="L22">L22</td>
      <td id="L21">L21</td>
      <td id="L20">L20</td>
      <td id="L19">L19</td>
      <td id="L18">L18</td>
      <td id="L17">L17</td>
      <td id="L16">L16</td>
      <td id="L15">L15</td>
      <td id="L14">L14</td>
      <td id="L13">L13</td>
      <td id="L12">L12</td>
      <td id="L11">L11</td>
      <td id="L10">L10</td>
      <td id="L9">L9</td>
    </tr>
    <tr>
      <td class="sampath">K22</td>
      <td class="sampath">K21</td>
      <td class="sampath">K20</td>
      <td class="sampath">K19</td>
      <td class="sampath">K18</td>
      <td class="sampath">K17</td>
      <td class="sampath">K16</td>
      <td class="sampath">K15</td>
      <td class="sampath">K14</td>
      <td class="sampath">K13</td>
      <td class="sampath">K12</td>
      <td class="sampath">K11</td>
      <td class="sampath">K10</td>
      <td class="sampath">K9</td>
    </tr>
    <tr>
      <td class="sampath">J22</td>
      <td class="sampath">J21</td>
      <td class="sampath">J20</td>
      <td class="sampath">J19</td>
      <td class="sampath">J18</td>
      <td class="sampath">J17</td>
      <td class="sampath">J16</td>
      <td class="sampath">J15</td>
      <td class="sampath">J14</td>
      <td class="sampath">J13</td>
      <td class="sampath">J12</td>
      <td class="sampath">J11</td>
      <td class="sampath">J10</td>
      <td class="sampath">J9</td>
    </tr>
    <tr>
      <td id="I22">I22</td>
      <td id="I21">I21</td>
      <td id="I20">I20</td>
      <td id="I19">I19</td>
      <td id="I18">I18</td>
      <td id="I17">I17</td>
      <td id="I16">I16</td>
      <td id="I15">I15</td>
      <td id="I14">I14</td>
      <td id="I13">I13</td>
      <td id="I12">I12</td>
      <td id="I11">I11</td>
      <td id="I10">I10</td>
      <td id="I9">I9</td>
    </tr>
    <tr>
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
      <td id="H12">H12</td>
      <td id="H11">H11</td>
      <td id="H10">H10</td>
      <td id="H9">H9</td>
    </tr>
    <tr>
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
      <td id="G12">G12</td>
      <td id="G11">G11</td>
      <td id="G10">G10</td>
      <td id="G9">G9</td>
    </tr>
    <tr>
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
      <td id="F12">F12</td>
      <td id="F11">F11</td>
      <td id="F10">F10</td>
      <td id="F9">F9</td>
    </tr>
    <tr>
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
      <td id="E12">E12</td>
      <td id="E11">E11</td>
      <td id="E10">E10</td>
      <td id="E9">E9</td>
    </tr>
    <tr>
    <td class="ctmgmt">D22</td>
    <td class="ctmgmt">D21</td>
    <td class="ctmgmt">D20</td>
    <td class="ctmgmt">D19</td>
    <td class="ctmgmt">D18</td>
    <td class="ctmgmt">D17</td>
    <td class="ctmgmt">D16</td>
    <td class="ctmgmt">D15</td>
    <td class="ctmgmt">D14</td>
    <td class="ctmgmt">D13</td>
    <td class="ctmgmt">D12</td>
    <td class="ctmgmt">D11</td>
    <td class="ctmgmt">D10</td>
    <td class="ctmgmt">D9</td>
      </tr>
    <tr>
      <td id="C22">C22</td>
      <td id="C21">C21</td>
      <td id="C20">C20</td>
      <td id="C19">C19</td>
      <td id="C18">C18</td>
      <td id="C17">C17</td>
      <td id="C16">C16</td>
      <td id="C15">C15</td>
      <td id="C14">C14</td>
      <td id="C13">C13</td>
      <td id="C12">C12</td>
      <td id="C11">C11</td>
      <td id="C10">C10</td>
      <td id="C9">C9</td>
    </tr>
    <tr>
      <td id="">B22</td>
      <td class="blank"></td>
      <td id="B20">B20</td>
      <td id="B19">B19</td>
      <td id="B18">B18</td>
      <td id="B17">B17</td>
      <td id="B16">B16</td>
      <td id="B15">B15</td>
      <td id="B14">B14</td>
      <td id="B13">B13</td>
      <td id="B12">B12</td>
      <td id="B11">B11</td>
      <td class="blank"></td>
      <td class="blank"></td>
    </tr>
    <tr>
      <td id="">A22</td>
      <td class="blank"></td>
      <td id="A20">A20</td>
      <td id="A19">A19</td>
      <td id="A18">A18</td>
      <td id="A17">A17</td>
      <td id="A16">A16</td>
      <td id="A15">A15</td>
      <td id="A14">A14</td>
      <td id="A13">A13</td>
      <td id="A12">A12</td>
      <td id="A11">A11</td>
      <td id="A10">A10</td>
      <td class="blank"></td>
    </tr>
  </table>
  <table border="0" cellspacing="1" cellpadding="1" class="platinum_plan" style="float:left; margin-left:10px;">
    <tr>
      <td id="P8">P8</td>
      <td id="P7">P7</td>
      <td id="P6">P6</td>
      <td id="P5">P5</td>
      <td id="P4">P4</td>
      <td id="P3">P3</td>
      <td id="P2">P2</td>
      <td id="P1">P1</td>
    </tr>
    <tr>
      <td id="O8">O8</td>
      <td id="O7">O7</td>
      <td id="O6">O6</td>
      <td id="O5">O5</td>
      <td id="O4">O4</td>
      <td id="O3">O3</td>
      <td id="O2">O2</td>
      <td id="O1">O1</td>
    </tr>
    <tr>
      <td id="N8">N8</td>
      <td id="N7">N7</td>
      <td id="N6">N6</td>
      <td id="N5">N5</td>
      <td id="N4">N4</td>
      <td id="N3">N3</td>
      <td id="N2">N2</td>
      <td id="N1">N1</td>
    </tr>
    <tr>
      <td id="M8">M8</td>
      <td id="M7">M7</td>
      <td id="M6">M6</td>
      <td id="M5">M5</td>
      <td id="M4">M4</td>
      <td id="M3">M3</td>
      <td id="M2">M2</td>
      <td id="M1">M1</td>
    </tr>
    <tr>
      <td id="L8">L8</td>
      <td id="L7">L7</td>
      <td id="L6">L6</td>
      <td id="L5">L5</td>
      <td id="L4">L4</td>
      <td id="L3">L3</td>
      <td id="L2">L2</td>
      <td id="L1">L1</td>
    </tr>
    <tr>
      <td id="K8">K8</td>
      <td id="K7">K7</td>
      <td id="K6">K6</td>
      <td id="K5">K5</td>
      <td id="K4">K4</td>
      <td id="K3">K3</td>
      <td id="K2">K2</td>
      <td id="K1">K1</td>
    </tr>
    <tr>
      <td id="J8">J8</td>
      <td id="J7">J7</td>
      <td id="J6">J6</td>
      <td id="J5">J5</td>
      <td id="J4">J4</td>
      <td id="J3">J3</td>
      <td id="J2">J2</td>
      <td id="J1">J1</td>
    </tr>
    <tr>
      <td id="I8">I8</td>
      <td id="I7">I7</td>
      <td id="I6">I6</td>
      <td id="I5">I5</td>
      <td id="I4">I4</td>
      <td id="I3">I3</td>
      <td id="I2">I2</td>
      <td id="I1">I1</td>
    </tr>
    <tr>
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
      <td id="G8">G8</td>
      <td id="G7">G7</td>
      <td id="G6">G6</td>
      <td id="G5">G5</td>
      <td id="G4">G4</td>
      <td id="G3">G3</td>
      <td id="G2">G2</td>
      <td class="blank"></td>
    </tr>
    <tr>
      <td id="F8">F8</td>
      <td id="F7">F7</td>
      <td id="F6">F6</td>
      <td id="F5">F5</td>
      <td id="F4">F4</td>
      <td id="F3">F3</td>
      <td id="F2">F2</td>
      <td class="blank"></td>
    </tr>
    <tr>
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
      <td id="D8">D8</td>
      <td id="D7">D7</td>
      <td id="D5">D6</td>
      <td id="D5">D5</td>
      <td id="D4">D4</td>
      <td id="D3">D3</td>
      <td id="D2">D2</td>
      <td id="D1">D1</td>
    </tr>
    <tr>
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
      <td id="B8">B8</td>
      <td id="B7">B7</td>
      <td id="B6">B6</td>
      <td id="B5">B5</td>
      <td id="B4">B4</td>
      <td class="blank"></td>
      <td class="blank"></td>
      <td class="blank"></td>
    </tr>
    <tr>
      <td id="A8">A8</td>
      <td id="A7">A7</td>
      <td id="A6">A6</td>
      <td id="A5">A5</td>
      <td class="blank"></td>
      <td class="blank"></td>
      <td class="blank"></td>
      <td class="blank"></td>
    </tr>
  </table>
  </div>
  
</div>

</div>

<%@ include file="movieFooter.jsp"%>