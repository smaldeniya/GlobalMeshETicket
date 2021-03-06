<div id="hallDetails">

<div class="infoMsg" style="margin-top:120px;">Only ${requestScope['freeHalls']} more halls can be added. Please note that after adding, halls can not be deleted. Only update is possible</div>

<div class="labelDetails">
	<div>
	<fieldset class="textbox">
		<lable ><span>Hall Name</span></lable>
		<lable ><span>Number Of Seats</span></lable>
		<lable ><span>ODC FULL Ticket Price</span></lable>
		<lable ><span>ODC HALF Ticket Price</span></lable>
		<lable ><span>3D</span></lable>	
		<label name="price3DLable" style="display: none;"><span>3D Price Addition</span></label>	
		<lable ><span>Front Page Banner</span></lable>
		<lable ><span>Seat Limit</span></lable>
		<lable ><span>Seat Plan URL</span></lable>
	</fieldset>
	</div>
</div>
<div class="devider" style="height:500px; margin-left:350px"></div>

<div class="userDetailsCommon" style="margin-left:400px;">
	<form action="/hallUnI.do" id="hallForm" method="post" enctype="multipart/form-data">
		<c:choose>
					<c:when test="${requestScope['freeHalls'] > 0 }">
						<label> <input type="text" value='' id="hallName"
							name="hallName" style="margin-top: 30px"
							onblur="validate('hallName', 'any')" /> <span
							class="errorMessage"
							style="float: left; margin-left: 5px; margin-top: 35px;"></span>
						</label>
					</c:when>
					
					<c:otherwise>
						<label>			
			<select name="hallName" id="hallName" onchange="getHallDetails()" style="margin-top:25px; float:left; clear:left; width:150px; height:45px;" class="styled-select">
				<option value=""></option>
				<% 	String [] hallNames = (String[])request.getAttribute("hallNames"); 
					for(String hall:hallNames){
				%>
					<option value="<%=hall %>"><%=hall %></option>
				<%	} %>
			</select>
					</label>
					</c:otherwise>
		</c:choose>
		<label>
			<input type="text" value='' id="noOfSeats" name="noOfSeats" style="margin-top:30px" onblur="validate('noOfSeats', 'number')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		
		<label>
			<input type="text" value='' id="odcTicketPrice" name="odcTicketPrice" style="margin-top:30px" onblur="validate('odcTicketPrice', 'number')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		
		<label>
			<input type="text" value='' id="odcHalfTicketPrice" name="odcHalfTicketPrice" style="margin-top:30px" onblur="validate('odcHalfTicketPrice', 'number')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		
		<label>
			<input type="checkbox" value='' onchange="is3DonClick()" id="is3D" name="is3D" class="css-checkbox" style="margin-top:20px" /> 
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		
		<label name="price3DLable" style="display: none;"> 
			<input type="text" value="0" id="priceAddition3D" name="priceAddition3D" style="margin-top:30px; width: 40px;" onblur="validate('priceAddition3D', 'number')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		
		<label>
			<input type="file" value='' id="filmBanner" name="filmBanner" style="margin-top:20px" onblur="validate('filmBanner', 'any')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		
		<label>
			<input type="text" value='' id="maxSeat" name="maxSeat" style="margin-top:20px" onblur="validate('maxSeat', 'number')"/>
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		
		<label>
			<input type="text" value='' id="hallUri" name="hallUri" style="margin-top:20px" />
			<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
		</label>
		
		<label>
			<button class="submit button" type="button" onclick="btnUpdateOnClick('hall')" style="margin-top:45px;margin-right:20px;position:relative;">Update Hall</button>
		</label>
			<c:if test="${requestScope['freeHalls'] > 0 }">
			<label>
				<button class="submit button" type="button" onclick="btnAddOnClick('hall')" style="margin-top:45px;position:relative;clear:none">New Hall</button>
			</label>
			</c:if>
			
		
	</form>
</div>
</div>
