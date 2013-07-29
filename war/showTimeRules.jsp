<script>
function getShowTimesForUpdate() {
	var hallName = $("#hallforRule :selected").val();
	var checkURL = getURLPath() + "mvdtli.do?type=showTimes&hallId=" + hallName;
	if(validate('hallforRule','any')){
		$("#showTimeforRule").html("");
		
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
					$("#showTimeforRule").html(option);
				}
			}
		});	
	}
}

function getDailySchedule(){
	var hallName = $("#hallforRule :selected").val();
	var show = $("#showTimeforRule :selected").val();
	var checkURL = getURLPath() + "mvdtli.do?type=showSchedule&hallId=" + hallName + "&show=" + show;
	
	if(validate('showTimeforRule','any')){
		
		$.ajax({
			url:checkURL,
			async:false,
			type : "GET",
			success: function(data,status){
				if(data != "false"){
					var showTimes = data.split(";");
					var i=0;
					$("#ruleSunday").val(showTimes[i++]);
					$("#ruleMonday").val(showTimes[i++]);
					$("#ruleTuesday").val(showTimes[i++]);
					$("#ruleWednesday").val(showTimes[i++]);
					$("#ruleThursday").val(showTimes[i++]);
					$("#ruleFriday").val(showTimes[i++]);
					$("#ruleSaturday").val(showTimes[i++]);
				}
			}
		});	
	}
}

function validateWeeklyTime(id){	
	var value = $("#" + id).val();
	var result = false;
	var message = "";
	
	if(!isEmpty(value)){
		var re = /^(0?[1-9]|1[012])(:[0-5]\d) [APap][mM]$/;
		result = re.test(value);
		message = "Enter a valid time (Eg. 10:30 PM)";
	} else {
		message = "This field should not be empty";
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
</script>

<div id="showTimeRules">
		<div class="labelDetails" style=" margin-top:145px">
			<div>
				<fieldset class="textbox">
					<lable><span>Hall</span></lable>
					<lable><span>Show Number</span></lable>
					<lable><span>Sunday</span></lable>
					<lable><span>Monday</span></lable>
					<lable><span>Tuesday</span></lable>
					<lable><span>Wednesday</span></lable>
					<lable><span>Thursday</span></lable>
					<lable><span>Friday</span></lable>
					<lable><span>Saturday</span></lable>
				</fieldset>
			</div>
		</div>
		
		<div class="devider" style="height:520px; margin-top:210px"></div>
		
		<div class="userDetailsCommon" style="margin-top:160px">
		<form action="/mvtimeup.do" id="showTimeRuleForm" method="post">
			<label> 
				<select name="hallforRule" id="hallforRule" style="margin-top:25px; float:left; clear:left; width:150px; height:45px;" class="styled-select" onblur="getShowTimesForUpdate();">
				<option value=""></option>
				<% 	String [] hallsForRule = (String[])request.getAttribute("hallNames"); 
					for(String hall:hallsForRule){
				%>
					<option value="<%=hall %>"><%=hall %></option>
				<%	} %>
				</select>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			<label> 
				<select name="showTimeforRule" id="showTimeforRule" onblur="getDailySchedule()" style="margin-top:25px; float:left; clear:left; width:150px; height:45px;" class="styled-select">
				
				</select>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleSunday" size="12" name="ruleSunday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateWeeklyTime('ruleSunday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label> 
			
			<label>
				<input type="text"  id="ruleMonday" size="12" name="ruleMonday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateWeeklyTime('ruleMonday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleTuesday" size="12" name="ruleTuesday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateWeeklyTime('ruleTuesday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleWednesday" size="12" name="ruleWednesday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateWeeklyTime('ruleWednesday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleThursday" size="12" name="ruleThursday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateWeeklyTime('ruleThursday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleFriday" size="12" name="ruleFriday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateWeeklyTime('ruleFriday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleSaturday" size="12" name="ruleSaturday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateWeeklyTime('ruleSaturday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			<label>
				<button class="submit button" type="button" onclick="btnUpdateOnClick('showRules')" style="margin-top:25px;">Update</button>
			</label>
		</form>
	</div>
</div>