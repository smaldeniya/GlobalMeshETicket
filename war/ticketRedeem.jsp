<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
	
	<head>
		<title>NoQueue Redeem</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="css/ticket_redeem.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
		
		<script type="text/javascript">
		function getURLPath() {
			return $(location).attr('protocol') + "//" + $(location).attr('hostname') + ":" + $(location).attr('port') + "/";
		}
		
		function validate(id, type) {
			var result = false;
			var message = "";
			var value = $("#" + id).val();

			if (!isEmpty(value)) {
				switch (type) {

				case "email":
					var re = /\S+@\S+\.\S+/;
					result = re.test(value);
					message = "Please enter a valid Email address";
					break;

				case "password":
					var re = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
					result = re.test(value);
					message = "Password length should be between 6 to 20 and include atleast one lowercase and uppercase character and a number.";
					break;

				case "text":
					var re = /^[a-zA-z]+$/;
					result = re.test(value);
					message = "Name should only contain text characters";
					break;

				case "gender":
					result = true;
					break;

				case "mobile":
					var re = /^\d{10}$/;
					result = re.test(value);
					message = "Mobile number shoiuld only contain numbers";
					break;

				case "nic":
					var re = /^\d{9}\S{1}$/;
					result = re.test(value);
					message = "Please enter a valid nic number.";
					break;

				case "regEmail":
					var re = /\S+@\S+\.\S+/;
					result = re.test(value);
					if(!result){
						message = "Please enter a valid Email address.";
					}
					
					var checkURL = getURLPath() + "userCheck.do?by=email&value=" + value;
					$.ajax({
						url:checkURL,
						async:false,
						type : "GET",
						success: function(data,status){
							if(data == "null"){
								result = result && true;
							} else {
								result = result && false;
								message = message + " This email is already registered.";
							}
						}
					});
					break;

				case "loginPass":
					result = true;
					break;
					
				case "any":
					result = true;
					break;
					
				case "utube":
					var re = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
					result = re.test(value);
					message = "Enter a valid youtube embade url";
					break;
					
				case "showTime":
					var re = /^(0?[1-9]|1[012])(:[0-5]\d) [APap][mM]$/;
					result = re.test(value);
					message = "Enter a valid time (Eg. 10:30 PM)";
					break;
					
				case "seatCount":
					result = (parseInt(value) > 0);
					message = "Please select seats to proceed.";
					break;
					
				case "number":
					var re = /^[0-9]+$/;
					result = re.test(value);
					message = "This field should only include numbers";
					break;
					
				case "curruncy":
					var re = /^[0-9]+$/;
					result = re.test(value);
					message = "Curruncy should only include numbers";
					break;
					
				case "date":
					var re = /\d{4}-\d{2}-\d{2}/;
					result = re.test(value);
					if(!result){
						message = "Please enter a valid date. Eg: 2013-01-01";
						break;
					}
					var dateParts = value.split("-");
					var today = new Date();
					
					if(today.getFullYear() === parseInt(dateParts[0])){					
						result = result && true;
					}else {
						result = result && false;
						message =" Year should be currunt year.";
						break;
					}
					
					if((today.getMonth() + 1) <= parseInt(dateParts[1]) && (today.getMonth() + 2) >= parseInt(dateParts[1]) ){					
						result = result && true;
					}else {
						result = result && false;
						message = " Month should not be before the currunt month or after two months.";
						break;
					}
									
					if((today.getMonth() + 1) === parseInt(dateParts[1])) {
						if(today.getDate() <= parseInt(dateParts[2])  ){					
							result = result && true;
						}else {
							result = result && false;
							message = " Date should be greater than or equal currunt date.";
							break;
						}
					}
					
					break;
				}

			} else {
				message = "Field should not be empty";
			}

			if (!result) {
				$("#" + id).focus();
				$("#" + id).parent().children("span[class=errorMessage]").text(
						message);
			} else {
				$("#" + id).parent().children("span[class=errorMessage]").html(
						"<img src='../images/ok.png' height='16' width='16'/>");
			}

			return result;
		}

		function isEmpty(str) {
			return (!str || 0 === str.length);
		}
		
		function btnPrintOnClich() {
			$("#redeem").animate({ 
		        left: "-=220px",
		        top: "-=100px",
		      }, 850 );
			
			$("#ticketDetails").fadeIn(850, function(){
				$("#ticketDetails").css("display", "block");
			});			
			
			// ajax call print function
		}
		
		function btnPrintClose() {
				
		}		
		</script>		
	</head>
	
	<body>
			<div id="redeem">
				<form action="" method="post" id="printTicketForm">
					<span>Serial Number</span>
					<input class="redeemInput" value="Serial Number" type="text" id="serialNum" 
							name="serialNum" onblur="if(this.value=='')this.value='Serial Number';"  onfocus=" if(this.value=='Serial Number')this.value='';"/>
					<button type="button" id="btnPrint" name="btnPrint" onclick="btnPrintOnClich();">Print Ticket</button>					
				</form>
			</div>
			
			<div id="ticketDetails">
			  hello
			</div>
	</body>
	
</html>