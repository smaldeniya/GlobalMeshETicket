<%@page import="com.globalmesh.dto.User"%>
<%@include file="header.jsp" %>
<script>
		
	function btnUpdateOnClick(casePar) {	
		switch(casePar) {
			case "password":
				$("#userUpdateForm").attr("action", "/useru.do");
				$("form")[0].submit();
				break;
				
			case "hall":
				$("#userUpdateForm").attr("action", "/useru.do");
				$("form")[1].submit();
				break;
				
			case "user":
				$("#userUpdateForm").attr("action", "/useru.do");
				$("form")[2].submit();
				break;
				
			case "movie":
				$("#userUpdateForm").attr("action", "/useru.do");
				$("form")[3].submit();
				break;
				
			case "report":
				$("#userUpdateForm").attr("action", "/useru.do");
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
</script>

<div class="seat_plan_header" align="center" style="width:95%;">Profile Details</div>

<div class="${requestScope['msgClass']}">${requestScope['message']}</div>

<div id="userForm" align="center" style="marigin-top:20px;">

<div class="adminTabHeader">
<nav id="adminNavigateion">
	<ul>
		<li><a href="#movieDetails" onclick="shoTab('#movieDetails')">Movie Details</a></li>
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
		<form action="/useru.do" id="userUpdateForm" method="post">
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
				onblur="validate('retypeNewPasswordU', 'password')" />
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
		<lable ><span>Email</span></lable>
	</fieldset>
	</div>
</div>
<div class="devider"></div>

<div class="userDetailsCommon">
	<form action="/useru.do" id="userUpdateForm" method="post">
		<label>
			<input type="hidden" id="emailU" name="emailU" value="" style="display:none;"/>
			<input type="text" value='' disabled="disabled" style="width:250px;margin-top:30px"/>
		</label>
		
		<label>
			<button class="submit button" type="button" onclick="btnUpdateOnClick('hall')" style="margin-top:25px;">Update</button>
		</label>
		
	</form>

</div>
</div>

<div id="movieDetails">
		<div class="labelDetails">
			<div>
				<fieldset class="textbox">
					<lable><span>Email</span></lable>
				</fieldset>
			</div>
		</div>
		
		<div class="devider"></div>

		<div class="userDetailsCommon">
			<form action="/useru.do" id="userUpdateForm" method="post">
				<label> <input type="hidden" id="emailU" name="emailU"
					value="" style="display: none;" /> <input type="text" value=''
					disabled="disabled" style="width: 250px; margin-top: 30px" />
				</label> <label>
					<button class="submit button" type="button"
						onclick="btnUpdateOnClick('movie')" style="margin-top: 25px;">Update</button>
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