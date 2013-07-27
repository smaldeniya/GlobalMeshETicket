package com.globalmesh.action.sale;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.globalmesh.dao.HallDAO;
import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dao.SaleDAO;
import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.Hall;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.dto.Sale;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class SalesServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String userEmail = (String) req.getSession().getAttribute("email");
		int seatCount = Integer.parseInt(req.getParameter("seatCount"));
		
		if(userEmail == null || seatCount <= 0) {
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} else {
			String hallName = chooseHall(req.getParameter("hallName"));
			String showDate = req.getParameter("showDate");
			String showTime = req.getParameter("showTime");
			int numOfHalfTickets = Integer.parseInt(req.getParameter("halfTicket"));
			String seatSelection = req.getParameter("seatSelection");			
			
			DateFormat showFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
			try {
				Calendar show = Calendar.getInstance();
				show.setTime(showFormat.parse(showDate + " " + showTime));
				Calendar today = Calendar.getInstance();
				today.add(Calendar.MINUTE, 30);
				
				if(today.before(show)){
					User u = UserDAO.INSTANCE.getUserByEmail(userEmail);
					Hall h = HallDAO.INSTANCE.getHallById(hallName);
					MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(h.getHallId());
					
					Sale sale = new Sale();
					sale.setUserId(u.getUserId());
					sale.setHall(h.getHallId());
					sale.setMovie(movie.getMovieId());
					sale.setShowDate(show.getTime());
					sale.setSeatCount(seatCount);
					sale.setNumOfHalfTickets(numOfHalfTickets);
					sale.setSeats(seatSelection);
					
					if(SaleDAO.INSTANCE.insertSale(sale)){
						//TODO payment gateway
						resp.getWriter().write("Welcome to payment gateway :P");
					} else {
						req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
						req.setAttribute("message",Utility.getCONFG().getProperty(Constants.SALE_FAIL));
						req.getRequestDispatcher("/messages.jsp").forward(req, resp);
					}
				} else {
					req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
					req.setAttribute("message", Utility.getCONFG().getProperty(Constants.DATE_EXCEED));
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				}
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			
			
		}	
		
	}

	private String chooseHall(String hallId){
		String hall = "";
		if(hallId.compareTo("gold") == 0) {
			hall = Utility.getCONFG().getProperty(Constants.HALL_GOLD);
		} else if(hallId.compareTo("platinum") == 0) {
			hall = Utility.getCONFG().getProperty(Constants.HALL_PLATINUM);
		} else if(hallId.compareTo("superior") == 0) {
			hall = Utility.getCONFG().getProperty(Constants.HALL_SUPERIOR);
		} else if(hallId.compareTo("ultra") == 0) {
			hall = Utility.getCONFG().getProperty(Constants.HALL_ULTRA);
		} else {
			//error
		}
		
		return hall;
	}
	
}
