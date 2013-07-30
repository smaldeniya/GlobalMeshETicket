
<div id="movieDetails" style="display:block">
		<div class="labelDetails">
			<div>
				<fieldset class="textbox">
					<lable ><span>Film Name</span></lable>
					<lable ><span>Theater</span></lable>
					<lable ><span>Status</span></lable>
					<lable ><span>Youtube URL</span></lable>
					<lable ><span>Show Time 1</span></lable>
					<lable ><span>Show Time 2</span></lable>
					<lable ><span>Show Time 3</span></lable>
					<lable ><span>Show Time 4</span></lable>
					<lable ><span>Show Time 5</span></lable>
					<lable ><span>Film Poster (Small)</span></lable>
					<lable ><span>Description (Plot)</span></lable>
				</fieldset>
			</div>
		</div>
		
		<div class="devider" style="height:700px"></div>

		<div class="userDetailsCommon">
			<form action="/useru.do" id="movieForm" method="post" enctype="multipart/form-data">
				<label>
					<input type="text" value='' id="filmName" name="filmName" style="margin-top:30px" onblur="validate('filmName', 'any')"/>
					<!-- span style="float:left; margin-left:5px;margin-top:35px;"><a class="searchBut" href="	"></a></span -->
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:40px;"></span>
				</label>
		
				<label>			
					<select name="theater" id="theater" style="margin-top:20px; float:left; clear:left; width:230px; height:45px;" class="styled-select" onchange="checkHall()"> 
						<option value="" selected="selected">Select Theater</option> 
						<% 	String [] hallNames = (String[])request.getAttribute("hallNames"); 
							for(String hall:hallNames){
						%>
								<option value="<%=hall %>"><%=hall %></option>
						<%	} %> 
						</select>
						<span style="float:left; margin-left:5px;margin-top:25px;"><a class="searchBut" href="#" onclick="getMovieForUpdate();return false;"></a></span>
						<span class="errorMessage" style="float:left; margin-left:5px;margin-top:40px; width:210px;"></span>
				</label>
				
				<label>			
					<select name="status" id="status" style="margin-top:25px; float:left; clear:left; width:230px; height:45px;" class="styled-select"> 
						<option value="" selected="selected">Select Status</option> 
						<option value="0">Now Showing</option> 
						<option value="1">Coming Soon</option> 
						<option value="2">Show Ended</option> 
					</select>
				</label>
				
				<label>
					<input type="text"  id="utube" size="12" name="utube" value='' style="margin-top:25px; width:250px;padding:10px;" onblur="validate('utube', 'utube')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime1" size="12" name="showtime1" value='Eg. 04:30 PM or NAN' style="margin-top:25px;" onblur="validateShowTimes('showtime1')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime2" size="12" name="showtime2" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('showtime2')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime3" size="12" name="showtime3" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('showtime3')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime4" size="12" name="showtime4" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('showtime4')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="text"  id="showtime5" size="12" name="showtime5" value='Eg. 04:30 PM or NAN' style="margin-top:25px" onblur="validateShowTimes('showtime5')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<input type="file" value='' id="filmPoster" name="filmPoster" style="margin-top:20px" onblur="validate('filmPoster', 'any')"/>
					<span class="errorMessage" style="float:left; margin-left:5px;margin-top:35px;"></span>
				</label>
				
				<label>
					<textarea rows="4" cols="20" id="plot" name="plot" style="margin-top:25px"></textarea>
				</label>
				
				<label>
					<button class="submit button" type="button" onclick="btnAddOnClick('movie')" style="margin-top:25px;margin-right:20px;position:relative;">Add Movie</button>
				</label>
					
				<label>	
					<button class="submit button" type="button" onclick="btnUpdateOnClick('movie')" style="margin-top:25px;position:relative;clear:none">Update Movie</button>
				</label>
				
				<label>
					<button class="submit button" type="button" onclick="btnRemoveOnClick('movie')" style="margin-left:20px;margin-top:25px;position:relative;clear:none">Delete Movie</button>
				</label>
			</form>

		</div>
</div>
