<%@ include file="movieHeader.jsp"%>
<%@ include file="popup.jsp"%>

<script type="text/javascript">
	$(document).ready(function (){
		$(".seatingArrangement").children("table").each(function () {
			alert("hello")
		});
	})
</script>

<div class="seat_plan_header">Majestic cinema - Gold</div>
<div class="clr"></div>

<div class="seatingArrangement" align="center" >
  <div style="width:475px;">
  	<div class="theater">
  	<div style="width:354px;height:224px;padding:8px 2px 6px 12px;">
  		<iframe width="354" height="250" src="//www.youtube.com/embed/kEIVPiTuYkQ?autoplay=1&fmt=17&controls=0&iv_load_policy=3" frameborder="0" allowfullscreen></iframe>
  	</div>
  	</div>
    <table border="0" cellspacing="3" cellpadding="3" class="plan" style="float:left;">
      <tr>
        <td>E10</td>
        <td>E9</td>
        <td>E8</td>
        <td>E7</td>
        <td>E6</td>
      </tr>
      <tr>
        <td>D10</td>
        <td>D9</td>
        <td>D8</td>
        <td>D7</td>
        <td>D6</td>
      </tr>
      <tr>
        <td>C10</td>
        <td>C9</td>
        <td>C8</td>
        <td>C7</td>
        <td>C6</td>
      </tr>
      <tr>
        <td>B10</td>
        <td>B9</td>
        <td>B8</td>
        <td>B7</td>
        <td>B6</td>
      </tr>
      <tr>
        <td>A10</td>
        <td>A9</td>
        <td>A8</td>
        <td>A7</td>
        <td>A6</td>
      </tr>
    </table>
    <table border="0" cellspacing="3" cellpadding="3" class="plan" style="margin-left:35px; float:left;">
      <tr>
        <td>E5</td>
        <td>E4</td>
        <td>E3</td>
        <td>E2</td>
        <td>E1</td>
      </tr>
      <tr>
        <td>D5</td>
        <td>D4</td>
        <td>D3</td>
        <td>D2</td>
        <td>D1</td>
      </tr>
      <tr>
        <td>C5</td>
        <td>C4</td>
        <td>C3</td>
        <td>C2</td>
        <td>C1</td>
      </tr>
      <tr>
        <td>B5</td>
        <td>B4</td>
        <td>B3</td>
        <td>B2</td>
        <td>B1</td>
      </tr>
      <tr>
        <td>A5</td>
        <td>A4</td>
        <td>A3</td>
        <td>A2</td>
        <td>A1</td>
      </tr>	
    </table>
  </div>
</div>

<%@ include file="movieFooter.jsp"%>