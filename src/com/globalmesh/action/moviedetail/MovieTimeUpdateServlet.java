package com.globalmesh.action.moviedetail;

import java.io.IOException;
import java.text.DateFormat;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
				Date[] showSchedule = {
						movieDateFormat.parse(req.getParameter("ruleSunday")),
						movieDateFormat.parse(req.getParameter("ruleMonday")),
						movieDateFormat.parse(req.getParameter("ruleTuesday")),
						movieDateFormat.parse(req.getParameter("ruleWednesday")),
						movieDateFormat.parse(req.getParameter("ruleThursday")),
						movieDateFormat.parse(req.getParameter("ruleFriday")),
						movieDateFormat.parse(req.getParameter("ruleSaturday"))
				};
				
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
