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

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class SuperiorAction extends HttpServlet {

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
					Constants.HALL_SUPERIOR);
			MovieDetail hallMovie = MovieDetailDAO.INSTANCE
					.getNowShowingMovie(hallName);

			if (hallMovie != null) {
				DateFormat movieDateFormat = new SimpleDateFormat("hh:mm a");

				req.setAttribute("youtubeUrl", hallMovie.getMovieYouTube());

				int dayOfWeek = Calendar.getInstance()
						.get(Calendar.DAY_OF_WEEK);
				Date[] shows = new Date[5];

				for (int i = 0; i < 5; i++) {
					switch (i) {
					case 0:
						if (hallMovie.getMovieTime5() != null && hallMovie.getMovieTime5().length == 7)
							shows[i] = hallMovie.getMovieTime1()[dayOfWeek];
						break;
					case 1:
						if (hallMovie.getMovieTime5() != null && hallMovie.getMovieTime5().length == 7)
							shows[i] = hallMovie.getMovieTime2()[dayOfWeek];
						break;
					case 2:
						if (hallMovie.getMovieTime5() != null && hallMovie.getMovieTime5().length == 7)
							shows[i] = hallMovie.getMovieTime3()[dayOfWeek];
						break;
					case 3:
						if (hallMovie.getMovieTime5() != null && hallMovie.getMovieTime5().length == 7)
							shows[i] = hallMovie.getMovieTime4()[dayOfWeek];
						break;
					case 4:
						if (hallMovie.getMovieTime5() != null && hallMovie.getMovieTime5().length == 7)
							shows[i] = hallMovie.getMovieTime5()[dayOfWeek];
						break;
					}
				}

				List<String> showTimes = new ArrayList<String>();

				for (Date date : shows) {
					if (date != null) {
						showTimes.add(movieDateFormat.format(date));
					}
				}
				req.setAttribute("shows", showTimes);
				req.getRequestDispatcher("/superior_seatPlan.jsp").forward(req,
						resp);
			} else {
				req.setAttribute("youtubeUrl", "");
				req.setAttribute("shows", new ArrayList<String>());
				req.getRequestDispatcher("/superior_seatPlan.jsp").forward(req,
						resp);
			}

		}
	}
}
