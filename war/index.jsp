<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>NoQueue</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/coin-slider.css" />
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/cufon-marketingscript.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/coin-slider.min.js"></script>

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
		$('#mask , .login-popup').fadeOut(300 , function() {
			$('#mask').remove();  
		}); 
		return false;	
	});
});
</script>

</head>

<body>
<div class="main">
  <div class="header">
    <div class="header_resize">      
      <div class="menu_nav">
        <div>
			<ul>
			  <li class="active"><a href="index.html"><span>Home Page</span></a></li>
			  <li><a href="movies.html"><span>Movie Details</span></a></li>
			  <li><a href="about.html"><span>About Us</span></a></li>
			  <li><a href="contact.html"><span>Contact Us</span></a></li>
			</ul>
		</div>
		<div class="login"> 
			<ul>
			  <li ><a href="#login-box" id="loginButton"><span>Login</span></a></li>
			  <li><a href="movies.html"><span>Register</span></a></li>
			</ul>
		</div>
      </div>
      <div class="clr"></div>
      <div class="logo">
        <h1><a href="index.html"><span>Creative</span>World <small>Company Slogan Here</small></a></h1>
      </div>
      <div class="clr"></div>
      <div class="slider">
        <div id="coin-slider">
        <a href="#"><img src="images/MC_Gold.jpg" width="960" height="360" alt="" /><span></span></a>
        <a href="#"><img src="images/MC_Platinum.jpg" width="960" height="360" alt="" /><span></span></a>
        <a href="#"><img src="images/MC_Superior.jpg" width="960" height="360" alt="" /><span></span></a> 
        <a href="#"><img src="images/MC_Ultra.jpg" width="960" height="360" alt="" /><span></span></a> 
        </div>
        <div class="clr"></div>
      </div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="content">  
    <div class="content_resize">
      <div class="mainbar">
        <div class="article">   
		
			<div id="login-box" class="login-popup">
				<a href="#" class="close"><img src="images/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>
				  <form method="post" class="signin" action="#">
						<fieldset class="textbox">
						<label class="username">
						<span>Username or email</span>
						<input id="username" name="username" value="" type="text"/>
						</label>
						<label class="password">
						<span>Password</span>
						<input id="password" name="password" value="" type="password"/>
						</label>
						<button class="submit button" type="button">Sign in</button>
						<p>
						<a class="forgot" href="#">Forgot your password?</a>
						</p>       
						</fieldset>
				  </form>
			</div>
		
        </div>
      </div>
      
      <div class="clr"></div>
    </div>
  </div>
  <div class="fbg">
    <div class="fbg_resize">
      <div class="col c1">
      </div>
      <div class="col c2">
       
      </div>
      <div class="col c3">
        
      </div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="footer">
    <div class="footer_resize">
      <p class="lf">&copy; Copyright <a href="#">www.noqueue.com</a>. A subsidary of <a href="#">Ceylon Theaters Group</a>.</p>
      <p class="rf">Powered by <a href="http://www.globalmeshsolutions.com">Global Mesh</a></p>
      <div style="clear:both;"></div>
    </div>
  </div>
</div>
</body>
</html>
