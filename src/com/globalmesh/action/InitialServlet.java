package com.globalmesh.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.MovieDetail;

public class InitialServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		List<MovieDetail> nowShowingMovies = MovieDetailDAO.INSTANCE.listNowShowingMovies();
		MovieDetail[] movieArr = nowShowingMovies.toArray(new MovieDetail[nowShowingMovies.size()]);
		
		req.setAttribute("movieArray", movieArr);
		req.getRequestDispatcher("/index.jsp").forward(req, resp);
		
	}
	
}
