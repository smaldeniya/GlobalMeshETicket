package com.globalmesh.action.sale;

import java.io.IOException;
import java.text.MessageFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.globalmesh.dao.MovieDetailDAO;
import com.globalmesh.dao.SaleDAO;
import com.globalmesh.dao.UserDAO;
import com.globalmesh.dto.MovieDetail;
import com.globalmesh.dto.Sale;
import com.globalmesh.dto.User;
import com.globalmesh.util.Constants;
import com.globalmesh.util.Utility;

public class AfterPaymentServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		String email = (String) session.getAttribute("email");
		
		if(email == null) {
			
			req.setAttribute("msgClass", Constants.MSG_CSS_ERROR);
			req.setAttribute("message",
					Utility.getCONFG()
							.getProperty(Constants.LOGIN_NEED_MESSAGE));
			req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			
		} else {

			Sale sale = (Sale) session.getAttribute("sale");
			session.removeAttribute("sale");
			
			Sale saleDuplicate = SaleDAO.INSTANCE.findDuplicateSale(sale.getShowDate(), 
													sale.getSeats(), sale.getHall(), sale.getUserId(), sale.getMovie());
			if(saleDuplicate != null) {
				req.setAttribute("msgClass", Constants.MSG_CSS_WARNING);
				req.setAttribute("message", Utility.getCONFG().getProperty(Constants.SALE_DUPLICATE_MESSAGE));
				req.getRequestDispatcher("/messages.jsp").forward(req, resp);
			} else {
				
				//TODO check for status of payment. if success persist else send to error page. check for sale null.
				if(true) {
					sale.setPaid(true);
					SaleDAO.INSTANCE.insertSale(sale);
					MovieDetail movie = MovieDetailDAO.INSTANCE.getMovieById(sale.getMovie());
					User u = UserDAO.INSTANCE.getUserById(sale.getUserId());
					
					String emailBody = MessageFormat.format(Utility.getCONFG().getProperty(Constants.SALE_VERI_CODE_EMAIL_BODY), 
							movie.getMovieName(), sale.getShowDate(), sale.getHall(), sale.getVeriFicationCode());
				
					Utility.sendEmail(Utility.getCONFG().getProperty(Constants.SALE_VERI_CODE_EMAIL_SUBJECT), emailBody, u.getEmail(), Utility.getCONFG().getProperty(Constants.SITE_EMAIL));
					
					req.setAttribute("msgClass", Constants.MSG_CSS_SUCCESS);
					req.setAttribute("message", Utility.getCONFG().getProperty(Constants.TICKET_RE_PRINT_SUCCESS));
					req.getRequestDispatcher("/messages.jsp").forward(req, resp);
				} else {
					//TODO custom error message.
				}
			}
			
			
		}
		
	}
	
}
