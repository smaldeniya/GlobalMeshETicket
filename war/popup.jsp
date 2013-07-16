<script type="text/javascript">
	$(document).ready(function() {
		$('#loginButton').click(function() {

			//Getting the variable's value from a link 
			var loginBox = $(this).attr('href');

			//Fade in the Popup
			$(loginBox).fadeIn(300);

			//Set the center alignment padding + border see css style
			var popMargTop = ($(loginBox).height() + 24) / 2;
			var popMargLeft = ($(loginBox).width() + 24) / 2;

			$(loginBox).css({
				'margin-top' : -popMargTop,
				'margin-left' : -popMargLeft
			});

			// Add the mask to body
			$('body').append('<div id="mask"></div>');
			$('#mask').fadeIn(300);

			return false;
		});
		
		$('#registerButton').click(function() {
			
			//Getting the variable's value from a link 
			var loginBox = $(this).attr('href');

			//Fade in the Popup
			$(loginBox).fadeIn(300);

			//Set the center alignment padding + border see css style
			var popMargTop = ($(loginBox).height() + 24) / 2;
			var popMargLeft = ($(loginBox).width() + 24) / 2;

			$(loginBox).css({
				'margin-top' : -popMargTop,
				'margin-left' : -popMargLeft
			});

			// Add the mask to body
			$('body').append('<div id="mask"></div>');
			$('#mask').fadeIn(300);

			return false;
		});

		// When clicking on the button close or the mask layer the popup closed
		$('a.close, #mask').live('click', function() {
			$('#mask , .login-popup').fadeOut(300, function() {
				$('#mask').remove();
			});
			return false;
		});
	});
	
	function loginOnClick() {
		alert("login");
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
	
	function registerOnClick(){
		if(validate('email','email') && validate('regpassword','password') && retypePasswordValidate('regpassword','repassword')
				&& validate('firstName','text') && validate('lastName','text') && validate('nic','nic') && validate('mobile','mobile') && validate('gender','gender')) {
			$("#registerForm").attr("action", "/reset.do");
			
			$('#mask , .login-popup').fadeOut(300, function() {
				$('#mask').remove();
			});
			
			$("form")[1].submit();
			
		}
	}
</script>

<div id="login-box" class="login-popup">
	<a href="#" class="close"><img src="images/close_pop.png"
		class="btn_close" title="Close Window" alt="Close" /></a>
	<form method="post" class="signin" action="#">
		<fieldset class="textbox">
			<label class="username"> <span>Username or email</span> <input
				id="username" name="username" value="" type="text" />
			</label> <label class="password"> <span>Password</span> <input
				id="password" name="password" value="" type="password" />
			</label>
			<button class="submit button" type="button" onclick="loginOnClick()">Sign in</button>
			<p class="forgot">
				<a href="resetPassword.jsp">Forgot your password?</a>
			</p>
		</fieldset>
	</form>
</div>


<div id="register-box" class="login-popup" style="width: 650px; height:580px;">
	<a href="#" class="close"><img src="images/close_pop.png"
		class="btn_close" title="Close Window" alt="Close" /></a>
	<form method="post" class="signin" action="/reset.do" id="registerForm">
		<fieldset class="textbox">
			<label class="username" style="float:left; width:250px; clear:both" > <span>Email</span> <input
				id="email" name="email" value="" type="text" style="width: 218px; height: 18px;" onblur="validate('email','email')" /> <span
						class="errorMessage"></span>
			</label>
			<label class="username" style="float:left; width:200px; clear:left; margin-right: 50px;" > <span>Password</span> <input
				id="regpassword" name="password" value="" type="password" style="width: 150px; height: 18px;" onblur="validate('regpassword','password')"/> <span
						class="errorMessage"></span>
			</label>
			<label class="username" style="float:left; width:200px; clear:right" > <span>Retype Password</span> <input
				id="repassword" name="repassword" value="" type="password" style="width: 150px; height: 18px;" onblur="retypePasswordValidate('regpassword','repassword')" /> <span
						class="errorMessage"></span>
			</label>
			<label class="username" style="float:left; width:250px; clear:left;"> <span>First Name</span> <input
				id="firstName" name="firstName" value="" type="text" style="width:150px; height: 18px;" onblur="validate('firstName','text')" />
				<span class="errorMessage"></span>
			</label> <label class="username" style="float:left; width:200px; clear:right" > <span>Last Name</span> <input
				id="lastName" name="lastName" value="" type="text" style="width: 250px; height: 18px;" onblur="validate('lastName','text')" /> <span
						class="errorMessage"></span>
			</label>
			<label class="username" style="float:left; width:200px; clear:left; margin-right: 18px;" > <span>NIC Number</span> <input
				id="nic" name="nic" value="" type="text" style="width: 128px; height: 18px;" maxlength="10" onblur="validate('nic','nic')"/> <span
						class="errorMessage"></span>
			</label>
			<label class="username" style="float:left; width:200px; clear:right;" > <span>Mobile Number</span> <input
				id="mobile" name="mobile" value="" type="text" style="width: 128px; height: 18px;" maxlength="10" onblur="validate('mobile','mobile')"/> <span
						class="errorMessage"></span>
			</label>
			<label class="username" style="float:left; width:60px; clear:right; margin-left: 18px;" > 
			<span>Gender</span> 
			<select id="gender" class="styled-select" style="font-size:17px" onblur="validate('gender','gender')">
				<option value="M" selected="selected">Male</option>
				<option value="F">Female</option>
			</select>
			<span class="errorMessage"></span>
			</label>
			<button class="submit button" type="button" onclick="registerOnClick()">Register</button>
		</fieldset>
	</form>
</div>