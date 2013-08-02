/**
 * 
 */
package com.globalmesh.action.moviedetail;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.commons.io.IOUtils;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Constants.MovieStatus;
import com.globalmesh.util.MD5HashGenerator;
import com.globalmesh.util.Utility;
import com.google.appengine.api.datastore.Blob;
/**
 * @author Transformers
 *
 */
public class MovieDetailInsertAction extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		ServletFileUpload upload = new ServletFileUpload();
		Blob image = null;
		Map<String, String> formFields = new HashMap<String, String>();
		try {
			FileItemIterator iterator = upload.getItemIterator(req);
			
			while(iterator.hasNext()){
				FileItemStream item = iterator.next();
				InputStream stream = item.openStream();
				
				if(item.isFormField()){
					formFields.put(item.getFieldName(), Streams.asString(stream));
				} else {
					byte[] b = IOUtils.toByteArray(stream);
					if(b.length > 0) {
						image = new Blob(b);
					}
				}
			}	
			
			
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		
		String filmName = formFields.get("filmName");
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
				String showtime = formFields.get("showtime" + i);
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
		
		movie.setMovieTheatre(formFields.get("theater"));
		int status = Integer.parseInt(formFields.get("status"));
		
		if (status == 0) {
			movie.setStatus(Constants.MovieStatus.NowShowing);
		} else if(status == 1) {
			movie.setStatus(MovieStatus.UpComing);
		} else {
			movie.setStatus(MovieStatus.Shown);
		}
		
		movie.setMovieYouTube(formFields.get("utube")); //www.youtube.com/embed/aV8H7kszXqo				
		movie.setMovieDetails(formFields.get("plot"));
		if(image != null) {
			movie.setMoviePoster(image);
		}
		
		
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
				String message = MessageFormat.format(Utility.getCONFG().getProperty(Constants.MOVIE_UPDATE_SUCCESSFUL), movie.getMovieName());
				req.setAttribute("message", message);
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
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		
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
		
		if(type.compareTo("showTimes") == 0){
			String hall = req.getParameter("hallId");
			
			MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(hall);
			
			if(movie != null){
				
				int i = 0;
				
				if (movie.getMovieTime1() != null && movie.getMovieTime1().length == 7){
					i++;
				}
				
				if (movie.getMovieTime2() != null && movie.getMovieTime2().length == 7){
					i++;
				}
				
				if (movie.getMovieTime3() != null && movie.getMovieTime3().length == 7){
					i++;
				}
				
				if (movie.getMovieTime4() != null && movie.getMovieTime4().length == 7){
					i++;
				}
				
				if (movie.getMovieTime5() != null && movie.getMovieTime5().length == 7){
					i++;
				}
				
				resp.getWriter().write("" + i);
				
			} else {
				resp.getWriter().write("false");
			}
		}
			
		if(type.compareTo("showSchedule") == 0){
			String hall = req.getParameter("hallId");
			MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(hall);
			String show = req.getParameter("show");
			
			Date[] showSchedule = null;
			StringBuilder sb = new StringBuilder();
			
			if(movie != null && show != null){
				int showNum = Integer.parseInt(show);
				
				switch(showNum) {
					case 1:
						showSchedule = movie.getMovieTime1();
						break;
					case 2:
						showSchedule = movie.getMovieTime2();
						break;
					case 3:
						showSchedule = movie.getMovieTime3();
						break;
					case 4:
						showSchedule = movie.getMovieTime4();
						break;
					case 5:
						showSchedule = movie.getMovieTime5();
						break;
				}
				
				if(showSchedule != null){
					DateFormat movieDateFormat = new SimpleDateFormat("hh:mm a");
					for (int date = 0; date < showSchedule.length; date++) {
						sb.append(movieDateFormat.format(showSchedule[date]));
						
						if(date < showSchedule.length -1){
							sb.append(";");
						}
					}
					
					resp.getWriter().write(sb.toString());
				} else {
					resp.getWriter().write("false");
				}
			} else {
				resp.getWriter().write("false");
			}
		}
	}
}
