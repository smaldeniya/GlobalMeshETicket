package com.globalmesh.action.sale;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dto.Hall;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.dto.Sale;
import com.globalmesh.dao.HallDAO;
import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dao.SaleDAO;
import com.globalmesh.util.Utility;

public class GetReservedSeatsServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String date = req.getParameter("showDate"); //localhost:8080/getReserved.do?showDate=&showTime=&hallName=
		String time = req.getParameter("showTime"); //time is must to identify the booking
		String hall = Utility.chooseHall(req.getParameter("hallName"));
		String type = req.getParameter("type");
		
		if(type.compareTo("reservedSeats") == 0) {
			Hall h = HallDAO.INSTANCE.getHallById(hall);
			
			DateFormat showFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
			List<Sale> bookings = null;
			try {
				bookings = SaleDAO.INSTANCE.listSalesByDateAndHall(showFormat.parse(date + " " + time), h);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(bookings != null) {
				StringBuilder sb = new StringBuilder();
				for (Sale s : bookings) {
					
					sb.append(s.getSeats());
					if(bookings.indexOf(s) < bookings.size() -1 ){
						sb.append(";");
					}
				}
				
				resp.getWriter().write(sb.toString());
			}
			
		}
		
		if(type.compareTo("timeForDay") == 0) {
			
			MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(hall);
			DateFormat showFormat = new SimpleDateFormat("yyyy-MM-dd");
			
			Calendar c = Calendar.getInstance();
			try {
				c.setTime(showFormat.parse(date));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			int dateOfWeek = c.get(Calendar.DAY_OF_WEEK);
			
			DateFormat showFormat2 = new SimpleDateFormat("hh:mm a");
			
			StringBuilder sb = new StringBuilder();
			if(movie.getMovieTime1() != null && movie.getMovieTime1().length >0) {
				sb.append(showFormat2.format(movie.getMovieTime1()[dateOfWeek]));
				
			}
			if(movie.getMovieTime2() != null && movie.getMovieTime2().length >0){
				sb.append(";");
				sb.append(showFormat2.format(movie.getMovieTime2()[dateOfWeek]));
				
			}
			if(movie.getMovieTime3() != null && movie.getMovieTime3().length >0){
				sb.append(";");
				sb.append(showFormat2.format(movie.getMovieTime3()[dateOfWeek]));
				
			}
			
			if(movie.getMovieTime4() != null && movie.getMovieTime4().length >0){
				sb.append(";");
				sb.append(showFormat2.format(movie.getMovieTime4()[dateOfWeek]));
				
			}
			
			if (movie.getMovieTime5() != null && movie.getMovieTime5().length >0) {
				sb.append(";");
				sb.append(showFormat2.format(movie.getMovieTime5()[dateOfWeek]));
			}
	
			resp.getWriter().write(sb.toString());
			
		}
		
	}
	
}
