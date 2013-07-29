<script>
	
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
		<form action="/useru.do" id="showTimeRuleForm" method="post">
			<label> 
				<select name="hallforRule" id="hallforRule" onchange="getHallDetails()" style="margin-top:25px; float:left; clear:left; width:150px; height:45px;" class="styled-select">
				<% 	String [] hallsForRule = (String[])request.getAttribute("hallNames"); 
					for(String hall:hallsForRule){
				%>
					<option value="<%=hall %>"><%=hall %></option>
				<%	} %>
				</select>
			</label>
			<label> 
				<select name="showTimeforRule" id="showTimeforRule" onchange="getHallDetails()" style="margin-top:25px; float:left; clear:left; width:150px; height:45px;" class="styled-select">
				
				</select>
			</label>
			
			<label>
				<input type="text"  id="ruleSunday" size="12" name="ruleSunday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('ruleSunday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label> 
			
			<label>
				<input type="text"  id="ruleMonday" size="12" name="ruleMonday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('ruleMonday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleTuesday" size="12" name="ruleTuesday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('ruleTuesday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleWednesday" size="12" name="ruleWednesday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('ruleWednesday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleThursday" size="12" name="showtime2" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('ruleThursday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleFriday" size="12" name="ruleFriday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('ruleFriday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			
			<label>
				<input type="text"  id="ruleSaturday" size="12" name="ruleSaturday" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('ruleSaturday')"/>
				<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
			</label>
			<label>
				<button class="submit button" type="button" onclick="btnUpdateOnClick('showRules')" style="margin-top:25px;">Update</button>
			</label>
		</form>
	</div>
</div>