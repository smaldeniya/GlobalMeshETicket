<%@include file="header_common.jsp"%>

<div class="clr"></div>
</div>
</div>

<div class="content">
	<div class="content_resize" style="height: 900px;">
		<div class="mainbar">
			<!-- do not need close  these three tags since it has been closed inside footer.jsp -->

			<div class="seat_plan_header"
				style="margin-left: auto; margin-right: auto; margin-top: 30px; margin-bottom: 80px;">Credit Card
				Details</div>
			<div class="clr"></div>

			<div class="payment-holder">
				<img src="images/secure.png" width="150px" height="150px" class="secureImg"/>
				
				<form action="vpc_jsp_serverhost_DO.jsp" method="post"
					class="signin" id="paymentForm" style="margin-top: 5px; position: absolute;">
					<table>
					<tr>
						<td></td>
						<td style="margin-left: auto; margin-right: auto; display: inline-block;">
							<span style="font-size: 14px; font-variant: small-caps; color: #545454;">User Account Details.</span>
							<hr width="40%"/>
						</td>					
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="emailLable" class="hasTip required"
									title="Enter your email address">Email Address :
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="email" id="email"
									class="validate-email required" id="jform_email1" value=""
									onblur="validate('email','regEmail')"
									<%-- regEmail is a validation type --%>
									size="30" />
								<span class="errorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="passwordLable" class="hasTip required"
									title="Enter your desired password - Password length should be between 6 to 20 and include atleast one lowercase and uppercase character and a number.">Password :</label>
							</div></td>
						<td><div class="reg_input">
								<input type="password" name="password" id="password" value=""
									autocomplete="off" class="validate-password required" size="30"
									onblur="validate('password','password')" /> <span
									class="errorMessage"></span>
							</div></td>
					</tr>
					<tr style="margin-top: 10px; margin-bottom: 20px;">
						<td></td>
						<td style="margin-left: auto; margin-right: auto; display: inline-block;">
							<span style="font-size: 14px; font-variant: small-caps; color: #545454;">Payment Details.</span>
							<hr width="40%"/>
						</td>					
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="NICLabel" class="hasTip required"
									title="Enter Your National Identity Card Number">National
									Identity Card No: 
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="NIC" id="NIC" value="" class="required"
									size="30" maxlength="10" onblur="validate('NIC','nic')" /> <span
									class="errorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="genderLable" class="hasTip required"
									title="Gender ::Please Select Your Gender">Gender :</label>
							</div></td>
						<td><div class="reg_input">
								<select id="gender" name="gender" class="required"
									onblur="validate('gender','gender')">
									<option value="M">Male</option>
									<option value="F">Female</option>
								</select> <span class="errorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label>Date of Birth :</label>
							</div></td>
						<td><div class="reg_input">
								<input type="date" id="birthday" name="birthday"
									onblur="validate('birthday','birthday')" /> <span
									class="small_text">(A person should be over 18 years of
									age at the date of registering)</span> <span class="errorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="addressLabel" class="hasTip required"
									title="Enter Your Address">Address: 
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="address" id="address"
									onblur="validate('address','any')" value="" class="required"
									size="30" /> <span class="errorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="cityLabel" class="hasTip required"
									title="Enter Your City">City : 
								</label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="city" id="city" value=""
									onblur="validate('city','text')" class="required" size="30" />
								<span class="errorMessage"></span>
							</div></td>
					</tr>
					<tr>
						<td><div class="reg_label">
								<label id="mobileLable" class="hasTip"
									title="Enter Your Mobile Number">Mobile : </label>
							</div></td>
						<td><div class="reg_input">
								<input type="text" name="mobile" id="mobile"
									onblur="validate('mobile','mobile')" value="" size="30"
									maxlength="12" /> <span class="errorMessage"></span>
							</div></td>
					</tr>					
					<tr>
						<td></td>
						<td><div id="register-button">
								<button class="submit button" type="button" id="registerButton"
									style="font-size: 14px;" onclick="registerOnClick()">Pay Now</button>
							</div></td>
					</tr>
				</table>
				</form>
			</div>

			<%@include file="footer.jsp"%>