/**
 * 
 */
package com.globalmesh.action.moviedetail;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.util.Constants;

/**
 * @author Transformers
 *
 */
public class MovieDetailInsertAction extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		try{
			MovieDetail movieDetail = new MovieDetail();
			
			movieDetail.setMovieDetails(req.getParameter("movieDetails"));			
			movieDetail.setMovieName(req.getParameter("movieName"));
			movieDetail.setMovieStatus(Integer.parseInt(req.getParameter("movieStatus")));
			movieDetail.setMovieTheatre(req.getParameter("movieTheatre"));
			movieDetail.setMovieTime1(req.getParameter("movieTime1"));
			movieDetail.setMovieTime2(req.getParameter("movieTime2"));
			movieDetail.setMovieTime3(req.getParameter("movieTime3"));
			movieDetail.setMovieTime4(req.getParameter("movieTime4"));
			movieDetail.setMovieTime5(req.getParameter("movieTime5"));
			
			MovieDetailDAO.INSTANCE.addMovieDetail(movieDetail);//return boolean
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		try{
			MovieDetail movieDetail = new MovieDetail();
			
			movieDetail.setMovieDetails("movieDetails");			
			movieDetail.setMovieName("movieName");
			movieDetail.setMovieStatus(1);
			movieDetail.setMovieTheatre("movieTheatre");
			movieDetail.setMovieTime1("10.00Am");
			movieDetail.setMovieTime2("10.00Am");
			movieDetail.setMovieTime3("10.00Am");
			movieDetail.setMovieTime4("10.00Am");
			movieDetail.setMovieTime5("10.00Am");
			
			MovieDetailDAO.INSTANCE.addMovieDetail(movieDetail);//return boolean
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
}
