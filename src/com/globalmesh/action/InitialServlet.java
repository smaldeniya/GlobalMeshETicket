package com.globalmesh.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.globalmesh.dao.HallDAO;
import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.Hall;
import com.globalmesh.dto.MovieDetail;
/**
 * 
 * Initial servlet. Request to home page goes through this page and it set all the dynamic things like
 * list of films and coming soon films etc to the request body and forward to index.jsp page which 
 * display those details on it's page.
 * 
 *
 */

public class InitialServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		List<MovieDetail> nowShowingMovies = MovieDetailDAO.INSTANCE.listNowShowingMovies();
		MovieDetail[] movieArr = nowShowingMovies.toArray(new MovieDetail[nowShowingMovies.size()]);
		int dateOfWeek = Calendar.getInstance().get(Calendar.DAY_OF_WEEK) - 1;	
		
		List<MovieDetail> commingSoon = MovieDetailDAO.INSTANCE.listNowShowingAndCommingSoonMovies();
		List<String> commingMovieNames = new ArrayList<String>();
		for (MovieDetail movieDetail : commingSoon) {
			commingMovieNames.add(movieDetail.getMovieId());
		}

		req.setAttribute("commingSoon", commingMovieNames);
		req.setAttribute("today", dateOfWeek);
		req.setAttribute("movieArray", movieArr);
		req.getRequestDispatcher("/index.jsp").forward(req, resp);
		
	}
	
}
