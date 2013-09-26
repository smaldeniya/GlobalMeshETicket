package com.globalmesh.action;

import java.io.IOException;

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
import com.google.appengine.api.datastore.Blob;

/**
 * 
 * Fetch images for the hall based on type whether it is a banner for slide or
 * a poster to display in details section.
 *
 */

public class FetchImageServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String type = req.getParameter("type");
		String hall = req.getParameter("hall");
		
		Blob image = null;
		
		if(type != null ) {
			/**
			 * Type of Banner image is 'hall'
			 */
			if(type.compareTo("hall") == 0){
				if(hall != null){
					if(hall.compareTo("Gold") == 0){
						image = getHallBanner(Utility.getCONFG().getProperty(Constants.HALL_GOLD));
					} else if(hall.compareTo("Ultra") == 0) {
						image = getHallBanner(Utility.getCONFG().getProperty(Constants.HALL_ULTRA));
					} if(hall.compareTo("Platinum") == 0) {
						image = getHallBanner(Utility.getCONFG().getProperty(Constants.HALL_PLATINUM));
					} if(hall.compareTo("Superior") == 0) {
						image = getHallBanner(Utility.getCONFG().getProperty(Constants.HALL_SUPERIOR));
					} else {
						
					}
				}
			}
			
			/**
			 * Type of Poster is 'movie'
			 */
			if(type.compareTo("movie") == 0){
				if(hall != null){
					if(hall.compareTo("Gold") == 0){
						image = getMoviePoster(Utility.getCONFG().getProperty(Constants.HALL_GOLD));
					} else if(hall.compareTo("Ultra") == 0) {
						image = getMoviePoster(Utility.getCONFG().getProperty(Constants.HALL_ULTRA));
					} if(hall.compareTo("Platinum") == 0) {
						image = getMoviePoster(Utility.getCONFG().getProperty(Constants.HALL_PLATINUM));
					} if(hall.compareTo("Superior") == 0) {
						image = getMoviePoster(Utility.getCONFG().getProperty(Constants.HALL_SUPERIOR));
					} else {
						
					}
				}
			}
			
			if(type.compareTo("commingSoon") == 0) {
				String movieId = req.getParameter("movieId");
				image = MovieDetailDAO.INSTANCE.getMovieById(movieId).getMoviePoster();
			}
			
			// other images
		} else {
			
		}
		
		if(image != null) {
			resp.setContentType("image/jpg");
			resp.getOutputStream().write(image.getBytes());
		} else {
			throw new RuntimeException("Banner can not find for " + hall);
		}
		
	}
	
	/**
	 * Get the hall name and return its attached image of banner as a Blob
	 * @param hallName of type String
	 * @return image of type {@link Blob}
	 */
	private Blob getHallBanner(String hallName) {
		Hall h = HallDAO.INSTANCE.getHallById(hallName);
		return h.getMovieBanner();
	}
	
	/**
	 * Get the hall name and return it's attached image of poster as a Blob
	 * @param hallName of type String
	 * @return image of type {@link Blob}
	 */
	private Blob getMoviePoster(String hallName) {
		MovieDetail m = MovieDetailDAO.INSTANCE.getNowShowingMovie(hallName);
		return m.getMoviePoster();
	}
	
}
