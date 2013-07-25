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
					 $(this).val("Eg. 04:30 PM");
				 }
			})
		}
	});
		
	function btnAddOnClick(casePar) {
		switch(casePar) {			
			case "hall":
				$("#hallForm").attr("action", "/useru.do");
				$("form")[1].submit();
				break;
				
			case "user":
				$("#userUpdateForm").attr("action", "/useru.do");
				$("form")[2].submit();
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
				
			case "user":
				$("#userUpdateForm").attr("action", "/useru.do");
				$("form")[2].submit();
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
				$("#hallForm").attr("action", "/useru.do");
				$("form")[1].submit();
				break;
				
			case "user":
				$("#userUpdateForm").attr("action", "/useru.do");
				$("form")[2].submit();
				break;
				
			case "movie":
				$("#movieForm").attr("action", "/mvdtlung.do");
				$("form")[3].submit();
				break;
				
			case "report":
				$("#reportForm").attr("action", "/useru.do");
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
		var re = /^(0?[1-9]|1[012])(:[0-5]\d) [APap][mM]$/;
		var result = re.test(value);
		var message = "Enter a valid time (Eg. 10:30 PM)";
		
		if (!result) {
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

<div id="userForm" align="center" style="marigin-top:20px;height:940px;">

<div class="adminTabHeader">
<nav id="adminNavigateion">
	<ul>
		<li style="background-color:#ed1c24;"><a href="#movieDetails" onclick="shoTab('#movieDetails')">Movie Details</a></li>
		<li><a href="#hallDetails" onclick="shoTab('#hallDetails')">Hall Details</a></li>
		<li><a href="#changePassword" onclick="shoTab('#changePassword')">Admin Password</a></li>
		<li><a href="#userDetails" onclick="shoTab('#userDetails')">User Details</a></li>
		<li><a href="#reports" onclick="shoTab('#reports')">Reports</a></li>
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

<div id="hallDetails">
<div class="labelDetails">
	<div>
	<fieldset class="textbox">
		
	</fieldset>
	</div>
</div>
<div class="devider"></div>

<div class="userDetailsCommon">
	<form action="/useru.do" id="hallForm" method="post">
		
		
	</form>

</div>
</div>

<div id="userDetails">
		<div class="labelDetails"></div>
		<div class="devider"></div>

		<div class="userDetailsCommon">
			<form action="/useru.do" id="userUpdateForm" method="post">
				<label>
					<button class="submit button" type="button"	onclick="btnUpdateOnClick('report')" style="margin-top: 25px;">Block Users</button>
				</label>

			</form>

		</div>
</div>

<div id="movieDetails" style="display:block">
		<div class="labelDetails">
			<div>
				<fieldset class="textbox">
					<lable ><span>Film Name</span></lable>
					<lable ><span>Theater</span></lable>
					<lable ><span>Status</span></lable>
					<lable ><span>Youtube URL</span></lable>
					<lable ><span>Show Time 1</span></lable>
					<lable ><span>Show Time 2</span></lable>
					<lable ><span>Show Time 3</span></lable>
					<lable ><span>Show Time 4</span></lable>
					<lable ><span>Show Time 5</span></lable>
					<lable ><span>Description (Plot)</span></lable>
				</fieldset>
			</div>
		</div>
		
		<div class="devider" style="height:650px"></div>

		<div class="userDetailsCommon">
			<form action="/useru.do" id="movieForm" method="post">
				<label>
					<input type="text" value='' id="filmName" name="filmName" style="margin-top:30px" onblur="validate('filmName', 'any')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
		
				<label>			
					<select name="theater" id="theater" style="margin-top:25px; float:left; clear:left; width:230px; height:45px;" class="styled-select"> 
						<option value="" selected="selected">Select Theater</option> 
						<option value="${requestScope['Gold']}">${requestScope['Gold']}</option> 
						<option value="${requestScope['Ultra']}">${requestScope['Ultra']}</option> 
						<option value="${requestScope['Platinum']}">${requestScope['Platinum']}</option>
						<option value="${requestScope['Superior']}">${requestScope['Superior']}</option> 
					</select>
				</label>
				
				<label>			
					<select name="status" id="status" style="margin-top:25px; float:left; clear:left; width:230px; height:45px;" class="styled-select"> 
						<option value="" selected="selected">Select Status</option> 
						<option value="0">Now Showing</option> 
						<option value="1">Coming Soon</option> 
						<option value="2">Show Ended</option> 
					</select>
				</label>
				
				<label>
					<input type="text"  id="utube" size="12" name="utube" value='' style="margin-top:25px" onblur="validate('utube', 'utube')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime1" size="12" name="showtime1" value='Eg. 04:30 PM' style="margin-top:25px" onblur="validateShowTimes('showtime1')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime2" size="12" name="showtime2" value='Eg. 04:30 PM' style="margin-top:25px" onblur="validateShowTimes('showtime2')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime3" size="12" name="showtime3" value='Eg. 04:30 PM' style="margin-top:25px" onblur="validateShowTimes('showtime3')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime4" size="12" name="showtime4" value='Eg. 04:30 PM' style="margin-top:25px" onblur="validateShowTimes('showtime4')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime5" size="12" name="showtime5" value='Eg. 04:30 PM' style="margin-top:25px" onblur="validateShowTimes('showtime5')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<textarea rows="5" cols="20" id="plot" name="plot" style="margin-top:25px"></textarea>
				</label>
				
				<label>
					<button class="submit button" type="button" onclick="btnAddOnClick('movie')" style="margin-top:25px;margin-right:20px;position:relative;">Add Movie</button>
					<button class="submit button" type="button" onclick="btnUpdateOnClick('movie')" style="margin-top:25px;position:relative;clear:none">Update Movie</button>
					<button class="submit button" type="button" onclick="btnRemoveOnClick('movie')" style="margin-left:20px;margin-top:25px;position:relative;clear:none">Delete Movie</button>
				</label>
			</form>

		</div>
</div>

<div id="reports">
<div class="labelDetails">
	
</div>
<div class="devider"></div>

<div class="userDetailsCommon">
	<form action="/useru.do" id="reportForm" method="post">
		
		
		<label>
			<button class="submit button" type="button" onclick="btnUpdateOnClick('report')" style="margin-top:25px;">Update</button>
		</label>
		
	</form>

</div>
</div>

</div>

<%@include file="footer.jsp"%>