<%@include file="header_common.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#sliderBanner").carouFredSel({
		circular: true,
		infinite: false,
		pagination  : "#slidePag",
		scroll : {
			items : 1,
			easing : "quadratic",
			duration : 1000,                        
			pauseOnHover : true
		}
	});
});
</script>

<div id="slider">
	<div id="sliderBanner">
		<img src="/image.do?type=hall&hall=Gold" width="960" height="360" alt="" />
		<img src="/image.do?type=hall&hall=Platinum" width="960" height="360" alt="" />
		<img src="/image.do?type=hall&hall=Superior" width="960" height="360" alt="" />
		<img src="/image.do?type=hall&hall=Ultra" width="960" height="360" alt="" />
	</div>
	<div class="pagination" id="slidePag"></div>
</div>

				<div class="clr"></div>
			</div>
		</div>

		<div class="content">
			<div class="content_resize">
				<div class="mainbar">