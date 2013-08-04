<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.globalmesh.dto.User"%>
<%@include file="header.jsp" %>
<script>
		
	$("#movieDetails").ready(function () {
		var index = 1;
		for(index; index <6; index++){
			$("#showtime"+index).bind('focus', function (){
				 $(this).val("");				
			})
			
			$("#showtime"+index).bind('blur', function (){
				 var curText = $(this).val();
				 if(curText == ""){
					 $(this).val("Eg. 04:30 PM or NAN");
				 }
			})
		}
	});
		
	function btnAddOnClick(casePar) {
		switch(casePar) {			
			case "hall":
				$("#hallForm").attr("action", "/hallUnI.do");
				$("form")[1].submit();
				break;
				
			case "movie":
				if(validate('filmName', 'any') && validate('utube', 'utube') && validateShowTimes('showtime1') && validateShowTimes('showtime2') && validateShowTimes('showtime3')
						&& validateShowTimes('showtime4') && validateShowTimes('showtime5')){
					$("#movieForm").attr("action", "/mvdtli.do");
					$("form")[3].submit();
				}
				break;
				
			case "report":
				$("#reportForm").attr("action", "/useru.do");
				$("form")[4].submit();
				break;
		}
	}
	
	function btnRemoveOnClick(casePar) {
		switch(casePar) {			
			case "hall":
				$("#hallForm").attr("action", "/useru.do");
				$("form")[1].submit();
				break;
				
			case "movie":
				$("#movieForm").attr("action", "/mvdtld.do");
				$("form")[3].submit();
				break;
				
			case "report":
				$("#reportForm").attr("action", "/useru.do");
				$("form")[4].submit();
				break;
		}
	}
		
	function btnUpdateOnClick(casePar) {	
		switch(casePar) {
			case "password":
				if(validate('curPasswordU', 'password') && validate('newPasswordU', 'password') && retypePasswordValidate('newPasswordU', 'retypeNewPasswordU')){
					$("#passwordForm").attr("action", "/useru.do");
					$("form")[0].submit();
				}
				break;
				
			case "hall":
				$("#hallForm").attr("action", "/hallUnI.do");
				$("form")[1].submit();
				break;
				
			case "user":
				$("#userUpdateForm").attr("action", "/useru.do");
				$("form")[2].submit();
				break;
				
			case "movie":
				if(validate('filmName', 'any') && validate('utube', 'utube')) {
					$("#movieForm").attr("action", "/mvdtli.do");
					$("form")[3].submit();	
					$("#showtime1").parent().children("span[class=errorMessage]").text("Go to 'Show Times' tab to update movie times");
				}
				break;
				
			case "showRules":
				if(validate('hallforRule', 'any') && validate('showTimeforRule', 'number') && validateWeeklyTime('ruleSunday') && validateWeeklyTime('ruleMonday') && validateWeeklyTime('ruleTuesday') 
						&& validateWeeklyTime('ruleWednesday') && validateWeeklyTime('ruleThursday') && validateWeeklyTime('ruleFriday') && validateWeeklyTime('ruleSaturday')){
					$("#showTimeRuleForm").attr("action", "/mvtimeup.do");
					$("form")[5].submit();
				}
				break;
				
			case "report":
				$("#reportForm").attr("action", "/reportg.do");
				$("#reportForm").attr("target", "_blank");
				$("form")[4].submit();
				break;
		}
	}
	
	function retypePasswordValidate(password, retypePass){
		var result = false ;
		var message = "";
		var passValue = $("#" + password).val();
		var rePassValue = $("#" + retypePass).val();
		
		if(!isEmpty(rePassValue)){
			if(passValue === rePassValue) {
				result = true;
			} else {
				message = "Password should be match to re typed password";
			}
		} else {
			message = "Field should not be empty";
		}
		
		if(!result){
			$("#"+retypePass).parent().children("span[class=errorMessage]").text(message);
		} else {
			$("#"+retypePass).parent().children("span[class=errorMessage]").html("<img src='../images/ok.png' height='16' width='16'/>");
		}
		
		return result;
	}
	
	function shoTab(id) {
		$(id).css('display', 'block');

		$("#adminNavigateion li a").each(function () {
			var tabId = $(this).attr('href');
			if(tabId != id) {
				$(tabId).css('display', 'none');
				$(this).parent().css('background-color', '#fff');
			} else {
				$(this).parent().css('background-color', '#ed1c24');
			}
		});
	}
	
	function validateShowTimes(id){
		
		var value = $("#" + id).val();
		
		if(value == "NAN") {
			result = true;
		} else {
			var re = /^(0?[1-9]|1[012])(:[0-5]\d) [APap][mM]$/;
			var result = re.test(value);
			var message = "Enter a valid time (Eg. 10:30 PM) or NAN if no show at this time";
		}
		
		
		
		if (!result) {
			$("#" + id).parent().children("span[class=errorMessage]").text(
					message);
		} else {
			$("#" + id).parent().children("span[class=errorMessage]").html(
					"<img src='../images/ok.png' height='16' width='16'/>");
		}

		return result;
	}
	
	function is3DonClick() {
		if($("#is3D").is(":checked")){
			$("#is3D").val("3D")
		} else {
			$("#is3D").val("")
		}
	}
	
	function getHallDetails() {
		var hallName = $("#hallName :selected").val();
		var checkURL = getURLPath() + "hallG.do?hallId=" + hallName;
		
		$.ajax({
			url:checkURL,
			async:false,
			type : "GET",
			success: function(data,status){
				if(!isEmpty(data)){
					var values = data.split(";")
					$("#noOfSeats").val(values[0]);
					
					if(values[1] == "true") {
						$("#is3D").prop('checked', true);
					} else {
						$("#is3D").prop('checked', false);
					}
					$("#odcTicketPrice").val(values[2]);
					$("#odcHalfTicketPrice").val(values[3]);
				}
			}
		});
	}
	
	function checkHall() {
		var hallName = $("#theater :selected").val();
		var checkURL = getURLPath() + "mvdtli.do?type=hall&hallId=" + hallName;
		var returnVal = false;
		$.ajax({
			url:checkURL,
			async:false,
			type : "GET",
			success: function(data,status){
				if(data.toString() === "false"){
					$("#theater").parent().children("span[class=errorMessage]").text(
							"Another movie is showing in this hall at the moment. Please update it's status to 'Show Ended'");
				} else {
					$("#theater").parent().children("span[class=errorMessage]").html("<img src='../images/ok.png' height='16' width='16'/>");
					returnVal = true;
				}
			}
		});
		return returnVal;
	}
	
	function getMovieForUpdate() {
		var hallName = $("#theater :selected").val();
		var checkURL = getURLPath() + "mvdtli.do?type=update&hallId=" + hallName;
		
		$.ajax({
			url:checkURL,
			async:false,
			type : "GET",
			success: function(data,status){
				if(data != "false"){
					var dataArr = data.split(";");
					$("#filmName").val(dataArr[0]);
					$("#status").val("0"); 
					$("#utube").val(dataArr[2]);
					
					for(var i = 1; i < 6; i++) {
						$("#showtime"+i).parent().children("span[class=errorMessage]").text("Click 'Show Times' tab to change time of movie");
					}
					
					$("#plot").val(dataArr[dataArr.length - 1]);
					
					$("#theater").parent().children("span[class=errorMessage]").text("");
				}
			}
		});
	}
	
	function getShowTimesForReport() {
		var hallName = $("#reportHall :selected").val();
		var checkURL = getURLPath() + "mvdtli.do?type=showTimes&hallId=" + hallName;
		if(validate('reportHall','any')){
			$("#reportShow").html("");
			
			$.ajax({
				url:checkURL,
				async:false,
				type : "GET",
				success: function(data,status){
					if(data != "false"){
						var numOfShows = parseInt(data);
						var option = "";
						for(var i = 1; i <= numOfShows; i++){
							option = option + "<option value='"+ i + "'>Show " + i + "</option>";
						}
						$("#reportShow").html(option);
					}
				}
			});	
		}
	}
	
	function validateReportDate(id) {
		var message = "";
		var value = $("#" + id).val();
		var result = false;
		
		if(!isEmpty(value)) {
			var re = /\d{4}-\d{2}-\d{2}/;
			result = re.test(value);
			message = "Please enter a valid date. Eg: 2013-01-01";
		} else {
			message = "Field should not be empty";
		}
		
		if (!result) {
			$("#" + id).focus();
			$("#" + id).parent().children("span[class=errorMessage]").text(
					message);
		} else {
			$("#" + id).parent().children("span[class=errorMessage]").html(
					"<img src='../images/ok.png' height='16' width='16'/>");
		}

		return result;
		
	}
</script>

<div class="seat_plan_header" align="center" style="width:95%;">Profile Details</div>

<div class="${requestScope['msgClass']}">${requestScope['message']}</div>

<div id="userForm" align="center" style="marigin-top:20px;height:960px;">

<div class="adminTabHeader">
<nav id="adminNavigateion">
	<ul>
		<li style="background-color:#ed1c24;"><a href="#movieDetails" onclick="shoTab('#movieDetails');return false;">Movie Details</a></li>
		<li><a href="#showTimeRules" onclick="shoTab('#showTimeRules');return false;">Show Times</a></li>
		<li><a href="#changePassword" onclick="shoTab('#changePassword');return false;">Admin Password</a></li>
		<li><a href="#userDetails" onclick="shoTab('#userDetails');return false;">User Details</a></li>
		<li><a href="#reports" onclick="shoTab('#reports');return false;">Reports</a></li>
		<li><a href="#hallDetails" onclick="shoTab('#hallDetails');return false;">Hall Details</a></li>
	</ul>
</nav>
</div>

<div id="changePassword">
		<div class="labelDetails" style=" margin-top:145px">
			<div>
				<fieldset class="textbox">
					<lable>
					<span>Currunt Password</span></lable>
					<lable>
					<span>New Password</span></lable>
					<lable>
					<span>Retype Password</span></lable>
				</fieldset>
			</div>
		</div>
		
		<div class="devider" style="height:140px; margin-top:210px"></div>
		
		<div class="userDetailsCommon" style="margin-top:160px">
		<form action="/useru.do" id="passwordForm" method="post">
			<input type="hidden" id="emailU" name="emailU" value="" style="display: none;" />
			<input type="hidden" id="updatetype" name="updatetype" value="password" style="display: none;" />
			<label> 
				<input id="curPasswordU" name="curPasswordU" style="margin-top: 30px" type="password" onblur="validate('curPasswordU', 'password')"/>
			</label>
			<label> 
				<input type="password" id="newPasswordU" name="newPasswordU" style="margin-top: 28px" value="" onblur="validate('newPasswordU', 'password')" /> 
				<span class="errorMessage" style="float: left; margin-left: 5px; margin-top: 35px;"></span>
			</label>
			<label> 
				<input type="password" id="retypeNewPasswordU" name="retypeNewPasswordU" value="" style="margin-top: 25px"
				onblur="retypePasswordValidate('newPasswordU', 'retypeNewPasswordU')" />
				 <span class="errorMessage" style="float: left; margin-left: 5px; margin-top: 35px;"></span>
			</label>
			<label>
				<button class="submit button" type="button" onclick="btnUpdateOnClick('password')" style="margin-top:25px;">Update</button>
			</label>
		</form>
	</div>
</div>

<%@include file="hallDetailsAdder.jsp" %>

<div id="userDetails">
		<div class="labelDetails">
			<div>
				<fieldset class="textbox">
					<label><span>User Email</span></label>
					<label><span>Type</span></label>
				</fieldset>
			</div>
		</div>
		<div class="devider"></div>

		<div class="userDetailsCommon">
			<form action="/useru.do" id="userUpdateForm" method="post">
				<input type="text" name="updatetype" id="updatetype" value="userType" hidden="hidden" style="display:none"/>
				<label>
					<input type="text" onblur="validate('emailT', 'email')" id="emailT" name="emailT" value="" style="margin-top: 30px;width:250px;"/>
					<span class="errorMessage" style="float: left; margin-left: 5px; margin-top: 35px;"></span>
				</label>
				<label>
				</label>
					<select name="newType" id="newType" style="margin-top:25px; float:left; clear:left; width:150px; height:45px;" class="styled-select" >
						<option value="1">Admin</option>
						<option value="2">User</option>
					</select>
				<label>
					<button class="submit button" type="button"	onclick="btnUpdateOnClick('user')" style="margin-top: 25px;">Update Users</button>
				</label>

			</form>

		</div>
</div>
<%@include file="movieDetailsAdder.jsp" %>
<div id="reports">
<div class="labelDetails">
	<div>
		<fieldset class="textbox">
					<lable ><span>Theater</span></lable>
					<lable ><span>Sales Type</span></lable>
					<lable ><span>Show</span></lable>
					<lable ><span>From Date</span></lable>
					<lable ><span>To Date</span></lable>					
		</fieldset>
	</div>
</div>
<div class="devider" style="height:280px;"></div>

<div class="userDetailsCommon">
	<form action="/useru.do" id="reportForm" method="post">
		
		<label>			
			<select name="reportHall" id="reportHall" style="margin-top:30px; float:left; clear:left; width:230px; height:45px;" class="styled-select" onblur="getShowTimesForReport();"> 
				<option value="" selected="selected">Select Theater</option> 
				<% 	String[] rephallNames = (String[])request.getAttribute("hallNames"); 
					for(String hall:rephallNames){
				%>
					<option value="<%=hall %>"><%=hall %></option>
				<%	} %> 
			</select>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:40px; width:210px;"></span>
		</label>
	
		
		<label>			
			<select name="reqreportType" id="reqreportType" style="margin-top:20px; float:left; clear:left; width:230px; height:45px;" class="styled-select" >
				<option value="online" >Online Sales</option>
				<option value="offline" >Offline Sales</option>
				<option value="all" >All Sales</option>
			</select>
		</label>
		
		<label> 
			<select name="reportShow" id="reportShow" style="margin-top:25px; float:left; clear:left; width:150px; height:45px;" class="styled-select">
				
			</select>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		
		<label>
			<input type="date" id="reportFromDate" name="reportFromDate" onblur="validateReportDate('reportFromDate');" style="margin-top: 25px;"/>	
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:40px; width:210px;"></span>	
		</label>
		
		<label>
			<input type="date" id="reportToDate" name="reportToDate" onblur="validateReportDate('reportToDate');" style="margin-top: 25px;"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:40px; width:210px;"></span>
		</label>
		
		<label>
			<button class="submit button" type="button" onclick="btnUpdateOnClick('report')" style="margin-top:25px;">Request </button>
		</label>
		
	</form>

</div>
</div>


<%@include file="showTimeRules.jsp" %>

</div>

<%@include file="footer.jsp"%>