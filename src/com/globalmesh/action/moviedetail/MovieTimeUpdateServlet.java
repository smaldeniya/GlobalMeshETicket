package com.globalmesh.action.moviedetail;

import java.io.IOException;
import java.text.DateFormat;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class MovieTimeUpdateServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String hall = req.getParameter("hallforRule");
		int showNum = Integer.parseInt(req.getParameter("showTimeforRule"));
		
		MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(hall);
		
		if(movie != null) {
			DateFormat movieDateFormat = new SimpleDateFormat("hh:mm a");			
			try {
				
				Calendar c1 = Calendar.getInstance();
				c1.setTime(movieDateFormat.parse(req.getParameter("ruleSunday")));
				c1.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
				
				Calendar c2 = Calendar.getInstance();
				c2.setTime(movieDateFormat.parse(req.getParameter("ruleMonday")));
				c2.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
				
				Calendar c3 = Calendar.getInstance();
				c3.setTime(movieDateFormat.parse(req.getParameter("ruleTuesday")));
				c3.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
				
				Calendar c4 = Calendar.getInstance();
				c4.setTime(movieDateFormat.parse(req.getParameter("ruleWednesday")));
				c4.set(Calendar.DAY_OF_WEEK, Calendar.WEDNESDAY);
				
				Calendar c5 = Calendar.getInstance();
				c5.setTime(movieDateFormat.parse(req.getParameter("ruleThursday")));
				c5.set(Calendar.DAY_OF_WEEK, Calendar.THURSDAY);
				
				Calendar c6 = Calendar.getInstance();
				c6.setTime(movieDateFormat.parse(req.getParameter("ruleFriday")));
				c6.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
				
				Calendar c7 = Calendar.getInstance();
				c7.setTime(movieDateFormat.parse(req.getParameter("ruleSaturday")));
				c7.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
				
				Date[] showSchedule = {c1.getTime(), c2.getTime(), c3.getTime(), c4.getTime(), c5.getTime(), c6.getTime(), c7.getTime()};
				
				switch (showNum) {
					case 1:
						movie.setMovieTime1(showSchedule);
						break;
					case 2:
						movie.setMovieTime2(showSchedule);
						break;
					case 3:
						movie.setMovieTime3(showSchedule);
						break;
					case 4:
						movie.setMovieTime4(showSchedule);
						break;
					case 5:
						movie.setMovieTime5(showSchedule);
						break;
				}
				
				if(MovieDetailDAO.INSTANCE.updateMovieDetail(movie)){
					req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
					String message = MessageFormat.format(Utility.getCONFG().getProperty(Constants.MOVIE_UPDATE_SUCCESSFUL), movie.getMovieName());
					req.setAttribute("message", message);
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				} else {
					req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
					req.setAttribute("message", Utility.getCONFG().getProperty(Constants.MOVIE_ENTER_FAIL));
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				}
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} else {
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.MOVIE_ENTER_FAIL));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
		}
		
	}
	
}
