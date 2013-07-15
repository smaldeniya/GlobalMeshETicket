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
			<button class="submit button" type="button">Sign in</button>
			<p class="forgot">
				<a href="resetPassword.jsp">Forgot your password?</a>
			</p>
		</fieldset>
	</form>
</div>

<div id="register-box" class="login-popup" style="width: 650px; height:600px;">
	<a href="#" class="close"><img src="images/close_pop.png"
		class="btn_close" title="Close Window" alt="Close" /></a>
	<form method="post" class="signin" action="#">
		<fieldset class="textbox">
			<label class="username" style="float:left; width:250px; clear:left;"> <span>First Name</span> <input
				id="firstName" name="firstName" value="" type="text" style="width:150px; height: 20px;"/>
				<span class="errorMessage">hello</span>
			</label> <label class="username" style="float:left; width:200px; clear:right" > <span>Last Name</span> <input
				id="lastName" name="lastName" value="" type="text" style="width: 250px; height: 20px;" /> <span
						class="errorMessage"></span>
			</label>
			<label class="username" style="float:left; width:250px; clear:left; margin-right: 10px;" > <span>Email</span> <input
				id="email" name="email" value="" type="text" style="width: 220px; height: 20px;" /> <span
						class="errorMessage"></span>
			</label>
			<label class="username" style="float:left; width:100px; margin-left: 60px;" > <span>Password</span> <input
				id="password" name="password" value="" type="password" style="width: 180px; height: 20px;" /> <span
						class="errorMessage"></span>
			</label>
			<button class="submit button" type="button">Register</button>
		</fieldset>
	</form>
</div>