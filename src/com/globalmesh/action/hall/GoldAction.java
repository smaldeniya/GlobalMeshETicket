package com.globalmesh.action.hall;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class GoldAction<E> extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String user = (String) req.getSession().getAttribute("email");
		
		if(user == null) {
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} else {
			String hallName = Utility.getCONFG().getProperty(Constants.HALL_GOLD);
			MovieDetail hallMovie = MovieDetailDAO.INSTANCE.getNowShowingMovie(hallName);
			
			if(hallMovie != null) {
				DateFormat movieDateFormat = new SimpleDateFormat("hh:mm a");
				
				req.setAttribute("youtubeUrl", hallMovie.getMovieYouTube());
				
				Date[] shows = {hallMovie.getMovieTime1(), hallMovie.getMovieTime2(), hallMovie.getMovieTime3(),
						hallMovie.getMovieTime4(), hallMovie.getMovieTime5()};
				List<String> showTimes = new ArrayList<String>();
				
				for (Date date : shows) {
					if(date != null){
						showTimes.add(movieDateFormat.format(date));
					}
				}
							
				req.setAttribute("shows", showTimes);
				req.getRequestDispatcher("/gold_seatPlan.jsp").forward(req, resp);
			} else {
				req.setAttribute("youtubeUrl", "");
				req.setAttribute("shows", new ArrayList<String>());
				req.getRequestDispatcher("/gold_seatPlan.jsp").forward(req, resp);
			}
			
		}		
		
	}
	
}
