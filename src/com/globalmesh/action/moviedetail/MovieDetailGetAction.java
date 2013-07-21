/**
 * 
 */
package com.globalmesh.action.moviedetail;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.MovieDetail;

/**
 * @author Transformers
 *
 */
public class MovieDetailGetAction extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		List<MovieDetail> movieDetailList = null;
		
		try{
			movieDetailList = MovieDetailDAO.INSTANCE.listMovies();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		String url="..."; //relative url for display jsp page
	    ServletContext sc = getServletContext();
	    RequestDispatcher rd = sc.getRequestDispatcher(url);

	    req.setAttribute("movieDetailList", movieDetailList );
	    rd.forward(req, resp);
	}
}
