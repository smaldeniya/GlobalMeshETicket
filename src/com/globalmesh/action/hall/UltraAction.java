package com.globalmesh.action.hall;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.HallDAO;
import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.Hall;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

/**
 * Requests coming to Ultra hall, go through this servlet. It set the relevent show times
 * which may be changed for the date of the week. (Ex: Sunday show 3 starts 40 minutes later )
 * 
 */

public class UltraAction extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String user = (String) req.getSession().getAttribute("email");

		if (user == null) {
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message",
					Utility.getCONFG()
							.getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);

		} else {
			String hallName = Utility.getCONFG().getProperty(
					Constants.HALL_ULTRA);
			MovieDetail hallMovie = MovieDetailDAO.INSTANCE
					.getNowShowingMovie(hallName);
			if (hallMovie != null) {
				DateFormat movieDateFormat = new SimpleDateFormat("hh:mm a");

				req.setAttribute("youtubeUrl", hallMovie.getMovieYouTube());

				int dayOfWeek = Calendar.getInstance()
						.get(Calendar.DAY_OF_WEEK) - 1;
				Date[] shows = new Date[5];

				for (int i = 0; i < 5; i++) {
					switch (i) {
					case 0:
						Date[] date = hallMovie.getMovieTime1();
						if (date != null && date.length == 7)
							shows[i] = date[dayOfWeek];
						break;
					case 1:
						Date[] date2 = hallMovie.getMovieTime2();
						if (date2 != null && date2.length == 7)
							shows[i] = date2[dayOfWeek];
						break;
					case 2:
						Date[] date3 = hallMovie.getMovieTime3();
						if (date3 != null && date3.length == 7)
							shows[i] = date3[dayOfWeek];
						break;
					case 3:
						Date[] date4 = hallMovie.getMovieTime4();
						if (date4 != null && date4.length == 7)
							shows[i] = date4[dayOfWeek];
						break;
					case 4:
						Date[] date5 = hallMovie.getMovieTime5();
						if (date5 != null && date5.length == 7)
							shows[i] = date5[dayOfWeek];
						break;
					}
				}

				List<String> showTimes = new ArrayList<String>();

				for (Date date : shows) {
					if (date != null) {
						showTimes.add(movieDateFormat.format(date));
					}
				}

				Hall h = HallDAO.INSTANCE.getHallById(hallName);
				
				req.setAttribute("hall", h);
				req.setAttribute("shows", showTimes);
				req.getRequestDispatcher("/ultra_seatPlan.jsp").forward(req,
						resp);
			} else {
				req.setAttribute("youtubeUrl", "");
				req.setAttribute("shows", new ArrayList<String>());
				req.getRequestDispatcher("/ultra_seatPlan.jsp").forward(req,
						resp);
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String hallName = req.getParameter("hallName");
		String showDate = req.getParameter("showDate");
		String showTime = req.getParameter("showTime");
		String numOfHalfTickets = req.getParameter("halfTicket");
		String seatSelection = req.getParameter("seatSelection");
		String seatCount = req.getParameter("seatCount");
		String userEmail = (String) req.getSession().getAttribute("email");

		System.out.println(hallName);
	}

}
