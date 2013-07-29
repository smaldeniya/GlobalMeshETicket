/**
 * 
 */
package com.globalmesh.action.moviedetail;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Constants.MovieStatus;
import com.globalmesh.util.MD5HashGenerator;
import com.globalmesh.util.Utility;

/**
 * @author Transformers
 *
 */
public class MovieDetailInsertAction extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		String filmName = req.getParameter("filmName");
		String movieId = null;
		try {
			movieId = MD5HashGenerator.md5(filmName);
			//movie.setMovieId(MD5HashGenerator.md5(filmName));
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		MovieDetail movie = MovieDetailDAO.INSTANCE.getMovieById(movieId);
		boolean isNew = false;
		if(movie == null) {  // add new movie
			isNew = true;
			movie = new MovieDetail();
			movie.setMovieId(movieId);
			movie.setMovieName(filmName);
			
			DateFormat movieDateFormat = new SimpleDateFormat("hh:mm a");
			
			for(int i = 1; i<6; i++) {
				String showtime = req.getParameter("showtime" + i);
				if(showtime != null && showtime.compareTo("NAN") != 0){ 
					try {
						Date date = movieDateFormat.parse(showtime);
						Date [] weeklySchedule = new Date[7];
						
						for(int dateIndex=0; dateIndex<weeklySchedule.length; dateIndex++) {
							weeklySchedule[dateIndex] = date;
						}
						
						switch (i) {
							case 1:
								movie.setMovieTime1(weeklySchedule);
								break;
							case 2:
								movie.setMovieTime2(weeklySchedule);
								break;
							case 3:
								movie.setMovieTime3(weeklySchedule);
								break;
							case 4:
								movie.setMovieTime4(weeklySchedule);
								break;
							case 5:
								movie.setMovieTime5(weeklySchedule);
								break;
								
							default:
								break;
						}
					} catch (ParseException e) {
					}
				}
			}
			
		}
		
		movie.setMovieTheatre(req.getParameter("theater"));
		int status = Integer.parseInt(req.getParameter("status"));
		
		if (status == 0) {
			movie.setStatus(Constants.MovieStatus.NowShowing);
		} else if(status == 1) {
			movie.setStatus(MovieStatus.UpComing);
		} else {
			movie.setStatus(MovieStatus.Shown);
		}
		
		movie.setMovieYouTube(req.getParameter("utube")); //www.youtube.com/embed/aV8H7kszXqo				
		movie.setMovieDetails(req.getParameter("plot"));
		
		if(isNew){
			if(MovieDetailDAO.INSTANCE.addMovieDetail(movie)){
				req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.MOVIE_ENTER_SUCCESSFUL));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			} else {
				req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.MOVIE_ENTER_FAIL));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			}
		} else {
			if(MovieDetailDAO.INSTANCE.updateMovieDetail(movie)){
				req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.MOVIE_ENTER_SUCCESSFUL));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			} else {
				req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.MOVIE_ENTER_FAIL));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			}
		}
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String type = req.getParameter("type");
		
		if(type.compareTo("hall") == 0){
			String hall = req.getParameter("hallId");
			
			MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(hall);
			
			if(movie == null){
				resp.getWriter().write("true");
			} else {
				resp.getWriter().write("false");
			}	
		}
		
		if(type.compareTo("update") == 0) {
			String hall = req.getParameter("hallId");
			
			MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(hall);
			if(movie != null){
				DateFormat movieDateFormat = new SimpleDateFormat("hh:mm a");
				
				StringBuffer sb = new StringBuffer();
				sb.append(movie.getMovieName());
				sb.append(";");
				sb.append(movie.getMovieTheatre());
				sb.append(";");
				sb.append(movie.getMovieYouTube());
				sb.append(";");		
							
				sb.append(movie.getMovieDetails().replace(';', ' '));
				
				resp.getWriter().write(sb.toString());
				
			} else {
				resp.getWriter().write("false");
			}	
			
		}
			
		
	}
}
