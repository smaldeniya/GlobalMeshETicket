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
import com.globalmesh.util.TicketPrinter;
import com.globalmesh.util.Utility;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfWriter;

public class SalesServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String userEmail = (String) req.getSession().getAttribute("email");
		
		if(userEmail == null) {
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message", Utility.getCONFG().getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} else {
			String hallName = Utility.chooseHall(req.getParameter("hallName"));
			String showDate = req.getParameter("showDate");
			String showTime = req.getParameter("showTime");
			int numOfHalfTickets = Integer.parseInt(req.getParameter("halfTicket"));
			int seatCount = Integer.parseInt(req.getParameter("seatCount"));
			String seatSelection = req.getParameter("seatSelection");			
			
			DateFormat showFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
			try {
				Calendar show = Calendar.getInstance();
				show.setTime(showFormat.parse(showDate + " " + showTime));

				User u = UserDAO.INSTANCE.getUserByEmail(userEmail);
				Hall h = HallDAO.INSTANCE.getHallById(hallName);
				MovieDetail movie = MovieDetailDAO.INSTANCE.getNowShowingMovie(h.getHallId());
					
				Sale sale = new Sale();
				sale.setUserId(u.getUserId());
				sale.setHall(h.getHallId());
				sale.setMovie(movie.getMovieId());
				sale.setSeatCount(seatCount);
				sale.setNumOfHalfTickets(numOfHalfTickets);
				sale.setSeats(seatSelection);
				sale.setFullTicketPrice(h.getOdcFull());					
				sale.setHalfTicketPrice(h.getOdcHalf());
					
				int numOfFullTickets = (seatCount - numOfHalfTickets);					
				sale.setNumOfFullfTickets(numOfFullTickets);
					
				double total = numOfFullTickets * h.getOdcFull() + numOfHalfTickets * h.getOdcHalf();					
				sale.setTotal(total);
					
				sale.setShowDate(show.getTime());
				sale.setTransactionDate(Calendar.getInstance().getTime());
				Calendar today = Calendar.getInstance();
				
				if(u.getUserType().compareTo(Utility.getCONFG().getProperty(Constants.USER_TYPE_ADMIN)) == 0) {
					
					sale.setPaid(true);
					sale.setOnline(false);
					
					if(today.before(show)){					
						if(SaleDAO.INSTANCE.insertSale(sale)){
							
							resp.setContentType("application/pdf");
							Rectangle pagesize = new Rectangle(Utility.mmToPt(78), Utility.mmToPt(158));	
							
							Document ticket = new Document(pagesize, Utility.mmToPt(5), Utility.mmToPt(5),
									Utility.mmToPt(5), Utility.mmToPt(5)); 
							
							try {
								
								PdfWriter writer = PdfWriter.getInstance(ticket, resp.getOutputStream());
								ticket.open();
								TicketPrinter.printTicket(sale, ticket, movie.getMovieName());
								ticket.close();
								
							} catch (DocumentException e) {
								/*req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
								req.setAttribute("message",Utility.getCONFG().getProperty(Constants.SALE_FAIL));
								req.getRequestDispatcher("/messages.jsp").forward(req, resp);*/
							}							
							
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
						
				} else {
					
					today.add(Calendar.MINUTE, 30);
						
					if(today.before(show)){
						
						sale.setOnline(true);
						
						
						if(SaleDAO.INSTANCE.insertSale(sale)){
							//TODO payment gateway
							resp.setContentType("text/plain");
							resp.setCharacterEncoding("UTF-8");
							
							sale.setPaid(false);
							
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
				}
					
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			
			
		}	
		
	}

	
	
}
