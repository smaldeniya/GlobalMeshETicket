/**
 * 
 */
package com.globalmesh.action.moviedetail;

import java.io.IOException;
import java.util.List;

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
public class MovieDetailDeleteAction extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
					
		try{
			String movieId = req.getParameter("movieId");
		
			if(movieId != null && !movieId.equals(""))
				MovieDetailDAO.INSTANCE.remove(Long.parseLong(movieId));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		try{
			String movieId = req.getParameter("movieId");
			movieId = "1";
			if(movieId != null && !movieId.equals(""))
				MovieDetailDAO.INSTANCE.remove(Long.parseLong(movieId));
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
}
