package com.globalmesh.action.hall;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
 * This servlet is responsible for populate the necessary fields for /selectHall.
 *
 */

public class SelectHall extends HttpServlet {

	
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
			
			List<Hall> halls = HallDAO.INSTANCE.listHalls();
			Map<String, Hall> hallDetals = new HashMap<String, Hall>();
			for (Hall hall : halls) {
				hallDetals.put(hall.getHallId(), hall);
			}
			
			List<MovieDetail> nowShowingMovies = MovieDetailDAO.INSTANCE.listNowShowingMovies();
			MovieDetail[] movieArr = nowShowingMovies.toArray(new MovieDetail[nowShowingMovies.size()]);
			
			req.setAttribute("hallDetails", hallDetals);
			req.setAttribute("nowShowing", movieArr);
			req.getRequestDispatcher("/selectHall.jsp").forward(req, resp);
			
		}
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("doPost");
	}
	
}
