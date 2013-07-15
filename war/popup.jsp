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
				<a  href="resetPassword.jsp">Forgot your password?</a>
			</p>
		</fieldset>
	</form>
</div>