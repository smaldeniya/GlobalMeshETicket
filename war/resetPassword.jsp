<%@ include file="header.jsp"%>
<%@ include file="popup.jsp"%>

${sessionScope.hasReset}
<c:if test="${sessionScope.hasReset != "true"}">

	<script type="text/javascript">
		function submitReset(input){
			if(validate(input,'email')){
				$("form")[0].submit();
			} else {
				alert("Please enter a valid Email address");
			}
		}
	</script>

	<div class="reset_password">
		<span class="heading">Reset your password.</span>
		<form method="post" class="signin" action="/reset.do">
			<fieldset class="textbox">
				<label class="username" style="margin-bottom: 5px"> <span>Email</span>
					<input id="resetEmale" name="resetEmale" type="text" />
				</label>
				<button id="butReset" class="submit button" type="button" onclick="submitReset('resetEmale')">Reset Password</button>
			</fieldset>
		</form>
	</div>
	
</c:if>

<%@ include file="footer.jsp"%>