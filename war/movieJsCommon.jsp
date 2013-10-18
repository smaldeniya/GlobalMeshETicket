		<div class="content">
			<div class="content_resize">
				<div class="mainbar">


<script type="text/javascript" src="js/messi.js"></script>
<script type="text/javascript">
$(".seatingArrangement").ready(function (){
	
	$("#showDate").bind("blur",function() {
		getShowTimesOfDate();
		cleanSeatsFromServer();
		cleanSeats(); <%-- before every call to cleanSeats function, cleanSeatsFromServer() should be called to clean seats from server.--%>
		seatListner();
		if(validate('showDate','date')){
			getBookedSeats();
		} else {
			$(".seatingArrangement").children().find("table td").each(function (){
				$(this).unbind("click");
			});
		}
	});
	
	$("#showTime").bind("change",function() {
		cleanSeatsFromServer();
		cleanSeats();
		seatListner();
		getBookedSeats();
	});
	//function too change resered seats.
});

<c:choose>
	<c:when test="${sessionScope['type'] == 'admin'}">
		function btnPrintOnClick() {
			if(validate('showDate','date') && validate('showTime', 'showTime') && validate('halfTicket','number') && validate('seatCount', 'seatCount')){
				var seats = $("#seatSelection").val().split(';');
				for(var i = 0; i<seats.length ; i++) {
					$("#" + seats[i]).unbind("click");
					$("#" + seats[i]).css("background-image",
							"url(../images/reserved_small.png)");
				}
				
				cleanSeatsFromServer();
				
				$("#filmBookForms").attr("action", "/book.do");
				$("#filmBookForms").attr("target", "_blank");
				$("form")[0].submit();
				
				$("#seatCount").val("0");
				$("#seatCounter").text("0");
				$("#seatSelection").val("");
			}
		}
	</c:when>
	<c:otherwise>
		function btnBuyOnClick() {
			if(validate('showDate','date') && validate('showTime', 'showTime') && validate('halfTicket','number') && validate('seatCount', 'seatCount')){
				$("#seatPlanHolder").css("display", "none");
				$("#confirmationBlock").css("display", "block");
				$("#confirmSeatnumbers .value").text($("#seatSelection").val().replace(/\;/g,' '));
				$("#confirmDate .value").text($("#showDate").val());
				$("#confirmTime .value").text($("#showTime").val());
				$("#confirmTotal .value").text("Rs. " + calculateTotal().toFixed(2));
				$("#confirmationBlock").focus();
			}
		}
		
		function btnConfirmOnClick(){
			if(validate('showDate','date') && validate('showTime', 'showTime') && validate('halfTicket','number') && validate('seatCount', 'seatCount')){
				$("#filmBookForms").attr("action", "/book.do");
				$("form")[0].submit();
			}
		}
		
		function btnCancleBuyOnClick() {
			$("#seatPlanHolder").css("display", "block");
			$("#confirmationBlock").css("display", "none");
			$("#confirmSeatnumbers .value").text("");
			$("#confirmDate .value").text("");
			$("#confirmTime .value").text("");
			$("#confirmTotal .value").text("");
		}
		
		function calculateTotal() {
			var fullTicketPrice = parseFloat(${requestScope['hall'].odcFull});
			var halfTicketPrice = parseFloat(${requestScope['hall'].odcHalf});
			
			var halfTickets = parseInt($("#halfTicket").val());
			var totalTicket = parseInt($("#seatCount").val());
			var fullTickets = totalTicket - halfTickets;
			
			return (halfTickets * halfTicketPrice + fullTickets * fullTicketPrice);
			
		}
	</c:otherwise>
</c:choose>

function cleanSeats(){
	$(".seatingArrangement").children().find("table td").each(function (){
		if(!$(this).hasClass("blank") && !$(this).hasClass("ctmgmt") && !$(this).hasClass("sampath")) {
			$(this).removeAttr( 'style' );
			$(this).unbind("click");
			$("#seatCount").val("0");
			$("#seatCounter").text("0");
			$("#seatSelection").val("");
		}			
	});
}

function seatListner() {
		$(".seatingArrangement").children().find("table td").each(function (){
			
			if(!$(this).hasClass("blank") && !$(this).hasClass("ctmgmt") && !$(this).hasClass("sampath")) {
				$(this).click(function () {
					
					var result = false;
					var url = getURLPath() + "blockTicket.do";
					var ticketKey = $("#showDate").val() + "-" + $("#showTime").val() + "-" + $("#hallName").val() + "-" + $(this).attr('id');
					
					$.ajax({
						url : url,
						async : false,
						type : "POST",
						data : {
							'type' : 'addReservation',
							'ticketKey' : ticketKey
						},
						success : function(data, status) {
							if (!isEmpty(data) && data == "true") {
								result = true;
							}
						}
					});
					
					
					if($(this).css("background-image").indexOf("selected_small.png") == -1){
						
						if(result) {
							$(this).css("background-image", "url(../images/selected_small.png)");
							
							var seats = $("#seatSelection").val();
							if(isEmpty(seats)){
								seats = $(this).text();
							} else {
								seats = seats + ";" + $(this).text();
							}
							$("#seatSelection").val(seats);
							
							var seatCount = $("#seatCount").val();
							if(!isEmpty(seatCount)) {
								seatCount = parseInt(seatCount);
								seatCount += 1;
							} else {
								seatCount = 1;
							}
							$("#seatCount").val(seatCount);
							$("#seatCounter").text(seatCount);
							
						}
						
					}else {
						$(this).removeAttr( 'style' );
						var removeVal = $(this).text();
						var seats = $("#seatSelection").val();
						var removeValIndex = seats.indexOf(removeVal);
						var lastIndexOfdel = seats.lastIndexOf(";")
						//if last index is greater than remov index then remove with ; else remove without ;
						if(lastIndexOfdel > removeValIndex) {
							removeVal = removeVal + ";";
						}
						
						if(lastIndexOfdel > -1 && lastIndexOfdel == (removeValIndex - 1)) {
							removeVal = ";" + removeVal;
						}
						
						$("#seatSelection").val(seats.replace(removeVal, ""));
						
						var seatCount = $("#seatCount").val();
						if(!isEmpty(seatCount)) {
							seatCount = parseInt(seatCount);
							if(seatCount >0){
								seatCount -= 1;
							}						
						}
						$("#seatCount").val(seatCount);
						$("#seatCounter").text(seatCount);
											
					}
					
					if(!result) {
						$(this).unbind("click");
						$(this).css("background-image",
								"url(../images/reserved_small.png)");
						alert("Seat number " + $(this).attr('id') + " just reserved by some one else. Please select another seat.");
					}
					
				});
			}
			
		});			
}

function getBookedSeats() {
	
	var showDate = $("#showDate").val();
	var showTime = $("#showTime").val();
	var hall = $("#hallName").val();

	var urlGet = getURLPath() + "getReserved.do";

	$.ajax({
		url : urlGet,
		async : false,
		type : "POST",
		data : {
			'type' : 'reservedSeats',
			'showDate' : showDate,
			'showTime' : showTime,
			'hallName' : hall
		},
		success : function(data, status) {
			if (!isEmpty(data)) {
				<c:choose>
					<c:when test="${sessionScope['type'] == 'admin'}">
						var bookedSeats = data.split(";");
						for ( var i = 0; i < bookedSeats.length; i++) {
							$("#" + bookedSeats[i]).unbind("click");
							$("#" + bookedSeats[i]).css("background-image",
									"url(../images/reserved_small.png)");
						}
					</c:when>
					<c:otherwise>					
						if(data=="NAN"){
							new Messi('Maximum online ticket limit reach for show time ' + showTime + ' on ' + showDate + ' for '  + hall + ' cinema. Please try another show time or another date.' , {title: 'Ticket limit exceed.', titleClass: 'anim info', buttons: [{id: 0, label: 'Close', val: 'X'}]});
						} else {
							var bookedSeats = data.split(";");
							for ( var i = 0; i < bookedSeats.length; i++) {
								$("#" + bookedSeats[i]).unbind("click");
								$("#" + bookedSeats[i]).css("background-image",
										"url(../images/reserved_small.png)");
							}
						}
					</c:otherwise>
				</c:choose>
			}
		}
	});

}

function getShowTimesOfDate() {
	var showDate = $("#showDate").val();
	var hall = $("#hallName").val();
	
	var urlGet = getURLPath() + "getReserved.do";
	
	$.ajax({
		url : urlGet,
		async : false,
		type : "POST",
		data : {
			'type' : 'timeForDay',
			'showDate' : showDate,
			'hallName' : hall
		},
		success : function(data, status) {
			if (!isEmpty(data)) {
				$("#showTime").html("");
				var showTimes = data.split(";");
				var html = "";
				for ( var i = 0; i < showTimes.length; i++) {
					html += "<option value='" + showTimes[i] + "'>" + showTimes[i] + "</option>"
				}
				$("#showTime").html(html);
			}
		}
	});
}

$(window).unload(function() {
	cleanSeatsFromServer();	
});

function cleanSeatsFromServer() {
	var url = getURLPath() + "blockTicket.do";
	var seats = $("#seatSelection").val();
		
		$.ajax({
			url : url,
			async : false,
			type : "POST",
			data : {
				'type' : 'removeReservation',
				'seatSet' : seats
			},
			success : function(data, status) {
			
			}
		});	
}
</script>



<div id="confirmationBlock" class="login-popup">
	
		<div class="seat_plan_header" style="margin-bottom: 70px;">Confirm Ticket Selection.</div>
		
		<div>
			<div id="confirmSeatnumbers" class="confirmItemHolder">
				<label class="username"><span class="name">Seat Numbers	:</span></label> 
				<label class="username"><span class="value"></span></label>		
			</div> 
			
			<div id="confirmDate" class="confirmItemHolder">
				<label class="username"><span class="name">Show Date	:</span></label> 
				<label class="username"><span class="value"></span></label>		
			</div>
			
			<div id="confirmTime" class="confirmItemHolder">
				<label class="username"><span class="name">Show Time	:</span></label> 
				<label class="username"><span class="value"></span></label>		
			</div>  
			
			<div id="confirmTotal" class="confirmItemHolder">
				<label class="username"><span class="name">Total	:</span></label> 
				<label class="username"><span class="value"></span></label>		
			</div> 		
		</div>
		
		<div class="confirmButtonHolder" align="center">
			<button class="submit button" type="button"	onclick="btnConfirmOnClick()" style="float: left;clear: none;">Confirm</button>
			<button class="submit button" type="button"	onclick="btnCancleBuyOnClick()" style="float: left;clear: none;margin-left: 60px;">Cancle</button>
		</div>
		
</div>

<div align="center" id="seatPlanHolder">



