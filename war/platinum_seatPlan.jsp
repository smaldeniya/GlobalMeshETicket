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

<div class="seat_plan_header">Majestic cinema - Platinum</div>
<div class="clr"></div>

<div class="infoMsg" style="margin-bottom:10px;" id="beforClickMsg">Please select a date and time to proceed with ticket booking.</div>

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
  			<button class="submit button" type="button" onclick="btnBuyOnClick()">Buy</button>
  		</div>
  	</form>
</div>

<div class="clr"></div>

<div class="seatingArrangement" align="center" style="width:920px; height:870px;">
  <div style="width:920px;">
  	<div class="theater">
  	<div style="width:354px;height:224px;padding:8px 2px 6px 12px;">
  		<iframe width="354" height="250" src="//${requestScope['youtubeUrl'] }?autoplay=1&fmt=17&controls=0&iv_load_policy=3" frameborder="0" allowfullscreen></iframe>
  	</div>
  	</div>
    <table border="0" cellspacing="1" cellpadding="1" class="platinum_plan" style="float:left;">
    <tr>
      <td class="blank"></td>
      <td>P28</td>
      <td>P27</td>
      <td>P26</td>
      <td>P25</td>
      <td>P24</td>
      <td>P23</td>
    </tr>
    <tr>
      <td>O29</td>
      <td>O28</td>
      <td>O27</td>
      <td>O26</td>
      <td>O25</td>
      <td>O24</td>
      <td>O23</td>
    </tr>
    <tr>
      <td>N29</td>
      <td>N28</td>
      <td>N27</td>
      <td>N26</td>
      <td>N25</td>
      <td>N24</td>
      <td>N23</td>
    </tr>
    <tr>
      <td>M29</td>
      <td>M28</td>
      <td>M27</td>
      <td>M26</td>
      <td>M25</td>
      <td>M24</td>
      <td>M23</td>
    </tr>
    <tr>
      <td>L29</td>
      <td>L28</td>
      <td>L27</td>
      <td>L26</td>
      <td>L25</td>
      <td>L24</td>
      <td>L23</td>
    </tr>
    <tr>
      <td>K29</td>
      <td>K28</td>
      <td>K27</td>
      <td>K26</td>
      <td>K25</td>
      <td>K24</td>
      <td>K23</td>
    </tr>
    <tr>
      <td>J29</td>
      <td>J28</td>
      <td>J27</td>
      <td>J26</td>
      <td>J25</td>
      <td>J24</td>
      <td>J23</td>
    </tr>
    <tr>
      <td>I29</td>
      <td>I28</td>
      <td>I27</td>
      <td>I26</td>
      <td>I25</td>
      <td>I24</td>
      <td>I23</td>
    </tr>
    <tr>
      <td>H29</td>
      <td>H28</td>
      <td>H27</td>
      <td>H26</td>
      <td>H25</td>
      <td>H24</td>
      <td>H23</td>
    </tr>
    <tr>
      <td class="blank"></td>
      <td>G28</td>
      <td>G27</td>
      <td>G26</td>
      <td>G25</td>
      <td>G24</td>
      <td>G23</td>
    </tr>
    <tr>
      <td class="blank"></td>
      <td>F28</td>
      <td>F27</td>
      <td>F26</td>
      <td>F25</td>
      <td>F24</td>
      <td>F23</td>
    </tr>
    <tr>
      <td>E29</td>
      <td>E28</td>
      <td>E27</td>
      <td>E26</td>
      <td>E25</td>
      <td>E24</td>
      <td>E23</td>
    </tr>
    <tr>
      <td>D29</td>
      <td>D28</td>
      <td>D27</td>
      <td>D26</td>
      <td>D25</td>
      <td>D24</td>
      <td>D23</td>
    </tr>
    <tr>
      <td>C29</td>
      <td>C28</td>
      <td>C27</td>
      <td>C26</td>
      <td>C25</td>
      <td>C24</td>
      <td>C23</td>
    </tr>
    <tr>
      <td>B29</td>
      <td>B28</td>
      <td>B27</td>
      <td>B26</td>
      <td>B25</td>
      <td>B24</td>
      <td>B23</td>
    </tr>
    <tr>
      <td class="blank"></td>
      <td>A28</td>
      <td>A27</td>
      <td>A26</td>
      <td>A25</td>
      <td>A24</td>
      <td>A23</td>
    </tr>
  </table>
  <table border="0" cellspacing="1" cellpadding="1" class="platinum_plan" style="float:left; margin-left:10px;">
    <tr>
      <td>P22</td>
      <td>P21</td>
      <td>P20</td>
      <td>P19</td>
      <td>P18</td>
      <td>P17</td>
      <td>P16</td>
      <td>P15</td>
      <td>P14</td>
      <td>P13</td>
      <td>P12</td>
      <td>P11</td>
      <td>P10</td>
      <td>P9</td>
    </tr>
    <tr>
      <td>O22</td>
      <td>O21</td>
      <td>O20</td>
      <td>O19</td>
      <td>O18</td>
      <td>O17</td>
      <td>O16</td>
      <td>O15</td>
      <td>O14</td>
      <td>O13</td>
      <td>O12</td>
      <td>O11</td>
      <td>O10</td>
      <td>O9</td>
    </tr>
    <tr>
      <td>N22</td>
      <td>N21</td>
      <td>N20</td>
      <td>N19</td>
      <td>N18</td>
      <td>N17</td>
      <td>N16</td>
      <td>N15</td>
      <td>N14</td>
      <td>N13</td>
      <td>N12</td>
      <td>N11</td>
      <td>N10</td>
      <td>N9</td>
    </tr>
    <tr>
      <td>M22</td>
      <td>M21</td>
      <td>M20</td>
      <td>M19</td>
      <td>M18</td>
      <td>M17</td>
      <td>M16</td>
      <td>M15</td>
      <td>M14</td>
      <td>M13</td>
      <td>M12</td>
      <td>M11</td>
      <td>M10</td>
      <td>M9</td>
    </tr>
    <tr>
      <td>L22</td>
      <td>L21</td>
      <td>L20</td>
      <td>L19</td>
      <td>L18</td>
      <td>L17</td>
      <td>L16</td>
      <td>L15</td>
      <td>L14</td>
      <td>L13</td>
      <td>L12</td>
      <td>L11</td>
      <td>L10</td>
      <td>L9</td>
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
      <td>I22</td>
      <td>I21</td>
      <td>I20</td>
      <td>I19</td>
      <td>I18</td>
      <td>I17</td>
      <td>I16</td>
      <td>I15</td>
      <td>I14</td>
      <td>I13</td>
      <td>I12</td>
      <td>I11</td>
      <td>I10</td>
      <td>I9</td>
    </tr>
    <tr>
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
      <td>H12</td>
      <td>H11</td>
      <td>H10</td>
      <td>H9</td>
    </tr>
    <tr>
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
      <td>G12</td>
      <td>G11</td>
      <td>G10</td>
      <td>G9</td>
    </tr>
    <tr>
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
      <td>F12</td>
      <td>F11</td>
      <td>F10</td>
      <td>F9</td>
    </tr>
    <tr>
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
      <td>E12</td>
      <td>E11</td>
      <td>E10</td>
      <td>E9</td>
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
      <td>C22</td>
      <td>C21</td>
      <td>C20</td>
      <td>C19</td>
      <td>C18</td>
      <td>C17</td>
      <td>C16</td>
      <td>C15</td>
      <td>C14</td>
      <td>C13</td>
      <td>C12</td>
      <td>C11</td>
      <td>C10</td>
      <td>C9</td>
    </tr>
    <tr>
      <td>B22</td>
      <td class="blank"></td>
      <td>B20</td>
      <td>B19</td>
      <td>B18</td>
      <td>B17</td>
      <td>B16</td>
      <td>B15</td>
      <td>B14</td>
      <td>B13</td>
      <td>B12</td>
      <td>B11</td>
      <td class="blank"></td>
      <td class="blank"></td>
    </tr>
    <tr>
      <td>A22</td>
      <td class="blank"></td>
      <td>A20</td>
      <td>A19</td>
      <td>A18</td>
      <td>A17</td>
      <td>A16</td>
      <td>A15</td>
      <td>A14</td>
      <td>A13</td>
      <td>A12</td>
      <td>A11</td>
      <td>A10</td>
      <td class="blank"></td>
    </tr>
  </table>
  <table border="0" cellspacing="1" cellpadding="1" class="platinum_plan" style="float:left; margin-left:10px;">
    <tr>
      <td>P8</td>
      <td>P7</td>
      <td>P6</td>
      <td>P5</td>
      <td>P4</td>
      <td>P3</td>
      <td>P2</td>
      <td>P1</td>
    </tr>
    <tr>
      <td>O8</td>
      <td>O7</td>
      <td>O6</td>
      <td>O5</td>
      <td>O4</td>
      <td>O3</td>
      <td>O2</td>
      <td>O1</td>
    </tr>
    <tr>
      <td>N8</td>
      <td>N7</td>
      <td>N6</td>
      <td>N5</td>
      <td>N4</td>
      <td>N3</td>
      <td>N2</td>
      <td>N1</td>
    </tr>
    <tr>
      <td>M8</td>
      <td>M7</td>
      <td>M6</td>
      <td>M5</td>
      <td>M4</td>
      <td>M3</td>
      <td>M2</td>
      <td>M1</td>
    </tr>
    <tr>
      <td>L8</td>
      <td>L7</td>
      <td>L6</td>
      <td>L5</td>
      <td>L4</td>
      <td>L3</td>
      <td>L2</td>
      <td>L1</td>
    </tr>
    <tr>
      <td>K8</td>
      <td>K7</td>
      <td>K6</td>
      <td>K5</td>
      <td>K4</td>
      <td>K3</td>
      <td>K2</td>
      <td>K1</td>
    </tr>
    <tr>
      <td>J8</td>
      <td>J7</td>
      <td>J6</td>
      <td>J5</td>
      <td>J4</td>
      <td>J3</td>
      <td>J2</td>
      <td>J1</td>
    </tr>
    <tr>
      <td>I8</td>
      <td>I7</td>
      <td>I6</td>
      <td>I5</td>
      <td>I4</td>
      <td>I3</td>
      <td>I2</td>
      <td>I1</td>
    </tr>
    <tr>
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
      <td>G8</td>
      <td>G7</td>
      <td>G6</td>
      <td>G5</td>
      <td>G4</td>
      <td>G3</td>
      <td>G2</td>
      <td class="blank"></td>
    </tr>
    <tr>
      <td>F8</td>
      <td>F7</td>
      <td>F6</td>
      <td>F5</td>
      <td>F4</td>
      <td>F3</td>
      <td>F2</td>
      <td class="blank"></td>
    </tr>
    <tr>
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
      <td>B8</td>
      <td>B7</td>
      <td>B6</td>
      <td>B5</td>
      <td>B4</td>
      <td class="blank"></td>
      <td class="blank"></td>
      <td class="blank"></td>
    </tr>
    <tr>
      <td>A8</td>
      <td>A7</td>
      <td>A6</td>
      <td>A5</td>
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