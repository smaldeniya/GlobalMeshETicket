<%@ include file="header.jsp"%>
<%@ include file="popup.jsp"%>

<c:choose>
	<c:when test="${requestScope['resetMsg'] == null}">
		<script type="text/javascript">
			function submitReset(input) {
				if (validate(input, 'email')) {
					$("#resetForm").attr("action", "/reset.do");
					$("form")[2].submit();
				} else {
					$("#resetEmale").parent().children(
							"span[class=errorMessage]").text(
							"Please enter a valid Email address");
				}
			}
		</script>

		<div class="reset_password">
			<span class="heading">Reset your password.</span>
			<form id="resetForm" method="post" class="signin" action="/reset.do">
				<fieldset class="textbox">
					<label class="username" style="margin-bottom: 5px;"> <span>Email</span>
						<input id="resetEmale" name="resetEmale" type="text" onblur="validate('resetEmale', 'email')"/> <span
						class="errorMessage"></span>
					</label>
					<button id="butReset" class="submit button" type="button"
						onclick="submitReset('resetEmale')">Reset Password</button>
				</fieldset>
			</form>
		</div>
	</c:when>

	<c:otherwise>
		<div class="reset_password">
			<p>
				<strong>${requestScope['resetMsg']}</strong>
			</p>
		</div>
	</c:otherwise>
</c:choose>

<%@ include file="footer.jsp"%>